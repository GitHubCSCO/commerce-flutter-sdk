import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/wish_list_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListUsecase extends BaseUseCase {
  Future<WishListCollectionEntity?> getWishLists({
    int? page,
    WishListSortOrder sortOrder = WishListSortOrder.modifiedOnDescending,
  }) async {
    final result =
        await commerceAPIServiceProvider.getWishListService().getWishLists(
              WishListsQueryParameters(
                sort: sortOrder.value,
                pageSize: CoreConstants.defaultPageSize,
                page: page,
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
}
