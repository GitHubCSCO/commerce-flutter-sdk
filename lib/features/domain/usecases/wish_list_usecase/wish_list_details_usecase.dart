import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
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
        if (value == null) {
          return null;
        }

        final valueEntity = WishListLineCollectionEntityMapper.toEntity(value);
        final priceParameters = value.wishListLines
                ?.map(
                  (line) => ProductPriceQueryParameter(
                    productId: line.productId,
                    qtyOrdered: line.qtyOrdered,
                    unitOfMeasure: line.unitOfMeasure,
                  ),
                )
                .toList() ??
            [];

        if (priceParameters.isEmpty) {
          return valueEntity;
        }

        final updatedLines = await loadWishListLinesWithRealTimePricing(
          wishListLineColelction: valueEntity,
          priceParameters: priceParameters,
        );

        return updatedLines;

      case Failure():
        return null;
    }
  }

  Future<WishListLineCollectionEntity> loadWishListLinesWithRealTimePricing({
    required WishListLineCollectionEntity wishListLineColelction,
    required List<ProductPriceQueryParameter> priceParameters,
  }) async {
    final realTimePricesResult = await commerceAPIServiceProvider
        .getRealTimePricingService()
        .getProductRealTimePrices(
          RealTimePricingParameters(
            productPriceParameters: priceParameters,
          ),
        );

    switch (realTimePricesResult) {
      case Success(value: final realTimePrices):
        final lines =
            wishListLineColelction.wishListLines ?? <WishListLineEntity>[];
        final newLines = lines.map((line) {
          final realTimePrice = realTimePrices?.realTimePricingResults
              ?.firstWhere((element) => element.productId == line.productId);

          return line.copyWith(
            pricing: realTimePrice != null
                ? ProductPriceEntityMapper().toEntity(realTimePrice)
                : null,
          );
        }).toList();

        return wishListLineColelction.copyWith(wishListLines: newLines);
      case Failure():
        return wishListLineColelction;
    }
  }

  List<WishListLineSortOrder> get availableSortOrders =>
      WishListLineSortOrder.values;
}
