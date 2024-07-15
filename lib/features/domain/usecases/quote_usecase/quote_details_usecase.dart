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
}
