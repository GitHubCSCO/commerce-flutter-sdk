import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsPricingUseCase extends BaseUseCase {
  ProductDetailsPricingUseCase() : super();

  Future<Result<ProductPriceEntity, ErrorResponse>> loadProductPricing(
      ProductEntity productEntity,
      ProductEntity? selectedVariantChild,
      ProductUnitOfMeasureEntity? chosenUnitOfMeasure,
      bool realtimeProductPricingEnabled,
      bool productPricingEnabled,
      int quantity,
      Map<String, ConfigSectionOptionEntity?> selectedConfigurations) async {
    if (productEntity.quoteRequired ?? false) {
      return Failure(ErrorResponse(
          errorDescription: 'Product requires a quote to be purchased'));
    }
    ProductPriceEntity productPricing;

    if (quantity < 1) {
      return Failure(ErrorResponse(
          errorDescription: 'Quantity must be greater than 0 to get pricing'));
    }

    var productId = selectedVariantChild?.id ?? productEntity.id;

    if (productPricingEnabled) {
      List<String>? configurations = selectedConfigurations.values
          .map((config) => config?.sectionOptionId ?? "")
          .where((id) => id.isNotEmpty)
          .toList();

      var priceProducts = <ProductPriceQueryParameter>[
        ProductPriceQueryParameter(
          productId: productId,
          unitOfMeasure: chosenUnitOfMeasure?.unitOfMeasure ?? "",
          qtyOrdered: quantity,
          configuration: configurations,
        ),
      ];

      var parameter = RealTimePricingParameters(
        productPriceParameters: priceProducts,
      );
      var getProductRealTimePricesResponse = await commerceAPIServiceProvider
          .getRealTimePricingService()
          .getProductRealTimePrices(parameter);

      switch (getProductRealTimePricesResponse) {
        case Success(value: final data):
          var realTimePrices = data;
          var productPricingList = realTimePrices?.realTimePricingResults
              ?.where((o) => o.productId == productId);
          productPricing = ProductPriceEntityMapper.toEntity(
              productPricingList?.firstOrNull);
          return Success(productPricing);
        case Failure(errorResponse: final errorResponse):
          return Failure(ErrorResponse(
              errorDescription: errorResponse.errorDescription));
      }
    }
    return Failure(ErrorResponse(
        errorDescription: 'Product pricing is not enabled for this product'));
  }

  Future<Result<GetRealTimeInventoryResult, ErrorResponse>>
      loadRealTimeInventory(
          ProductEntity productEntity,
          {List<ProductEntity>? variantChildren}) async {
    var inventoryProducts = <String>[productEntity.id ?? ''];

    if (variantChildren != null && variantChildren.isNotEmpty) {
      inventoryProducts.addAll(variantChildren
          .map((o) => o.id ?? '')
          .where((productId) => productId.isNotEmpty));
    }

    var parameters = RealTimeInventoryParameters(productIds: inventoryProducts);

    var realTimeInventoryResultResponse = await commerceAPIServiceProvider
        .getRealTimeInventoryService()
        .getProductRealTimeInventory(parameters: parameters);

    switch (realTimeInventoryResultResponse) {
      case Success(value: final data):
        var realTimeInventoryResult = data;
        return Success(realTimeInventoryResult);
      case Failure(errorResponse: final errorResponse):
        return Failure(
            ErrorResponse(errorDescription: errorResponse.errorDescription));
    }
  }

  ProductDetailsPriceEntity updateProductOrStyleProductRealTimeInventory(
      GetRealTimeInventoryResult? getRealTimeInventoryResult,
      ProductEntity productEntity,
      ProductEntity? selectedVariantChild,
      ProductDetailsPriceEntity productDetailsPriceEntity,
      ProductUnitOfMeasureEntity? chosenUnitOfMeasure) {
    var productId =
        selectedVariantChild != null ? selectedVariantChild.id : productEntity.id;
    var inventoryList = getRealTimeInventoryResult?.realTimeInventoryResults
        ?.where((o) => o.productId == productId);
    var inventory = inventoryList?.firstOrNull;

    if (inventory != null) {
      Availability? newInventoryAvailability;

      if (inventory.inventoryAvailabilityDtos != null) {
        for (var inventoryAvailabilityDto
            in inventory.inventoryAvailabilityDtos!) {
          if (inventoryAvailabilityDto.unitOfMeasure ==
                  chosenUnitOfMeasure?.unitOfMeasure ||
              (chosenUnitOfMeasure == null &&
                  inventoryAvailabilityDto.unitOfMeasure == '')) {
            newInventoryAvailability = inventoryAvailabilityDto.availability;
            break;
          }
        }
      }

      newInventoryAvailability ??= Availability(messageType: 0);

      if (selectedVariantChild != null) {
        selectedVariantChild = selectedVariantChild.copyWith(
            qtyOnHand: inventory.qtyOnHand,
            availability:
                AvailabilityEntityMapper.toEntity(newInventoryAvailability));
      } else {
        productEntity = productEntity.copyWith(
            qtyOnHand: inventory.qtyOnHand,
            availability:
                AvailabilityEntityMapper.toEntity(newInventoryAvailability));
      }

    } else {
      var newProductAvailability = Availability(
        messageType: 0,
        message: LocalizationConstants.unableToRetrieveInventory.localized(),
      );
      if (selectedVariantChild != null) {
        selectedVariantChild = selectedVariantChild.copyWith(
            availability:
                AvailabilityEntityMapper.toEntity(newProductAvailability));
      } else {
        productEntity = productEntity.copyWith(
            availability:
                AvailabilityEntityMapper.toEntity(newProductAvailability));
      }
    }

    productDetailsPriceEntity = productDetailsPriceEntity.copyWith(
      product: productEntity,
      selectedVariantChild: selectedVariantChild,
    );

    return productDetailsPriceEntity;
  }
}
