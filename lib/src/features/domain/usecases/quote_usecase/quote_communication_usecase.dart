import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteCommunicationUsecase extends BaseUseCase {
  QuoteCommunicationUsecase() : super();

  Future<Result<QuoteDto, ErrorResponse>> getQuote(String quoteId) async {
    return await commerceAPIServiceProvider.getQuoteService().getQuote(quoteId);
  }

  Future<Result<MessageDto, ErrorResponse>> sendMessage(
      MessageDto message) async {
    return commerceAPIServiceProvider.getMessageService().addMessage(message);
  }
}
