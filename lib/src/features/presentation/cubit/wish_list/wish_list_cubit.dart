import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final WishListUsecase wishListUsecase;
  WishListCubit({required this.wishListUsecase})
      : super(
          const WishListState(
            sortOrder: WishListSortOrder.modifiedOnDescending,
            status: WishListStatus.initial,
            wishLists: WishListCollectionEntity(),
            searchQuery: '',
            settings: WishListSettingsEntity(),
            fromCreatedDate: null,
            toCreatedDate: null,
            fromUpdatedOn: null,
            toUpdatedOn: null,
            product: null,
            brand: null,
            sharedByUser: null,
          ),
        );

  bool get noWishListFound =>
      state.status == WishListStatus.success &&
      state.wishLists.wishListCollection?.isEmpty == true;

  List<WishListSortOrder> get availableSortOrders =>
      wishListUsecase.availableSortOrders;

  Future<void> changeSortOrder(WishListSortOrder sortOrder) async {
    emit(
      state.copyWith(
        sortOrder: sortOrder,
      ),
    );

    final analyticsEvent = AnalyticsEvent(
      AnalyticsConstants.eventSort,
      AnalyticsConstants.screenNameSortSelection,
    )
        .withProperty(
          name: AnalyticsConstants.eventPropertyReferenceType,
          strValue: AnalyticsConstants.screenNameLists,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertySortOption,
          strValue: sortOrder.value,
        );

    wishListUsecase.trackEvent(analyticsEvent);

    final telemetryEvent = TelemetryEvent(
      eventName: AnalyticsConstants.eventSort,
    )
        .withProperty(
          name: AnalyticsConstants.eventPropertyReferenceType,
          strValue: AnalyticsConstants.screenNameLists,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertySortOption,
          strValue: sortOrder.value,
        );

    wishListUsecase.trackTelemetryEvent(telemetryEvent);

    await loadWishLists(
      brand: state.brand,
      product: state.product,
      sharedByUser: state.sharedByUser,
      fromCreatedDate: state.fromCreatedDate,
      toCreatedDate: state.toCreatedDate,
      fromUpdatedOn: state.fromUpdatedOn,
      toUpdatedOn: state.toUpdatedOn,
    );
  }

  void cancelSort() {
    final analyticsEvent = AnalyticsEvent(
      AnalyticsConstants.eventCancelSort,
      AnalyticsConstants.screenNameSortSelection,
    ).withProperty(
      name: AnalyticsConstants.eventPropertyReferenceType,
      strValue: AnalyticsConstants.screenNameLists,
    );

    wishListUsecase.trackEvent(analyticsEvent);

    final telemetryEvent = TelemetryEvent(
      eventName: AnalyticsConstants.eventCancelSort,
    ).withProperty(
      name: AnalyticsConstants.eventPropertyReferenceType,
      strValue: AnalyticsConstants.screenNameLists,
    );

    wishListUsecase.trackTelemetryEvent(telemetryEvent);
  }

  Future<void> loadWishLists({
    bool skipRecentlyPurchased = false,
    DateTime? fromCreatedDate,
    DateTime? toCreatedDate,
    DateTime? fromUpdatedOn,
    DateTime? toUpdatedOn,
    WishListFilterItemEntity? product,
    WishListFilterItemEntity? brand,
    WishListFilterItemEntity? sharedByUser,
  }) async {
    emit(state.copyWith(status: WishListStatus.loading));

    final settings = await wishListUsecase.loadWishListSettings();

    final result = await wishListUsecase.getWishLists(
      sortOrder: state.sortOrder,
      page: 1,
      searchText: state.searchQuery,
      fromCreatedDate: fromCreatedDate,
      toCreatedDate: toCreatedDate,
      fromUpdatedOn: fromUpdatedOn,
      toUpdatedOn: toUpdatedOn,
      erpNumber: product?.actualValue,
      brandId: brand?.actualValue,
      sharedBy: sharedByUser?.actualValue,
    );

    if (skipRecentlyPurchased) {
      result?.wishListCollection?.removeWhere(
        (element) => element.isAutogenerated == true,
      );
    }

    result != null && settings != null
        ? emit(
            WishListState(
              wishLists: result,
              status: WishListStatus.success,
              sortOrder: state.sortOrder,
              searchQuery: state.searchQuery,
              settings: settings,
              fromCreatedDate: fromCreatedDate,
              toCreatedDate: toCreatedDate,
              fromUpdatedOn: fromUpdatedOn,
              toUpdatedOn: toUpdatedOn,
              product: product,
              brand: brand,
              sharedByUser: sharedByUser,
            ),
          )
        : emit(state.copyWith(status: WishListStatus.failure));

    if (state.searchQuery.isNotEmpty) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventViewSearchResults,
        AnalyticsConstants.screenNameLists,
      )
          .withProperty(
            name: AnalyticsConstants.eventPropertySearchTerm,
            strValue: state.searchQuery,
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertyResultsCount,
            strValue: result?.pagination?.totalItemCount.toString() ?? '0',
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertySuccessful,
            boolValue: result != null,
          );

      wishListUsecase.trackEvent(analyticsEvent);

      var viewScreenTelemetry = TelemetryEvent(
        eventName: AnalyticsConstants.eventViewSearchResults,
      )
          .withProperty(
            name: AnalyticsConstants.eventPropertySearchTerm,
            strValue: state.searchQuery,
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertyResultsCount,
            strValue: result?.pagination?.totalItemCount.toString() ?? '0',
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertySuccessful,
            boolValue: result != null,
          );
      wishListUsecase.trackTelemetryEvent(viewScreenTelemetry);
    }
  }

  Future<void> searchQueryChanged(String query) async {
    emit(state.copyWith(searchQuery: query));
    await loadWishLists();
  }

  Future<void> loadMoreWishlists({bool skipAutoGenerated = false}) async {
    if (state.wishLists.pagination?.page == null ||
        state.wishLists.pagination!.page! + 1 >
            state.wishLists.pagination!.numberOfPages! ||
        state.status == WishListStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(status: WishListStatus.moreLoading));
    final result = await wishListUsecase.getWishLists(
      page: state.wishLists.pagination!.page! + 1,
      sortOrder: state.sortOrder,
      searchText: state.searchQuery,
      fromCreatedDate: state.fromCreatedDate,
      toCreatedDate: state.toCreatedDate,
      fromUpdatedOn: state.fromUpdatedOn,
      toUpdatedOn: state.toUpdatedOn,
      erpNumber: state.product?.actualValue,
      brandId: state.brand?.actualValue,
      sharedBy: state.sharedByUser?.actualValue,
    );

    if (result == null) {
      emit(state.copyWith(status: WishListStatus.moreLoadingFailure));
      return;
    }

    final newWishLists = state.wishLists.wishListCollection;
    newWishLists?.addAll(result.wishListCollection!);

    if (skipAutoGenerated) {
      newWishLists?.removeWhere(
        (element) => element.isAutogenerated == true,
      );
    }

    emit(
      state.copyWith(
        wishLists: state.wishLists.copyWith(
          wishListCollection: newWishLists,
          pagination: result.pagination,
        ),
        status: WishListStatus.success,
      ),
    );
  }

  Future<void> deleteWishList({required String? wishListId}) async {
    emit(state.copyWith(status: WishListStatus.listDeleteLoading));
    final result = await wishListUsecase.deleteWishList(
      wishListId: wishListId,
    );

    if (result == WishListStatus.listDeleteSuccess) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventDeleteList,
        AnalyticsConstants.screenNameLists,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: wishListId,
      );

      wishListUsecase.trackEvent(analyticsEvent);

      final telemetryEvent = TelemetryEvent(
        eventName: AnalyticsConstants.eventDeleteList,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: wishListId,
      );

      wishListUsecase.trackTelemetryEvent(telemetryEvent);
    }

    emit(state.copyWith(status: result));
  }

  Future<void> toggleWishListFavorite({
    required WishListEntity wishList,
  }) async {
    emit(state.copyWith(status: WishListStatus.listFavoriteUpdateLoading));

    final result = await wishListUsecase.updateWishListFavorite(
      wishListEntity: wishList,
      isFavorite: !(wishList.isFavorite == true),
    );

    if (result == WishListStatus.listFavoriteUpdateSuccessAdded ||
        result == WishListStatus.listFavoriteUpdateSuccessRemoved) {
      final analyticsEvent = AnalyticsEvent(
        wishList.isFavorite == true
            ? AnalyticsConstants.eventRemoveFavoriteList
            : AnalyticsConstants.eventFavoriteList,
        AnalyticsConstants.screenNameLists,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: wishList.id,
      );

      wishListUsecase.trackEvent(analyticsEvent);

      final telemetryEvent = TelemetryEvent(
        eventName: wishList.isFavorite == true
            ? AnalyticsConstants.eventRemoveFavoriteList
            : AnalyticsConstants.eventFavoriteList,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: wishList.id,
      );

      wishListUsecase.trackTelemetryEvent(telemetryEvent);

      final newCollection = state.wishLists.wishListCollection?.map(
        (item) {
          if (item.id != wishList.id) {
            return item;
          }
          return item.copyWith(
            isFavorite: !(item.isFavorite == true),
          );
        },
      ).toList();

      emit(
        state.copyWith(
          status: result,
          wishLists: state.wishLists.copyWith(
            wishListCollection: newCollection,
          ),
        ),
      );

      return;
    }

    emit(state.copyWith(status: result));
  }

  bool canDeleteWishList({required WishListEntity wishList}) {
    return wishListUsecase.canDeleteWishList(
      settings: state.settings,
      wishList: wishList,
    );
  }

  int get totalWishListCount => state.wishLists.pagination?.totalItemCount ?? 0;

  /// Returns the count of active filters applied to the wish list.
  /// Counts date filters (created/updated), product, brand, and shared by user filters.
  /// String filters are considered active only if they are non-empty.
  int get filterCount => [
        state.fromCreatedDate,
        state.toCreatedDate,
        state.fromUpdatedOn,
        state.toUpdatedOn,
        state.product?.actualValue,
        state.brand?.actualValue,
        state.sharedByUser?.actualValue
      ]
          .where((filter) =>
              filter != null && (filter is! String || filter.isNotEmpty))
          .length;

  String get listCountText =>
      '${totalWishListCount.toString()}  ${totalWishListCount != 1 ? LocalizationConstants.lists.localized() : LocalizationConstants.list.localized()}';
}
