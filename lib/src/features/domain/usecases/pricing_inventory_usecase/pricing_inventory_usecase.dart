import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PricingInventoryUseCase extends BaseUseCase {
  Future<bool> getProductInventoryAvailable() async {
    final productSettings =
        (await loadProductSettings()).getResultSuccessValue();
    return productSettings?.showInventoryAvailability ?? false;
  }

  Future<Result<ProductSettings, ErrorResponse>> loadProductSettings() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }

  bool getHidePricingEnable() {
    return coreServiceProvider.getAppConfigurationService().hidePricingEnable ??
        false;
  }

  bool getHideInventoryEnable() {
    return coreServiceProvider
            .getAppConfigurationService()
            .hideInventoryEnable ??
        false;
  }

  Future<bool> getProductPricingEnable() async {
    var productPricingEnabledResult = await coreServiceProvider
        .getAppConfigurationService()
        .productPricingEnabled();
    var productPricingPresentationEnabled =
        productPricingEnabledResult ?? false;
    return productPricingPresentationEnabled;
  }

  Future<RealTimeSupport?> getRealtimeSupportType() async {
    return await coreServiceProvider
        .getAppConfigurationService()
        .getRealtimeSupportType();
  }

  Future<Result<GetRealTimePricingResult, ErrorResponse>?> getRealTimePricing(
      RealTimePricingParameters parameter) async {
    var getProductRealTimePricesResponse = await commerceAPIServiceProvider
        .getRealTimePricingService()
        .getProductRealTimePrices(parameter);
    var pricingResult = getProductRealTimePricesResponse;
    switch (pricingResult) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
      default:
        return null;
    }
  }

  Future<Result<GetRealTimeInventoryResult, ErrorResponse>>
      getRealTimeInventory(RealTimeInventoryParameters parameter) async {
    return await commerceAPIServiceProvider
        .getRealTimeInventoryService()
        .getProductRealTimeInventory(parameters: parameter);
  }
}
