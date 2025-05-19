import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_details_state.dart';

class WishListDetailsCubit extends Cubit<WishListDetailsState> {
  final WishListDetailsUsecase _wishListDetailsUsecase;

  WishListDetailsCubit({required WishListDetailsUsecase wishListDetailsUsecase})
      : _wishListDetailsUsecase = wishListDetailsUsecase,
        super(
          const WishListDetailsState(
            wishList: WishListEntity(),
            wishListLines: WishListLineCollectionEntity(),
            status: WishListStatus.initial,
            sortOrder: WishListLineSortOrder.customSort,
            settings: WishListSettingsEntity(),
            searchQuery: '',
          ),
        );

  bool get emptyWishList =>
      state.status != WishListStatus.failure &&
      state.status != WishListStatus.initial &&
      state.status != WishListStatus.loading &&
      state.searchQuery.isNullOrEmpty &&
      (state.wishListLines.pagination?.totalItemCount ?? 0) == 0;

  bool get noSearchResult =>
      (state.wishListLines.pagination?.totalItemCount ?? 0) == 0 &&
      state.searchQuery.isNullOrEmpty == false;

  String siteMessageMobileAppAlertCommunicationError =
      SiteMessageConstants.defaultMobileAppAlertCommunicationError;
  String siteMessageWishListNoProducts =
      SiteMessageConstants.defaultValueWishListNoProducts;
  String siteMessageDealerLocatorNoResults =
      SiteMessageConstants.defaultDealerLocatorNoResultsMessage;
  String siteMessageAddToCartFailed =
      SiteMessageConstants.defaultDealerLocatorNoResultsMessage;
  String siteMessageAddToCartSuccess =
      SiteMessageConstants.defaultDealerLocatorNoResultsMessage;
  String siteMessageNotAllAddedToCart =
      SiteMessageConstants.defaultValueWishListNotAllAddedToCart;

  List<WishListLineSortOrder> get availableSortOrders =>
      _wishListDetailsUsecase.listLineAvailableSortOrders;

  Future<void> _loadSiteMessages() async {
    final futureResult = await Future.wait([
      _wishListDetailsUsecase.getSiteMessage(
        SiteMessageConstants.nameMobileAppAlertCommunicationError,
        SiteMessageConstants.defaultMobileAppAlertCommunicationError,
      ),
      _wishListDetailsUsecase.getSiteMessage(
        SiteMessageConstants.nameWishListNoProducts,
        SiteMessageConstants.defaultValueWishListNoProducts,
      ),
      _wishListDetailsUsecase.getSiteMessage(
        SiteMessageConstants.nameDealerLocatorNoResultsMessage,
        SiteMessageConstants.defaultDealerLocatorNoResultsMessage,
      ),
      _wishListDetailsUsecase.getSiteMessage(
        SiteMessageConstants.nameAddToCartFail,
        SiteMessageConstants.defaultValueAddToCartFail,
      ),
      _wishListDetailsUsecase.getSiteMessage(
        SiteMessageConstants.nameAddToCartSuccess,
        SiteMessageConstants.defaultValueAddToCartSuccess,
      ),
      _wishListDetailsUsecase.getSiteMessage(
        SiteMessageConstants.nameWishListNotAllAddedToCart,
        SiteMessageConstants.defaultValueWishListNotAllAddedToCart,
      ),
    ]);

    siteMessageMobileAppAlertCommunicationError = futureResult[0];
    siteMessageWishListNoProducts = futureResult[1];
    siteMessageDealerLocatorNoResults = futureResult[2];
    siteMessageAddToCartFailed = futureResult[3];
    siteMessageAddToCartSuccess = futureResult[4];
    siteMessageNotAllAddedToCart = futureResult[5];

    return;
  }

