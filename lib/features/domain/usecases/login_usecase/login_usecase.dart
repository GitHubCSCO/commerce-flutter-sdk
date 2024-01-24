import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginUsecase {

  final IAuthenticationService _authenticationService;
  final INetworkService _networkService;
  final ISessionService _sessionService;
  final IAccountService _accountService;

  LoginUsecase({
    required IAuthenticationService authenticationService,
    required INetworkService networkService,
    required ISessionService sessionService,
    required IAccountService accountService,
  })  : _authenticationService = authenticationService,
        _networkService = networkService,
        _sessionService = sessionService,
        _accountService = accountService;

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
