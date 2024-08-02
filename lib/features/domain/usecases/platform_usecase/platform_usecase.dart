import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class PlatformUseCase extends BaseUseCase {
  Future<String?> getAuthorizedURL(String path) async {
    return await commerceAPIServiceProvider
        .getWebsiteService()
        .getAuthorizedURL(path);
  }

  Future<String?> getAuthorizedCustomUrl(String path) async {
    return await commerceAPIServiceProvider
        .getWebsiteService()
        .getAuthorizedURL(path);
  }
}
