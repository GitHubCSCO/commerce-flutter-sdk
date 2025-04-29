import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutUsecase extends BaseUseCase {
  CheckoutUsecase() : super();

  Future<Result<Cart, ErrorResponse>> getCart(String? cartId) async {
    // cart get for IsAcceptQuote is different,, need to implement it later
    var cartParameters = CartQueryParameters(
        cartId: cartId,
        expand: [
          'cartlines',
          'costcodes',
          'shipping',
          'tax',
          'carriers',
          'paymentoptions'
        ],
        allowInvalidAddress: true);
    return await commerceAPIServiceProvider
        .getCartService()
        .getCart(cartId!, cartParameters);
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
    return commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();
  }

  Future<Session?> updateCurrentSession(Session? session) async {
    if (session == null) {
      return null;
    }
    final result = (await commerceAPIServiceProvider
            .getSessionService()
            .patchCustomerSession(session))
        .getResultSuccessValue();

    return result;
  }

  Future<Result<CartSettings, ErrorResponse>> getCartSetting() {
    return commerceAPIServiceProvider
        .getSettingsService()
        .getCartSettingAsync();
  }

  Future<Result<Settings, ErrorResponse>> loadSettingsCollection() {
    return commerceAPIServiceProvider.getSettingsService().getSettingsAsync();
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

  Future<Result<ProductSettings, ErrorResponse>> loadProductSettings() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }

  Future<bool> hasCheckout() async {
    return await coreServiceProvider.getAppConfigurationService().hasCheckout();
  }

  bool get shouldShowOrderNotes {
    return !(coreServiceProvider
            .getAppConfigurationService()
            .baseConfig
            ?.customHideCheckoutOrderNotes ??
        false);
  }
}
