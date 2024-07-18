import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class ILocalizationService {
  Map<String, String>? get translationDictionary;

  Language? getCurrentLanguage();

  Future<Result<bool, ErrorResponse>> loadCurrentLanguage();

  Future<Result<bool, ErrorResponse>> changeLanguage(Language language);

  Future<void> removeCurrentLanguage();
}
