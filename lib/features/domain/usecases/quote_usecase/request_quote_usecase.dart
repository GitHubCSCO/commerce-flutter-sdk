import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class RequestQuoteUsecase extends BaseUseCase {
  RequestQuoteUsecase() : super();

  Future<Result<Session, ErrorResponse>> getCurrentSession() async {
    return await commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();
  }

  Future<String> getSiteMessage(
      String messageName, String? defaultMessage) async {
    var result = await commerceAPIServiceProvider
        .getWebsiteService()
        .getSiteMessage(messageName, defaultMessage: defaultMessage);
    return result is Success ? (result as Success).value : defaultMessage;
  }

  Future<Result<QuoteSettings, ErrorResponse>> getQuoteSettings() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getQuoteSettingAsync();
  }

  Future<Result<CartSettings, ErrorResponse>> getCartSettingAsync() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getCartSettingAsync();
  }

  Future<Result<ProductSettings, ErrorResponse>>
      getProductSettingAsync() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }

  Future<Result<GetCartLinesResult, ErrorResponse>> getCartLinesAsync() async {
    return await commerceAPIServiceProvider.getCartService().getCartLines();
  }

  Future<Result<CartLine, ErrorResponse>> updateCartLine(
      CartLine cartLine) async {
    return await commerceAPIServiceProvider
        .getCartService()
        .updateCartLine(cartLine);
  }

  Future<Result<bool, ErrorResponse>> deleteCartLine(CartLine cartLine) async {
    return await commerceAPIServiceProvider
        .getCartService()
        .deleteCartLine(cartLine);
  }

  Future<Result<QuoteDto, ErrorResponse>> requestQuote(
      RequesteAQuoteParameters param) async {
    return await commerceAPIServiceProvider
        .getQuoteService()
        .requestQuote(param);
  }
}