  Future<void> changeSortOrder(WishListLineSortOrder sortOrder) async {
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
          name: AnalyticsConstants.eventPropertyReferenceId,
          strValue: state.wishList.id,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertyReferenceName,
          strValue: state.wishList.name,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertyReferenceType,
          strValue: AnalyticsConstants.screenNameListDetail,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertySortOption,
          strValue: sortOrder.value,
        );

    _wishListDetailsUsecase.trackEvent(analyticsEvent);

    await loadWishListLines(state.wishList);
  }

  void cancelSort() {
    final analyticsEvent = AnalyticsEvent(
      AnalyticsConstants.eventCancelSort,
      AnalyticsConstants.screenNameSortSelection,
    )
        .withProperty(
          name: AnalyticsConstants.eventPropertyReferenceId,
          strValue: state.wishList.id,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertyReferenceName,
          strValue: state.wishList.name,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertyReferenceType,
          strValue: AnalyticsConstants.screenNameListDetail,
        );

    _wishListDetailsUsecase.trackEvent(analyticsEvent);
  }

  Future<void> searchQueryChanged(String query) async {
    emit(state.copyWith(searchQuery: query));
    await loadWishListLines(state.wishList);
  }

  Future<void> loadWishListDetails(String id) async {
    emit(state.copyWith(status: WishListStatus.loading));

    final wishListRelatedData = await Future.wait([
      _wishListDetailsUsecase.loadWishList(id),
      _wishListDetailsUsecase.loadWishListSettings(),
      _loadSiteMessages(),
    ]);

    final wishList = wishListRelatedData[0] as WishListEntity?;
    final settings = wishListRelatedData[1] as WishListSettingsEntity?;

    if (wishList == null || settings == null) {
      emit(state.copyWith(status: WishListStatus.failure));
      return;
    }

    emit(state.copyWith(settings: settings));

    await loadWishListLines(wishList);
  }

  Future<void> loadWishListLines(WishListEntity wishList) async {
    if (state.status != WishListStatus.loading) {
      emit(state.copyWith(status: WishListStatus.loading));
    }

    final wishListLines = await _wishListDetailsUsecase.loadWishListLines(
      wishListEntity: wishList,
      page: 1,
      sortOrder: state.sortOrder,
      searchText: state.searchQuery,
    );

    final hasCheckout = await _wishListDetailsUsecase.hasCheckout();

    final canAddWishListToCart =
        hasCheckout && (wishList.canAddAllToCart ?? false);

    if (wishListLines != null) {
      emit(
        WishListDetailsState(
          searchQuery: state.searchQuery,
          sortOrder: state.sortOrder,
          wishList: wishList,
          wishListLines: wishListLines,
          status: WishListStatus.realTimeAttributesLoading,
          settings: state.settings,
          canAddWishListToCart: canAddWishListToCart,
        ),
      );

      final realTimeLoadedWishListLines =
          await _wishListDetailsUsecase.loadRealTimeAttributes(
              wishListLines: wishListLines.wishListLines ?? []);

      emit(
        state.copyWith(
          wishListLines: state.wishListLines.copyWith(
            wishListLines: realTimeLoadedWishListLines,
          ),
          status: WishListStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(status: WishListStatus.failure));
    }

    if (state.searchQuery.isNotEmpty) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventViewSearchResults,
        AnalyticsConstants.screenNameListDetail,
      )
          .withProperty(
            name: AnalyticsConstants.eventPropertySearchTerm,
            strValue: state.searchQuery,
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertyReferenceId,
            strValue: wishList.id ?? '',
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertyReferenceName,
            strValue: wishList.name ?? '',
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertyResultsCount,
            strValue:
                wishListLines?.pagination?.totalItemCount?.toString() ?? '0',
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertySuccessful,
            boolValue: wishListLines != null,
          );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);
    }
  }

  Future<void> loadMoreWishListLines() async {
    if (state.wishListLines.pagination?.page == null ||
        state.wishListLines.pagination!.page! + 1 >
            state.wishListLines.pagination!.numberOfPages! ||
        state.status == WishListStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(status: WishListStatus.moreLoading));
    final result = await _wishListDetailsUsecase.loadWishListLines(
      wishListEntity: state.wishList,
      page: state.wishListLines.pagination!.page! + 1,
      sortOrder: state.sortOrder,
      searchText: state.searchQuery,
    );

    if (result == null) {
      emit(state.copyWith(status: WishListStatus.moreLoadingFailure));
      return;
    }

    final realTimeLoadedWishListLines = await _wishListDetailsUsecase
        .loadRealTimeAttributes(wishListLines: result.wishListLines ?? []);

    final newWishListLines = state.wishListLines.wishListLines;
    newWishListLines?.addAll(realTimeLoadedWishListLines);

    emit(
      state.copyWith(
        wishListLines: state.wishListLines.copyWith(
          wishListLines: newWishListLines,
          pagination: result.pagination,
        ),
        status: WishListStatus.success,
      ),
    );
  }

  Future<void> addWishListToCart({bool ignoreOutOfStock = false}) async {
    if (state.wishList.id != null &&
        state.wishList.canAddAllToCart != true &&
        !ignoreOutOfStock) {
      emit(state.copyWith(
          status: WishListStatus.listAddToCartFailureOutOfStock));
      return;
    }

    emit(state.copyWith(status: WishListStatus.listAddToCartLoading));

    final result = await _wishListDetailsUsecase.addWishListToCart(
      state.wishList,
    );

    emit(state.copyWith(status: result));

    if (result == WishListStatus.listAddToCartSuccess ||
        result == WishListStatus.listAddToCartPartialSuccess) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventAddListToCart,
        AnalyticsConstants.screenNameListDetail,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: state.wishList.id,
      );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);
    }
  }

  Future<void> updateWishListLineQuantity(
    WishListLineEntity wishListLine,
    int quantity,
  ) async {
    final modifiedWishListLine = wishListLine.copyWith(qtyOrdered: quantity);
    final modificationResult = await _wishListDetailsUsecase.updateWishListLine(
      wishListId: state.wishList.id ?? '',
      wishListLineEntity: modifiedWishListLine,
    );

    emit(state.copyWith(status: WishListStatus.realTimeAttributesLoading));

    if (modificationResult == null) {
      final message = siteMessageMobileAppAlertCommunicationError;
      emit(state.copyWith(
          status: WishListStatus.errorModification, message: message));
      return;
    }

    final realTimeLoadedList = await _wishListDetailsUsecase
        .loadRealTimeAttributes(wishListLines: [modificationResult]);

    final newWishListLines = state.wishListLines.wishListLines?.map((line) {
      if (line.id == realTimeLoadedList.first.id) {
        return realTimeLoadedList.first;
      }
      return line;
    }).toList();

    emit(
      state.copyWith(
        wishListLines: state.wishListLines.copyWith(
          wishListLines: newWishListLines,
        ),
        status: WishListStatus.success,
      ),
    );
  }

  Future<void> addWishListLineToCart(WishListLineEntity wishListLine) async {
    emit(state.copyWith(status: WishListStatus.listLineAddToCartLoading));
    final result = await _wishListDetailsUsecase.addWishListLineToCart(
      wishListLineEntity: wishListLine,
    );

    emit(state.copyWith(status: result));

    if (result == WishListStatus.listLineAddToCartSuccess) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventAddToCart,
        AnalyticsConstants.screenNameListDetail,
      )
          .withProperty(
            name: AnalyticsConstants.eventPropertyListId,
            strValue: state.wishList.id,
          )
          .withProperty(
            name: AnalyticsConstants.eventPropertyProductNumber,
            strValue: wishListLine.erpNumber,
          );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);
    }
  }

  Future<void> deleteWishListLine(WishListLineEntity wishListLine) async {
    final result = await _wishListDetailsUsecase.deleteWishListLine(
      wishListEntity: state.wishList,
      wishListLineEntity: wishListLine,
    );

    emit(state.copyWith(status: result));

    if (result == WishListStatus.listLineDeleteSuccess) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventDeleteProduct,
        AnalyticsConstants.screenNameListDetail,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: state.wishList.id,
      );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);
    }
  }

  Future<void> renameWishList(String newName) async {
    emit(state.copyWith(status: WishListStatus.listRenameLoading));
    final result = await _wishListDetailsUsecase.updateWishList(
      wishListEntity: state.wishList,
      newName: newName,
    );

    if (result == WishListStatus.listUpdateSuccess) {
      emit(state.copyWith(
        wishList: state.wishList.copyWith(name: newName),
        status: result,
      ));

      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventRenameList,
        AnalyticsConstants.screenNameListDetail,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: state.wishList.id,
      );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);
    } else {
      emit(state.copyWith(status: result));
    }
  }

  Future<void> deleteWishList() async {
    emit(state.copyWith(status: WishListStatus.listDeleteLoading));
    final result = await _wishListDetailsUsecase.deleteWishList(
      wishListId: state.wishList.id,
    );

    if (result == WishListStatus.listDeleteSuccess) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventDeleteList,
        AnalyticsConstants.screenNameListDetail,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: state.wishList.id,
      );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);
    }

    emit(state.copyWith(status: result));
  }

  Future<void> copyWishList({required String name}) async {
    final analyticsEvent = AnalyticsEvent(
      AnalyticsConstants.eventCopyList,
      AnalyticsConstants.screenNameListDetail,
    ).withProperty(
      name: AnalyticsConstants.eventPropertyListId,
      strValue: state.wishList.id,
    );

    _wishListDetailsUsecase.trackEvent(analyticsEvent);

    emit(state.copyWith(status: WishListStatus.listCopyLoading));
    final result = await _wishListDetailsUsecase.copyWishList(
      copyFromWishList: state.wishList,
      name: name,
    );

    emit(state.copyWith(status: result));
  }

  Future<void> leaveWishList() async {
    emit(state.copyWith(status: WishListStatus.listLeaveLoading));
    final result = await _wishListDetailsUsecase.leaveWishList(
      wishListId: state.wishList.id,
    );

    emit(state.copyWith(status: result));

    if (result == WishListStatus.listLeaveSuccess) {
      final analyticsEvent = AnalyticsEvent(
        AnalyticsConstants.eventLeaveList,
        AnalyticsConstants.screenNameListDetail,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: state.wishList.id,
      );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);
    }
  }

  bool canDeleteWishList({required WishListEntity wishList}) {
    return _wishListDetailsUsecase.canDeleteWishList(
      settings: state.settings,
      wishList: wishList,
    );
  }

  Future<String> getSiteMessage(
      String messageName, String defaultMessage) async {
    return _wishListDetailsUsecase.getSiteMessage(messageName, defaultMessage);
  }

  Future<void> toggleWishListFavorite() async {
    emit(state.copyWith(status: WishListStatus.listFavoriteUpdateLoading));

    final result = await _wishListDetailsUsecase.updateWishListFavorite(
      wishListEntity: state.wishList,
      isFavorite: state.wishList.isFavorite != true,
    );

    if (result == WishListStatus.listFavoriteUpdateSuccessAdded ||
        result == WishListStatus.listFavoriteUpdateSuccessRemoved) {
      final analyticsEvent = AnalyticsEvent(
        state.wishList.isFavorite == true
            ? AnalyticsConstants.eventRemoveFavoriteList
            : AnalyticsConstants.eventFavoriteList,
        AnalyticsConstants.screenNameListDetail,
      ).withProperty(
        name: AnalyticsConstants.eventPropertyListId,
        strValue: state.wishList.id,
      );

      _wishListDetailsUsecase.trackEvent(analyticsEvent);

      emit(
        state.copyWith(
          status: result,
          wishList: state.wishList.copyWith(
            isFavorite: !(state.wishList.isFavorite == true),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(status: result));
  }
}
