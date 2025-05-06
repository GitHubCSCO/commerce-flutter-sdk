import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/settings_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/wish_list_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListUsecase extends BaseUseCase {
  Future<WishListCollectionEntity?> getWishLists({
    int? page,
    WishListSortOrder sortOrder = WishListSortOrder.modifiedOnDescending,
    required String searchText,
  }) async {
    final result =
        await commerceAPIServiceProvider.getWishListService().getWishLists(
              WishListsQueryParameters(
                sort: sortOrder.value,
                pageSize: CoreConstants.defaultPageSize,
                page: page,
                query: searchText != '' ? searchText : null,
                expand: [
                  'top3products',
                  'favorite',
                  'tags',
                ],
                wishListLinesSort: 'mostRecent',
              ),
            );

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListCollectionEntityMapper.toEntity(
                value,
              )
            : null;
      case Failure():
        return null;
    }
  }

  Future<WishListSettingsEntity?> loadWishListSettings() async {
    final result = await commerceAPIServiceProvider
        .getSettingsService()
        .getWishListSettingAsync();

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListSettingsEntityMapper.toEntity(value)
            : null;
      case Failure():
        return null;
    }
  }

  Future<WishListStatus> deleteWishList({
    required String? wishListId,
  }) async {
    if (wishListId.isNullOrEmpty) {
      return WishListStatus.listDeleteFailure;
    }

    final result = await commerceAPIServiceProvider
        .getWishListService()
        .deleteWishList(wishListId!);

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listDeleteSuccess
            : WishListStatus.listDeleteFailure;
      case Failure():
        return WishListStatus.listDeleteFailure;
    }
  }

  Future<WishListStatus> updateWishListFavorite({
    required WishListEntity wishListEntity,
    required bool isFavorite,
  }) async {
    final result = await commerceAPIServiceProvider
        .getWishListService()
        .updateWishList(
          WishListEntityMapper.toModel(
            wishListEntity.copyWith(
              isFavorite: isFavorite,
              wishListLineCollection: [],
            ),
          ),
        );

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listFavoriteUpdateSuccess
            : WishListStatus.listFavoriteUpdateFailure;
      case Failure():
        return WishListStatus.listFavoriteUpdateFailure;
    }
  }

  Future<WishListStatus> updateWishList({
    required WishListEntity wishListEntity,
    required String newName,
    String? newDescription,
  }) async {
    final newWishList = wishListEntity.copyWith(
      name: newName,
      description: newDescription ?? wishListEntity.description,
    );

    final result =
        await commerceAPIServiceProvider.getWishListService().updateWishList(
              WishListEntityMapper.toModel(newWishList),
            );

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listUpdateSuccess
            : WishListStatus.listUpdateFailure;
      case Failure():
        return WishListStatus.listUpdateFailure;
    }
  }

  Future<WishListStatus> createWishList({
    required String name,
    String? description,
  }) async {
    final wishList = WishList(
      name: name,
      description: description,
    );

    final parameter = CreateWishListQueryParameters(
      wishListObj: wishList,
    );

    final result = await commerceAPIServiceProvider
        .getWishListService()
        .createWishList(parameter);

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listCreateSuccess
            : WishListStatus.listCreateFailure;
      case Failure():
        return WishListStatus.listCreateFailure;
    }
  }

  Future<WishListStatus> addToWishList({
    required String? wishListId,
    required WishListAddToCartCollection addToCartCollection,
  }) async {
    if (wishListId.isNullOrEmpty) {
      return WishListStatus.listItemAddToListFailure;
    }

    final result = await commerceAPIServiceProvider
        .getWishListService()
        .addWishListLinesToWishList(
          wishListId!,
          addToCartCollection,
        );

    switch (result) {
      case Success():
        return WishListStatus.listItemAddToListSuccess;
      case Failure():
        return WishListStatus.listItemAddToListFailure;
    }
  }

  Future<WishListStatus> createWishListAndAddToList({
    String? name,
    String? description,
    required WishListAddToCartCollection addToCartCollection,
    bool emptyWishList = false,
  }) async {
    final wishList = WishList(
      name: name,
      description: description,
    );

    final parameter = emptyWishList
        ? CreateWishListQueryParameters()
        : CreateWishListQueryParameters(
            wishListObj: wishList,
          );

    final result = await commerceAPIServiceProvider
        .getWishListService()
        .createWishList(parameter);

    switch (result) {
      case Success(value: final value):
        if (value == null) {
          return WishListStatus.listCreateFailure;
        }

        final addToListResult = await addToWishList(
          wishListId: value.id,
          addToCartCollection: addToCartCollection,
        );
        if (addToListResult == WishListStatus.listItemAddToListSuccess) {
          return WishListStatus.listCreateSuccess;
        } else {
          return WishListStatus.listCreateFailure;
        }
      case Failure():
        return WishListStatus.listCreateFailure;
    }
  }

  Future<WishListStatus> copyWishList({
    required WishListEntity copyFromWishList,
    required String name,
  }) async {
    if (copyFromWishList.id.isNullOrEmpty) {
      return WishListStatus.listCopyFailure;
    }

    final wishList = WishList(
      name: name,
    );

    final parameter = CreateWishListQueryParameters(
      wishListObj: wishList,
    );

    final result = await commerceAPIServiceProvider
        .getWishListService()
        .createWishList(parameter);

    switch (result) {
      case Success(value: final value):
        if (value == null || value.id.isNullOrEmpty) {
          return WishListStatus.listCopyFailure;
        }

        final copyResult = await commerceAPIServiceProvider
            .getWishListService()
            .copyWishListLines(
              value.id!,
              WishListLineCollectionModel(
                wishListLines: [],
              ),
              copyFromWishList.id!,
            );

        switch (copyResult) {
          case Success(value: final value):
            return value != null
                ? WishListStatus.listCopySuccess
                : WishListStatus.listCopyFailure;
          case Failure():
            return WishListStatus.listCopyFailure;
        }

      case Failure():
        return WishListStatus.listCopyFailure;
    }
  }

  Future<WishListStatus> leaveWishList({
    required String? wishListId,
  }) async {
    if (wishListId.isNullOrEmpty) {
      return WishListStatus.listLeaveFailure;
    }

    final result = await commerceAPIServiceProvider
        .getWishListService()
        .leaveWishList(wishListId!);

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listLeaveSuccess
            : WishListStatus.listLeaveFailure;
      case Failure():
        return WishListStatus.listLeaveFailure;
    }
  }

  List<WishListSortOrder> get availableSortOrders => WishListSortOrder.values;

  bool canDeleteWishList({
    required WishListSettingsEntity settings,
    required WishListEntity wishList,
  }) {
    return settings.allowEditingOfWishLists == true &&
        wishList.isSharedList != true &&
        wishList.isAutogenerated != true;
  }
}
