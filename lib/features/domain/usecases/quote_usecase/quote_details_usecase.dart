import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
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

  Future<Result<QuoteSettings, ErrorResponse>> getQuoteSettings() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getQuoteSettingAsync();
  }

  Future<String?> getCheckoutUrl() async {
    return await coreServiceProvider.getAppConfigurationService().checkoutUrl();
  }

  Future<String> getSiteMessage(
      String messageName, String? defaultMessage) async {
    var result = await commerceAPIServiceProvider
        .getWebsiteService()
        .getSiteMessage(messageName, defaultMessage: defaultMessage);
    return result is Success ? (result as Success).value : defaultMessage;
  }

  Future<JobQuoteDto?> getJobQuote({required String? jobQuoteId}) async {
    final result = await commerceAPIServiceProvider
        .getJobQuoteService()
        .getJobQuote(jobQuoteId ?? '');

    switch (result) {
      case Failure():
        return null;
      case Success(value: final jobQuoteDto):
        return jobQuoteDto;
    }
  }

  Future<JobQuoteDto?> updateJobQuote({
    required JobQuoteUpdateParameter parameter,
  }) async {
    final result = await commerceAPIServiceProvider
        .getJobQuoteService()
        .updateJobQuote(parameter);

    switch (result) {
      case Failure():
        return null;
      case Success(value: final jobQuoteDto):
        return jobQuoteDto;
    }
  }

  Future<Result<CartLine, ErrorResponse>> updateCartLine(CartLine cartLine) {
    return commerceAPIServiceProvider.getCartService().updateCartLine(cartLine);
  }

  Future<Result<QuoteLine, ErrorResponse>> patchQuoteLine(
      String quoteId, QuoteLine quoteLine) {
    return commerceAPIServiceProvider
        .getQuoteService()
        .patchQuoteLine(quoteId, quoteLine);
  }

  Future<String?> getAuthorizedURL(String path) async {
    return await commerceAPIServiceProvider
        .getWebsiteService()
        .getAuthorizedURL(path);
  }

  Future<Result<QuoteLine, ErrorResponse>> updateQuoteLine(
      String quoteId, QuoteLine quoteLine) {
    return commerceAPIServiceProvider
        .getQuoteService()
        .updateQuoteLine(quoteId, quoteLine);
  }
}
