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
        .getCachedCurrentSession()
        ?.pickUpWarehouse;
  }

  String? getShippingMethod() {
    return commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession()
        ?.fulfillmentMethod;
  }

  Future<bool> isCustomerOrderApproval() async {
    return await commerceAPIServiceProvider
        .getClientService()
        .isCustomerOrderApproval();
  }

  Future<String> getSiteMessage(
      String messageName, String? defaultMessage) async {
    var result = await commerceAPIServiceProvider
        .getWebsiteService()
        .getSiteMessage(messageName, defaultMessage: defaultMessage);
    return result is Success ? (result as Success).value : defaultMessage;
  }

  Future<Result<ProductSettings, ErrorResponse>> loadProductSettings() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }
}
