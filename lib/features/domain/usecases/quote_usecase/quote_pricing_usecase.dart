import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuotePricingUsecase extends BaseUseCase {
  QuotePricingUsecase() : super();

  Future<Result<QuoteDto, ErrorResponse>> getQuotePricing(
      String quoteId, QuoteLinePricingQueryParameters parameters) async {
    return await commerceAPIServiceProvider
        .getQuoteService()
        .quoteLinePricing(quoteId, parameters);
  }
}
