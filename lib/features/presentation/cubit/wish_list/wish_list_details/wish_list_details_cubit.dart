import 'dart:async';

import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
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
    ]);

    siteMessageMobileAppAlertCommunicationError = futureResult[0];
    siteMessageWishListNoProducts = futureResult[1];
    siteMessageDealerLocatorNoResults = futureResult[2];
    siteMessageAddToCartFailed = futureResult[3];
    siteMessageAddToCartSuccess = futureResult[4];

    return;
  }

  Future<void> changeSortOrder(WishListLineSortOrder sortOrder) async {
    emit(
      state.copyWith(
        sortOrder: sortOrder,
      ),
    );

    await loadWishListLines(state.wishList);
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
  }

  Future<void> deleteWishListLine(WishListLineEntity wishListLine) async {
    final result = await _wishListDetailsUsecase.deleteWishListLine(
      wishListEntity: state.wishList,
      wishListLineEntity: wishListLine,
    );

    emit(state.copyWith(status: result));
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
    } else {
      emit(state.copyWith(status: result));
    }
  }

  Future<void> deleteWishList() async {
    emit(state.copyWith(status: WishListStatus.listDeleteLoading));
    final result = await _wishListDetailsUsecase.deleteWishList(
      wishListId: state.wishList.id,
    );

    emit(state.copyWith(status: result));
  }

  Future<void> copyWishList({required String name}) async {
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
  }

  bool canDeleteWishList({required WishListEntity wishList}) {
    return _wishListDetailsUsecase.canDeleteWishList(
      settings: state.settings,
      wishList: wishList,
    );
  }

  Future<String> getSiteMessage(
      String messageName, String defaultMessage) async {
    return await _wishListDetailsUsecase.getSiteMessage(
        messageName, defaultMessage);
  }
}
