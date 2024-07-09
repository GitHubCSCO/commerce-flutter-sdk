import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteUsecase extends BaseUseCase {
  QuoteUsecase() : super();

  Future<Result<QuoteResult, ErrorResponse>> getQuotes(
      QuoteQueryParameters parameter) {
    return commerceAPIServiceProvider
        .getQuoteService()
        .getQuotes(quoteQueryParameters: parameter);
  }
}
