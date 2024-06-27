import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutUsecase extends BaseUseCase {
  CheckoutUsecase() : super();

  Future<Result<Cart, ErrorResponse>> getCart(String? cartId) async {
    // cart get for IsAcceptQuote is different,, need to implement it later
    var cartParameters = CartQueryParameters(cartId: cartId, expand: [
      'cartlines',
      'costcodes',
      'shipping',
      'tax',
      'carriers',
      'paymentoptions'
    ]);
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(cartParameters);
  }

  Future<Result<Cart, ErrorResponse>> patchCart(Cart cart) async {
    return await commerceAPIServiceProvider.getCartService().updateCart(cart);
  }

  Future<Result<PromotionCollectionModel, ErrorResponse>>
      loadCartPromotions() async {
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCartPromotions();
  }

  Session? getCurrentSession() {
    return commerceAPIServiceProvider.getSessionService().getCachedCurrentSession();
  }

  Future<Result<CartSettings, ErrorResponse>> getCartSetting() {
    return commerceAPIServiceProvider
        .getSettingsService()
        .getCartSettingAsync();
  }

  Future<Result<ShipTo, ErrorResponse>> postCurrentBillToShipToAsync(
      ShipTo shipTo) async {
    return commerceAPIServiceProvider
        .getBillToService()
        .postCurrentBillToShipToAsync(shipTo);
  }

  Future<void> removeOrderApprovalCookieIfAvailable() async {
    await commerceAPIServiceProvider
        .getClientService()
        .removeOrderApprovalCookieIfAvailable();
  }
}
