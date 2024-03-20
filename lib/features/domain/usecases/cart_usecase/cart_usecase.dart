import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartUseCase extends BaseUseCase {
  Future<Result<Cart, ErrorResponse>> loadCurrentCart() async {
    var cartParameters = CartQueryParameters(
        expand: ["cartlines", "costcodes", "shipping", "tax"]);
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(cartParameters);
  }

  Future<Result<CartSettings, ErrorResponse>> loadCartSetting() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getCartSettingAsync();
  }

  Future<Result<PromotionCollectionModel, ErrorResponse>>
      loadCartPromotions() async {
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCartPromotions();
  }

  Warehouse? getPickUpWareHouse() {
    return commerceAPIServiceProvider
        .getSessionService()
        .currentSession
        ?.pickUpWarehouse;
  }

  String? getShippingMethod() {
    return commerceAPIServiceProvider
        .getSessionService()
        .currentSession
        ?.fulfillmentMethod;
  }

  bool isCustomerOrderApproval() {
    return false;
  }
}
