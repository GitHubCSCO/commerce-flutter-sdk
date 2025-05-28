import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteAllUsecase extends BaseUseCase {
  QuoteAllUsecase() : super();

  Future<String> getSiteMessage(
      String messageName, String? defaultMessage) async {
    var result = await commerceAPIServiceProvider
        .getWebsiteService()
        .getSiteMessage(messageName, defaultMessage: defaultMessage);
    return result is Success ? (result as Success).value : defaultMessage;
  }

  Future<Result<QuoteDto, ErrorResponse>> quoteAll(
      QuoteAllQueryParameters parameters) async {
    return commerceAPIServiceProvider.getQuoteService().quoteAll(parameters);
  }
}
