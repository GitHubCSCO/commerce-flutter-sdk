import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_add_to_cart_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/wish_list_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListDetailsUsecase extends BaseUseCase {
  Future<WishListEntity?> loadWishList(String wishListId) async {
    final result =
        await commerceAPIServiceProvider.getWishListService().getWishList(
              wishListId,
              WishListQueryParameters(
                exclude: ['listlines'],
              ),
            );

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
          wishListLineCollection: valueEntity,
          priceParameters: priceParameters,
        );

        final productIds = updatedLines.wishListLines
                ?.map((line) => line.productId ?? '')
                .where((element) => element != '')
                .toList() ??
            [];

        if (productIds.isEmpty) {
          return updatedLines;
        }

        final updatedLinesWithInventory =
            await loadWishListLinesWithRealTimeInventory(
          wishListLineCollection: updatedLines,
          productIds: productIds,
        );

        return updatedLinesWithInventory;

      case Failure():
        return null;
    }
  }

  Future<WishListLineCollectionEntity> loadWishListLinesWithRealTimePricing({
    required WishListLineCollectionEntity wishListLineCollection,
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
            wishListLineCollection.wishListLines ?? <WishListLineEntity>[];
        final newLines = lines.map((line) {
          final realTimePrice = realTimePrices?.realTimePricingResults
              ?.firstWhere((element) => element.productId == line.productId,
                  orElse: () => ProductPrice());

          return line.copyWith(
            pricing: realTimePrice != null
                ? ProductPriceEntityMapper().toEntity(realTimePrice)
                : line.pricing,
          );
        }).toList();

        return wishListLineCollection.copyWith(wishListLines: newLines);
      case Failure():
        return wishListLineCollection;
    }
  }

  Future<WishListLineCollectionEntity> loadWishListLinesWithRealTimeInventory({
    required WishListLineCollectionEntity wishListLineCollection,
    required List<String> productIds,
  }) async {
    final realTimeInventoryResult = await commerceAPIServiceProvider
        .getRealTimeInventoryService()
        .getProductRealTimeInventory(
          parameters: RealTimeInventoryParameters(
            productIds: productIds,
          ),
        );

    switch (realTimeInventoryResult) {
      case Success(value: final realTimeInventory):
        final lines =
            wishListLineCollection.wishListLines ?? <WishListLineEntity>[];
        final newLines = lines.map(
          (line) {
            final realTimeInventoryItem = realTimeInventory
                ?.realTimeInventoryResults
                ?.firstWhere((element) => element.productId == line.productId,
                    orElse: () => ProductInventory());

            if (realTimeInventoryItem == null) {
              return line.copyWith(
                availability: const AvailabilityEntity(messageType: 0),
              );
            }

            final inventoryAvailablility =
                realTimeInventoryItem.inventoryAvailabilityDtos?.singleWhere(
              (element) => element.unitOfMeasure == line.unitOfMeasure,
              orElse: () => InventoryAvailability(
                availability: Availability(messageType: 0),
              ),
            );

            if (inventoryAvailablility == null) {
              return line.copyWith(
                availability: const AvailabilityEntity(messageType: 0),
              );
            }

            return line.copyWith(
              availability: AvailabilityEntityMapper()
                  .toEntity(inventoryAvailablility.availability),
            );
          },
        ).toList();

        return wishListLineCollection.copyWith(wishListLines: newLines);
      case Failure():
        return wishListLineCollection.copyWith(
          wishListLines: wishListLineCollection.wishListLines?.map(
            (line) {
              return line.copyWith(
                availability: const AvailabilityEntity(messageType: 0),
              );
            },
          ).toList(),
        );
    }
  }

  Future<WishListAddToCartStatus> addWishListToCart(
    WishListEntity wishListEntity,
  ) async {
    final result = await commerceAPIServiceProvider
        .getCartService()
        .addWishListToCart(wishListEntity.id ?? '');

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListAddToCartStatus.success
            : WishListAddToCartStatus.failure;
      case Failure(errorResponse: final errorResponse):
        switch (errorResponse.message) {
          case 'Cloudflare gateway timeout':
          case 'Connection timeout':
            return WishListAddToCartStatus.failureTimeOut;
          default:
            return WishListAddToCartStatus.failure;
        }
    }
  }

  List<WishListLineSortOrder> get availableSortOrders =>
      WishListLineSortOrder.values;
}
