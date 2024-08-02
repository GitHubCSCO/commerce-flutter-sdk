import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
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
                    await coreServiceProvider
                        .getBiometricAuthenticationService()
                        .markCurrentUserAsSeenEnableBiometricOptionView();
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

  Future<LoginStatus> biometricSignIn() async {
    final success = await authenticateWithBiometrics();
    if (success) {
      final loginSuccess = await coreServiceProvider
          .getBiometricAuthenticationService()
          .logInWithStoredCredentials();

      if (!loginSuccess) {
        return LoginStatus.loginErrorUnsuccessful;
      }

      final sessionResponse = await commerceAPIServiceProvider
          .getSessionService()
          .getCurrentSession();

      switch (sessionResponse) {
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
              return LoginStatus.loginSuccessBillToShipTo;
            }
          }
        case Failure():
          return LoginStatus.loginErrorUnknown;
      }
    } else {
      return LoginStatus.loginFailed;
    }
  }

  Future<Result<Session, ErrorResponse>> getCurrentSession() async {
    return await commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();
  }

  Future<Result<GetBillTosResult, ErrorResponse>> getBillTo(
      BillTosQueryParameters parameters) async {
    return await commerceAPIServiceProvider
        .getBillToService()
        .getBillTosAsync(parameters: parameters);
  }

  Future<Result<GetShipTosResult, ErrorResponse>> getShipTo(
      String billToId, ShipTosQueryParameters parameters) async {
    return await commerceAPIServiceProvider
        .getBillToService()
        .getShipTosAsync(billToId, parameters: parameters);
  }

  Future<LoginStatus> authenticateBiometrically(
      DeviceAuthenticationOption option) async {
    if (option == DeviceAuthenticationOption.none) {
      return LoginStatus.loginFailed;
    }

    if (!(await coreServiceProvider
        .getBiometricAuthenticationService()
        .hasStoredCredentialsForCurrentDomain())) {
      return LoginStatus.loginFailed;
    }

    return await biometricSignIn();
  }

  @override
  Future<DeviceAuthenticationOption> getBiometricOptions() async {
    if (await coreServiceProvider
        .getBiometricAuthenticationService()
        .hasStoredCredentialsForCurrentDomain()) {
      return DeviceAuthenticationOption.none;
    }

    return await super.getBiometricOptions();
  }

  Future<void> loginCancel() async {
    await commerceAPIServiceProvider.getAuthenticationService().logoutAsync();
  }
}
