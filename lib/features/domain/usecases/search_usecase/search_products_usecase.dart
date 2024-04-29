import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchProductsusecase extends BaseUseCase {
  SearchProductsusecase() : super();

  Future<Result<CartLine, ErrorResponse>> addToCart(
      AddCartLine addcartLine) async {
    var result = await commerceAPIServiceProvider
        .getCartService()
        .addCartLine(addcartLine);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<GetRealTimeInventoryResult?> loadRealTimeInventory(
      Product product) async {
    var realtimeSupport = await coreServiceProvider
        .getAppConfigurationService()
        .getRealtimeSupportType();

    var realtimeProductAvailabilityEnabled = realtimeSupport ==
            RealTimeSupport.RealTimeInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingAndInventory ||
        realtimeSupport == RealTimeSupport.RealTimePricingWithInventoryIncluded;

    if (realtimeProductAvailabilityEnabled) {
      var inventoryProducts = <String>[product.id ?? ''];

      if (product.styledProducts != null &&
          product.styledProducts!.isNotEmpty) {
        inventoryProducts.addAll(product.styledProducts!
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
          return realTimeInventoryResult;
        case Failure():
          return null;
      }
    }
    return null;
  }
}
