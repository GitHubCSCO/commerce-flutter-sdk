import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
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

      var realTimeInventoryResultResponse = await this
          .commerceAPIServiceProvider
          .getRealTimeInventoryService()
          .getProductRealTimeInventory(parameters: parameters);

      switch (realTimeInventoryResultResponse) {
        case Success(value: final data):
          var realTimeInventoryResult = data;
          var realTimeInventoryInfoList =
              realTimeInventoryResult?.realTimeInventoryResults;
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
}
