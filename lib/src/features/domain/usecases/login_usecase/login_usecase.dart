import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginResponse {
  final LoginStatus loginStatus;
  final String? message;

  LoginResponse(this.loginStatus, {this.message});
}

class LoginUsecase extends BiometricUsecase {
  LoginUsecase() : super();

  /// Logs how long each sign in step takes, so a slow or stuck step shows up
  /// by name in the Xcode console (look for lines starting with [Login]).
  Future<T> _timed<T>(String label, Future<T> future) async {
    final stopwatch = Stopwatch()..start();
    debugPrint('[Login] $label started');
    try {
      return await future;
    } finally {
      debugPrint('[Login] $label took ${stopwatch.elapsedMilliseconds}ms');
    }
  }

  Future<LoginResponse> attemptSignIn(
    String username,
    String password,
  ) async {
    bool isOnline = await _timed('network check',
        commerceAPIServiceProvider.getNetworkService().isOnline());
    if (!isOnline) {
      return LoginResponse(LoginStatus.loginErrorOffline);
    }

    final result = await _timed(
        'token + session create',
        commerceAPIServiceProvider
            .getAuthenticationService()
            .logInAsync(username, password));
    switch (result) {
      case Success():
        {
          final sessionResult = await _timed(
              'get current session',
              commerceAPIServiceProvider
                  .getSessionService()
                  .getCurrentSession());
          switch (sessionResult) {
            case Success(value: final fullSession):
              {
                if (fullSession == null) {
                  return LoginResponse(LoginStatus.loginErrorUnknown);
                }

                final deviceToken = await coreServiceProvider
                    .getDeviceTokenService()
                    .getDeviceToken();

                if (!deviceToken.isNullOrEmpty) {
                  unawaited(
                    commerceAPIServiceProvider
                        .getPushNotificationService()
                        .registerDeviceToken(
                          DeviceTokenRegistrationParameters(
                            deviceToken: deviceToken,
                          ),
                        ),
                  );
                }

                await _timed(
                    'get current account',
                    commerceAPIServiceProvider
                        .getAccountService()
                        .getCurrentAccountAsync());

                if (await _timed('biometric option check',
                    _showBiometricOptionView())) {
                  await coreServiceProvider
                      .getBiometricAuthenticationService()
                      .markCurrentUserAsSeenEnableBiometricOptionView();
                  return LoginResponse(LoginStatus.loginSuccessBiometric);
                } else {
                  return LoginResponse(LoginStatus.loginSuccessBillToShipTo);
                }
              }
            case Failure():
              return LoginResponse(LoginStatus.loginErrorUnknown);
          }
        }
      case Failure(errorResponse: final errorResponse):
        final exception = errorResponse.exception;
        if (exception is ServerException && exception.statusCode == 422) {
          return LoginResponse(LoginStatus.loginChangePassword);
        }

        return LoginResponse(LoginStatus.loginErrorUnsuccessful,
            message: errorResponse.extractErrorMessage());
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
    final success =
        await _timed('Face ID prompt', authenticateWithBiometrics());
    if (success) {
      final loginSuccess = await _timed(
          'stored credential sign in',
          coreServiceProvider
              .getBiometricAuthenticationService()
              .logInWithStoredCredentials());

      if (!loginSuccess) {
        return LoginStatus.loginErrorUnsuccessful;
      }

      final sessionResponse = await _timed(
          'get current session',
          commerceAPIServiceProvider.getSessionService().getCurrentSession());

      switch (sessionResponse) {
        case Success(value: final fullSession):
          {
            if (fullSession == null) {
              return LoginStatus.loginErrorUnknown;
            }

            final deviceToken = await coreServiceProvider
                .getDeviceTokenService()
                .getDeviceToken();

            if (!deviceToken.isNullOrEmpty) {
              unawaited(
                commerceAPIServiceProvider
                    .getPushNotificationService()
                    .registerDeviceToken(
                      DeviceTokenRegistrationParameters(
                        deviceToken: deviceToken,
                      ),
                    ),
              );
            }

            final accountResult = await _timed(
                'get current account',
                commerceAPIServiceProvider
                    .getAccountService()
                    .getCurrentAccountAsync());

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
    await commerceAPIServiceProvider
        .getCacheService()
        .invalidateAllObjectsExcept([CoreConstants.domainKey]);
    final deviceToken =
        await coreServiceProvider.getDeviceTokenService().getDeviceToken();
    if (!deviceToken.isNullOrEmpty) {
      await commerceAPIServiceProvider
          .getPushNotificationService()
          .unRegisterDeviceToken(
              DeviceTokenUnregistrationParameters(deviceToken: deviceToken));
    }

    await commerceAPIServiceProvider.getAuthenticationService().logoutAsync();
  }
}
