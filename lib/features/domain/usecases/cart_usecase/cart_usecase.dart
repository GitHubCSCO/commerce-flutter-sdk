import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartUseCase extends BaseUseCase {
  Future<Result<Cart, ErrorResponse>> loadCurrentCart() async {
    var cartParameters = CartQueryParameters(
        expand: ["cartlines", "costcodes", "shipping", "tax"],
        allowInvalidAddress: true);
    return commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(cartParameters);
  }

  Future<Result<CartSettings, ErrorResponse>> loadCartSetting() async {
    return commerceAPIServiceProvider
        .getSettingsService()
        .getCartSettingAsync();
  }

  Future<Result<PromotionCollectionModel, ErrorResponse>>
      loadCartPromotions() async {
    return commerceAPIServiceProvider
        .getCartService()
        .getCurrentCartPromotions();
  }

  Future<Result<Session, ErrorResponse>> patchPickUpLocation(
      Warehouse warehouse) async {
    var newSession = commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();
    newSession?.pickUpWarehouse = warehouse;

    return commerceAPIServiceProvider
        .getSessionService()
        .patchSession(newSession!);
  }

  Future<bool> isCustomerOrderApproval() async {
    return commerceAPIServiceProvider
        .getClientService()
        .isCustomerOrderApproval();
  }

  Future<Result<ProductSettings, ErrorResponse>> loadProductSettings() async {
    return commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }

  Future<bool> hasCheckout() async {
    return coreServiceProvider.getAppConfigurationService().hasCheckout();
  }

  Future<Result<Session, ErrorResponse>> getCurrentSession() async {
    return commerceAPIServiceProvider.getSessionService().getCurrentSession();
  }

  Future<bool> hasWillCall() async {
    return coreServiceProvider.getAppConfigurationService().hasWillCall();
  }
}
