import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class TranslationService extends ServiceBase implements ITranslationService {
  TranslationService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  static const int _uriMaxLength = 2048;

  @override
  int getMaxLengthOfTranslationText() {
    return _uriMaxLength -
        (clientService.url.toString().length +
            CommerceAPIConstants.translationUrl.length);
  }

  @override
  Future<Result<TranslationResults, ErrorResponse>> getTranslations(
      {TranslationQueryParameters? parameters}) async {
    var url = Uri.parse(CommerceAPIConstants.translationUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache<TranslationResults>(
        url.toString(), TranslationResults.fromJson);
  }
}
