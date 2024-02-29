import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsPricingUseCase extends BaseUseCase {
  late var productPricingEnabled;
  late var realtimeProductPricingEnabled;
  late var chosenUnitOfMeasure;
  late Map<String, ConfigSectionOption> selectedConfigurations = {};
  late var realtimeProductAvailabilityEnabled;
  ProductDetailsPricingUseCase() : super() {
    productPricingEnabled = true;
    realtimeProductPricingEnabled = true;
    realtimeProductAvailabilityEnabled = true;
  }

  Future<Result<ProductPriceEntity, ErrorResponse>> loadProductPricing(
      ProductEntity productEntity,
      StyledProductEntity? styledProduct,
      int quantity) async {
    if (productEntity.quoteRequired!) {
      return Failure(ErrorResponse(
          errorDescription: 'Product requires a quote to be purchased'));
    }
// chosenUnitOfMeasure = ProductUnitOfMeasure();
    chosenUnitOfMeasure = styledProduct != null
        ? styledProduct.productUnitOfMeasures?.first ??
            productEntity.productUnitOfMeasures?.firstWhere(
                (p) => p.unitOfMeasure == productEntity.unitOfMeasure)
        : productEntity.productUnitOfMeasures
            ?.firstWhere((p) => p.unitOfMeasure == productEntity.unitOfMeasure);

    for (var s in productEntity?.configurationDto?.sections ?? []) {
      if (selectedConfigurations.containsKey(s.sectionName)) {
        selectedConfigurations[s.sectionName] = ConfigSectionOption();
      } else {
        selectedConfigurations[s.sectionName] = ConfigSectionOption();
      }
    }

    ProductPriceEntity productPricing;

    if (quantity < 1) {
      return Failure(ErrorResponse(
          errorDescription: 'Quantity must be greater than 0 to get pricing'));
    }

    var productId = styledProduct?.productId ?? productEntity.id;

    if (productPricingEnabled) {
      if (realtimeProductPricingEnabled) {
        var priceProducts = <ProductPriceQueryParameter>[
          ProductPriceQueryParameter(
            productId: productId,
            unitOfMeasure: chosenUnitOfMeasure?.unitOfMeasure,
            qtyOrdered: quantity,
          ),
        ];

        RealTimePricingParameters parameter = RealTimePricingParameters(
          productPriceParameters: priceProducts,
        );
        var getProductRealTimePricesResponse = await commerceAPIServiceProvider
            .getRealTimePricingService()
            .getProductRealTimePrices(parameter);

        switch (getProductRealTimePricesResponse) {
          case Success(value: final data):
            var realTimePrices = data;
            productPricing = ProductPriceEntityMapper().toEntity(realTimePrices
                ?.realTimePricingResults!
                .firstWhere((o) => o.productId == productId));
            return Success(productPricing);
          case Failure(errorResponse: final errorResponse):
            return Failure(ErrorResponse(
                errorDescription: errorResponse.errorDescription));
        }
      } else {
        var configurations = selectedConfigurations.values
            .where((v) => v != null)
            .map((s) => s.sectionOptionId)
            .toList();

        var parameters = ProductPriceQueryParameter(
          qtyOrdered: quantity,
          unitOfMeasure: chosenUnitOfMeasure.unitOfMeasure ?? '',
          configuration: configurations
              .where((element) => element != null)
              .toList()
              .cast<String>(),
        );

        var productPricingResponse = await commerceAPIServiceProvider
            .getProductService()
            .getProductPrice(productId!, parameters);

        switch (productPricingResponse) {
          case Success(value: final data):
            productPricing = ProductPriceEntityMapper().toEntity(data);
            return Success(productPricing);
          case Failure(errorResponse: final errorResponse):
            return Failure(ErrorResponse(
                errorDescription: errorResponse.errorDescription));
        }
      }
    }
    return Failure(ErrorResponse(
        errorDescription: 'Product pricing is not enabled for this product'));
    // this.updateAllNeededDetailItems();
    // this.isLoadingPrice = false;
  }

  Future<Result<GetRealTimeInventoryResult, ErrorResponse>>
      loadRealTimeInventory(ProductEntity productEntity) async {
    if (realtimeProductAvailabilityEnabled) {
      var inventoryProducts = <String>[productEntity.id ?? ''];

      if (productEntity.styledProducts != null &&
          productEntity.styledProducts!.isNotEmpty) {
        inventoryProducts.addAll(productEntity.styledProducts!
            .map((o) => o.productId ?? '')
            .where((productId) => productId.isNotEmpty));
      }

      var parameters =
          RealTimeInventoryParameters(productIds: inventoryProducts);

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

      // this.updateProductOrStyleProductRealTimeInventory(
      //     realTimeInventoryResult);

      // this.updateAllNeededDetailItems();
      // this.isLoadingInventory = false;
    }
    return Failure(ErrorResponse(
        errorDescription:
            'Real time inventory is not enabled for this product'));
  }

  ProductDetailsPriceEntity updateProductOrStyleProductRealTimeInventory(
    GetRealTimeInventoryResult getRealTimeInventoryResult,
    ProductEntity productEntity,
    StyledProductEntity? styledProduct,
    ProductDetailsPriceEntity productDetailsPriceEntity,
  ) {
    var productId =
        styledProduct != null ? styledProduct.productId : productEntity.id;
    var inventory = getRealTimeInventoryResult.realTimeInventoryResults
        ?.firstWhere((o) => o.productId == productId);

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

      if (styledProduct != null) {
        styledProduct = styledProduct.copyWith(
            qtyOnHand: inventory.qtyOnHand,
            availability:
                AvailabilityEntityMapper().toEntity(newInventoryAvailability));
      } else {
        productEntity = productEntity.copyWith(
            qtyOnHand: inventory.qtyOnHand,
            availability:
                AvailabilityEntityMapper().toEntity(newInventoryAvailability));
      }

      var productUnitOfMeasures = styledProduct != null
          ? styledProduct.productUnitOfMeasures
          : productEntity.productUnitOfMeasures;
      for (var p in productUnitOfMeasures!) {
        var unitOfMeasureAvailability = inventory.inventoryAvailabilityDtos
            ?.firstWhere((o) => o.unitOfMeasure == p.unitOfMeasure);
        if (unitOfMeasureAvailability != null) {
          p = p.copyWith(
              availability: AvailabilityEntityMapper()
                  .toEntity(unitOfMeasureAvailability.availability));
        } else {
          p = p.copyWith(
              availability: AvailabilityEntityMapper()
                  .toEntity(Availability(messageType: 0)));
        }
      }
    } else {
      var newProductAvailability = Availability(
        messageType: 0,
        message: LocalizationConstants.unableToRetrieveInventory,
      );
      if (styledProduct != null) {
        styledProduct = styledProduct.copyWith(
            availability:
                AvailabilityEntityMapper().toEntity(newProductAvailability));
        for (var p in styledProduct.productUnitOfMeasures!) {
          p = p.copyWith(
              availability: AvailabilityEntityMapper()
                  .toEntity(Availability(messageType: 0)));
        }
      } else {
        productEntity = productEntity.copyWith(
            availability:
                AvailabilityEntityMapper().toEntity(newProductAvailability));
        for (var p in productEntity.productUnitOfMeasures!) {
          p = p.copyWith(
              availability: AvailabilityEntityMapper()
                  .toEntity(Availability(messageType: 0)));
        }
      }
    }

    productDetailsPriceEntity = productDetailsPriceEntity.copyWith(
      product: productEntity,
      styledProduct: styledProduct,
    );

    return productDetailsPriceEntity;
  }
}
