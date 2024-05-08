import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
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

        final wishListLineCollection =
            WishListLineCollectionEntityMapper.toEntity(value);

        return wishListLineCollection;

      case Failure():
        return null;
    }
  }

  Future<List<WishListLineEntity>> loadRealTimeAttributes({
    required List<WishListLineEntity> wishListLines,
  }) async {
    final realTimeAttributes = Future.wait([
      loadRealTimePricing(wishListLines: wishListLines),
      loadRealTimeInventory(wishListLines: wishListLines),
    ]);

    final results = await realTimeAttributes;
    return List.generate(wishListLines.length, (index) {
      return wishListLines[index].copyWith(
        pricing: results[0][index].pricing,
        availability: results[1][index].availability,
      );
    });
  }

  Future<List<WishListLineEntity>> loadRealTimePricing({
    required List<WishListLineEntity> wishListLines,
  }) async {
    final priceParameters = wishListLines
        .map(
          (line) => ProductPriceQueryParameter(
            productId: line.productId,
            qtyOrdered: line.qtyOrdered,
            unitOfMeasure: line.unitOfMeasure,
          ),
        )
        .toList();

    if (priceParameters.isEmpty) {
      return wishListLines;
    }

    final realTimePricesResult = await commerceAPIServiceProvider
        .getRealTimePricingService()
        .getProductRealTimePrices(
          RealTimePricingParameters(
            productPriceParameters: priceParameters,
          ),
        );

    switch (realTimePricesResult) {
      case Success(value: final realTimePrices):
        final newLines = wishListLines.map((line) {
          final realTimePrice = realTimePrices?.realTimePricingResults
              ?.firstWhere((element) => element.productId == line.productId,
                  orElse: () => ProductPrice());

          return line.copyWith(
            pricing: realTimePrice != null
                ? ProductPriceEntityMapper().toEntity(realTimePrice)
                : line.pricing,
          );
        }).toList();

        return newLines;
      case Failure():
        return wishListLines;
    }
  }

  Future<List<WishListLineEntity>> loadRealTimeInventory({
    required List<WishListLineEntity> wishListLines,
  }) async {
    final productIds = wishListLines
        .map((line) => line.productId ?? '')
        .where((element) => element != '')
        .toList();

    if (productIds.isEmpty) {
      return wishListLines;
    }

    final realTimeInventoryResult = await commerceAPIServiceProvider
        .getRealTimeInventoryService()
        .getProductRealTimeInventory(
          parameters: RealTimeInventoryParameters(
            productIds: productIds,
          ),
        );

    switch (realTimeInventoryResult) {
      case Success(value: final realTimeInventory):
        final newLines = wishListLines.map(
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

        return newLines;
      case Failure():
        return wishListLines.map(
          (line) {
            return line.copyWith(
              availability: const AvailabilityEntity(messageType: 0),
            );
          },
        ).toList();
    }
  }

  Future<WishListStatus> addWishListToCart(
    WishListEntity wishListEntity,
  ) async {
    final result = await commerceAPIServiceProvider
        .getCartService()
        .addWishListToCart(wishListEntity.id ?? '');

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listAddToCartSuccess
            : WishListStatus.listAddToCartFailure;
      case Failure(errorResponse: final errorResponse):
        switch (errorResponse.message) {
          case 'Cloudflare gateway timeout':
          case 'Connection timeout':
            return WishListStatus.listAddToCartFailureTimeOut;
          default:
            return WishListStatus.listAddToCartFailure;
        }
    }
  }

  Future<WishListLineEntity?> updateWishListLine({
    required String wishListId,
    required WishListLineEntity wishListLineEntity,
  }) async {
    final result = await commerceAPIServiceProvider
        .getWishListService()
        .updateWishListLine(
          wishListId,
          WishListLineEntityMapper.toModel(wishListLineEntity),
        );

    switch (result) {
      case Success(value: final value):
        if (value == null) {
          return null;
        }

        return WishListLineEntityMapper.toEntity(value);
      case Failure():
        return null;
    }
  }

  Future<WishListStatus> addWishListLineToCart({
    required WishListLineEntity wishListLineEntity,
  }) async {
    if (wishListLineEntity.canAddToCart != true) {
      return WishListStatus.listLineAddToCartFailure;
    }

    final cartLineResult =
        await commerceAPIServiceProvider.getCartService().addCartLine(
              AddCartLine(
                productId: wishListLineEntity.productId,
                qtyOrdered: wishListLineEntity.qtyOrdered,
                unitOfMeasure: wishListLineEntity.unitOfMeasure,
                notes: wishListLineEntity.notes,
                sectionOptions: <SectionOptionDto>[],
              ),
            );

    switch (cartLineResult) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listLineAddToCartSuccess
            : WishListStatus.listLineAddToCartFailure;
      case Failure():
        return WishListStatus.listLineAddToCartFailure;
    }
  }

  Future<WishListStatus> deleteWishListLine({
    required WishListEntity wishListEntity,
    required WishListLineEntity wishListLineEntity,
  }) async {
    final wishListId = wishListEntity.id;
    final wishListLineId = wishListLineEntity.id;

    if (wishListId.isNullOrEmpty || wishListLineId.isNullOrEmpty) {
      return WishListStatus.listLineDeleteFailure;
    }

    if (!(wishListEntity.allowEditingBySharedWithUsers == true ||
        wishListEntity.isSharedList != true)) {
      return WishListStatus.listLineDeleteFailure;
    }

    final result = await commerceAPIServiceProvider
        .getWishListService()
        .deleteWishListLine(wishListId!, wishListLineId!);

    switch (result) {
      case Success(value: final value):
        return value != null
            ? WishListStatus.listLineDeleteSuccess
            : WishListStatus.listLineDeleteFailure;
      case Failure():
        return WishListStatus.listLineDeleteFailure;
    }
  }

  List<WishListLineSortOrder> get availableSortOrders =>
      WishListLineSortOrder.values;
}
