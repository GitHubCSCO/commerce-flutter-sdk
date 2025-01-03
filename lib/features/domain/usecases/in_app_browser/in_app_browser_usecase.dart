import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InAppBrowserUsecase extends BaseUseCase {
  Future<String?> getAccessToken() async {
    var isExpired = await commerceAPIServiceProvider
        .getClientService()
        .isAccessTokenExpired();

    if (isExpired) {
      var response = await commerceAPIServiceProvider
          .getClientService()
          .renewAuthenticationTokens();
      switch (response) {
        case Success(value: final data):
          return commerceAPIServiceProvider.getClientService().getAccessToken();
        case Failure(:final errorResponse):
          return null;
      }
    } else {
      return commerceAPIServiceProvider.getClientService().getAccessToken();
    }
  }
}
