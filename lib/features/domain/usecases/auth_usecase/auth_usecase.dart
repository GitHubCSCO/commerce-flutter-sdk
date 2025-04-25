import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AuthUsecase extends BaseUseCase {
  AuthUsecase() : super();

  Future<bool> isAuthenticated() async {
    final authResult = await commerceAPIServiceProvider
        .getAuthenticationService()
        .isAuthenticatedAsync();
    switch (authResult) {
      case Success(value: final value):
        await commerceAPIServiceProvider
            .getAccountService()
            .getCurrentAccountAsync();
        return value!;
      case Failure():
        return false;
    }
  }
}
