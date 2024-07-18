import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LanguageUsecase extends BaseUseCase {
  LanguageUsecase() : super();

  Future<Result<bool, ErrorResponse>> loadCurrentLanguage() async {
    return await coreServiceProvider.getLocalizationService().loadCurrentLanguage();
  }

  Future<Result<bool, ErrorResponse>> changeLanguage(Language language) async {
    return await coreServiceProvider.getLocalizationService().changeLanguage(language);
  }
}
