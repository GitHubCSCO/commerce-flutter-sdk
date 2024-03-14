import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginUsecase extends BiometricUsecase {
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

                final accountResult = await commerceAPIServiceProvider
                    .getAccountService()
                    .getCurrentAccountAsync();

                if (accountResult is Failure) {
                  return LoginStatus.loginErrorUnknown;
                } else {
                  if (await _showBiometricOptionView()) {
                    return LoginStatus.loginSuccessBiometric;
                  } else {
                    return LoginStatus.loginSuccessBillToShipTo;
                  }
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

  Future<bool> _showBiometricOptionView() async {
    bool isUnavailable =
        (await getBiometricOptions()) == DeviceAuthenticationOption.none;

    bool hasCurrentUserSeenEnableBiometricOptionView = await coreServiceProvider
        .getBiometricAuthenticationService()
        .hasCurrentUserSeenEnableBiometricOptionView();

    if (isUnavailable || hasCurrentUserSeenEnableBiometricOptionView) {
      return false;
    }

    return true;
  }
}
