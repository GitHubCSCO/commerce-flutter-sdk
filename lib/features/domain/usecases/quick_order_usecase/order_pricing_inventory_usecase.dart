import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderPricingInventoryUseCase extends BaseUseCase {
  Future<GetRealTimePricingResult?> getProductRealTimePrices(
      RealTimePricingParameters parameter) async {
    var result = await commerceAPIServiceProvider
        .getRealTimePricingService()
        .getProductRealTimePrices(parameter);
    return result is Success ? (result as Success).value : null;
  }

  Future<GetRealTimeInventoryResult?> getProductRealTimeInventory(
      RealTimeInventoryParameters parameter) async {
    var result = await commerceAPIServiceProvider
        .getRealTimeInventoryService()
        .getProductRealTimeInventory(parameters: parameter);
    return result is Success ? (result as Success).value : null;
  }

  Future<ProductPrice?> getProductPrice(
      String productId, ProductPriceQueryParameter parameter) async {
    var result = await commerceAPIServiceProvider
        .getProductService()
        .getProductPrice(productId, parameter);
    return result is Success ? (result as Success).value : null;
  }

  Future<bool> isAuthenticated() async {
    var result = await commerceAPIServiceProvider
        .getAuthenticationService()
        .isAuthenticatedAsync();
    return result is Success ? (result as Success).value : false;
  }
}
