import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteUsecase extends BaseUseCase {
  QuoteUsecase() : super();

  Future<Result<QuoteResult, ErrorResponse>> getQuotes(
      QuoteQueryParameters parameter) {
    return commerceAPIServiceProvider
        .getQuoteService()
        .getQuotes(quoteQueryParameters: parameter);
  }

  Future<Session?> getSession() async {
    final result = commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();

    if (result != null) {
      return result;
    }

    final response = await commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();

    switch (response) {
      case Success(value: final session):
        return session;
      case Failure():
        return null;
    }
  }

  Future<Result<JobQuoteResult, ErrorResponse>> getJobQuotes() {
    return commerceAPIServiceProvider.getJobQuoteService().getJobQuotes();
  }
}
