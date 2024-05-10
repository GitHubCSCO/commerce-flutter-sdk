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

  List<WishListSortOrder> get availableSortOrders => WishListSortOrder.values;

  bool canDeleteWishList({
    required WishListSettingsEntity settings,
    required WishListEntity wishList,
  }) {
    return settings.allowEditingOfWishLists == true &&
        wishList.isSharedList != true;
  }
}
