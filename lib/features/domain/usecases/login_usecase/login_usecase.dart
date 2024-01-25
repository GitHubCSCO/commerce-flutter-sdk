import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginUsecase extends BaseUseCase {
  LoginUsecase() : super();

  Future<LoginStatus> attemptSignIn(
    String username,
    String password,
  ) async {
    bool isOnline =
        await commerceAPIServiceProvider.getNetworkService().isOnline();
    if (!isOnline) {
      return LoginStatus.loginErrorOffline;
    }

    final result = await commerceAPIServiceProvider
        .getAuthenticationService()
        .logInAsync(username, password);
    switch (result) {
      case Success():
        {
          final sessionResult = await commerceAPIServiceProvider
              .getSessionService()
              .getCurrentSession();
          switch (sessionResult) {
            case Success(value: final fullSession):
              {
                if (fullSession == null) {
                  return LoginStatus.loginErrorUnknown;
                }

                await commerceAPIServiceProvider
                    .getAccountService()
                    .getCurrentAccountAsync();
                if (_showBiometricOptionView()) {
                  return LoginStatus.loginSuccessBiometric;
                } else {
                  return LoginStatus.loginSuccessBillToShipTo;
                }
              }
            case Failure():
              return LoginStatus.loginErrorUnknown;
          }
        }
      case Failure():
        return LoginStatus.loginErrorUnsuccessful;
    }
  }

  bool _showBiometricOptionView() {
    // TODO - implement this
    return false;
  }
}
