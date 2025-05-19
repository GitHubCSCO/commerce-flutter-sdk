import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class ITranslationService {
  Future<Result<TranslationResults, ErrorResponse>> getTranslations(
      {TranslationQueryParameters? parameters});

  int getMaxLengthOfTranslationText();
}
