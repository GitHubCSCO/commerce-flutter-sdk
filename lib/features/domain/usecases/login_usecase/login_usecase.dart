import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginUsecase {
  final IAuthenticationService _authenticationService =
      sl<IAuthenticationService>();

  final INetworkService _networkService = sl<INetworkService>();

  final ISessionService _sessionService = sl<ISessionService>();

  final IAccountService _accountService = sl<IAccountService>();

  Future<LoginStatus> attemptSignIn(
    String username,
    String password,
  ) async {
    bool isOnline = await _networkService.isOnline();
    if (!isOnline) {
      return LoginStatus.loginErrorOffline;
    }

    final result = await _authenticationService.logInAsync(username, password);
    switch (result) {
      case Success():
        {
          final sessionResult = await _sessionService.getCurrentSession();
          switch (sessionResult) {
            case Success(value: final fullSession):
              {
                if (fullSession == null) {
                  return LoginStatus.loginErrorUnknown;
                }

                await _accountService.getCurrentAccountAsync();
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
