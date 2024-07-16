import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteDetailsUsecase extends BaseUseCase {
  QuoteDetailsUsecase() : super();
  Future<Result<QuoteDto, ErrorResponse>> getQuote(String quoteId) async {
    return await commerceAPIServiceProvider.getQuoteService().getQuote(quoteId);
  }

  Future<Result<ProductSettings, ErrorResponse>>
      getProductSettingAsync() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }

  Future<Result<Session, ErrorResponse>> getCurrentSession() async {
    return await commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();
  }

  Future<Result<bool, ErrorResponse>> deleteQuote(String quoteId) async {
    return await commerceAPIServiceProvider
        .getQuoteService()
        .deleteQuote(quoteId);
  }

  Future<Result<QuoteDto, ErrorResponse>> submitQuote(QuoteDto quoteDto) async {
    return await commerceAPIServiceProvider
        .getQuoteService()
        .submitQuote(quoteDto);
  }

  Future<Result<bool, ErrorResponse>> isAuthenticatedAsync() async {
    return await commerceAPIServiceProvider
        .getAuthenticationService()
        .isAuthenticatedAsync();
  }

  Future<Result<Cart, ErrorResponse>> getCurrentCart(
      CartQueryParameters parameters) async {
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(parameters);
  }

  Future<String> getCheckoutUrl() async {
    return await coreServiceProvider.getAppConfigurationService().checkoutUrl();
  }
}
