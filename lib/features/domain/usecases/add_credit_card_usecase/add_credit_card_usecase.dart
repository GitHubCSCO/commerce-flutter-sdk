import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCreditCardUsecase extends BaseUseCase {
  AddCreditCardUsecase() : super();

  Future<Result<Cart, ErrorResponse>> getCurrentCart() async {
    var cartParameters = CartQueryParameters(expand: ['paymentoptions']);

    return commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(cartParameters);
  }

  String? get tokenExIFrameUrl {
    var url = coreServiceProvider.getAppConfigurationService().tokenExIFrameUrl;
    return url;
  }

  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfiguration(
      String token) async {
    return await coreServiceProvider
        .getAppConfigurationService()
        .getTokenExConfiguration(token);
  }

  Future<Result<AccountPaymentProfile, ErrorResponse>> savePaymentProfile(
      AccountPaymentProfile paymentProfile) async {
    return await commerceAPIServiceProvider
        .getAccountService()
        .savePaymentProfile(paymentProfile);
  }

  Future<Result<bool, ErrorResponse>> deleteCreditCard(
      String paymentProfileId) async {
    return await commerceAPIServiceProvider
        .getAccountService()
        .deletePaymentProfile(paymentProfileId);
  }
}
