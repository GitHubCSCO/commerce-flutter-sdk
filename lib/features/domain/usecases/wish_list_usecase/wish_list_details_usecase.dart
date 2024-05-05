import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/wish_list_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListDetailsUsecase extends BaseUseCase {
  Future<WishListEntity?> loadWishList(String wishListId) async {
    final result = await commerceAPIServiceProvider
        .getWishListService()
        .getWishList(wishListId, WishListQueryParameters());

    switch (result) {
      case Success(value: final value):
        return value != null ? WishListEntityMapper.toEntity(value) : null;
      case Failure():
        return null;
    }
  }

  Future<WishListLineCollectionEntity?> loadWishListLines({
    required WishListEntity wishListEntity,
    int page = 1,
    WishListLineSortOrder sortOrder = WishListLineSortOrder.customSort,
    String searchText = '',
  }) async {
    final result =
        await commerceAPIServiceProvider.getWishListService().getWishListLines(
              wishListEntity.id ?? '',
              WishListLineQueryParameters(
                sort: sortOrder.value,
                pageSize: CoreConstants.defaultPageSize,
                defaultPageSize: CoreConstants.defaultPageSize,
                page: page,
                query: searchText != '' ? searchText : null,
              ),
            );

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListLineCollectionEntityMapper.toEntity(value)
            : null;
      case Failure():
        return null;
    }
  }

  List<WishListLineSortOrder> get availableSortOrders =>
      WishListLineSortOrder.values;
}
