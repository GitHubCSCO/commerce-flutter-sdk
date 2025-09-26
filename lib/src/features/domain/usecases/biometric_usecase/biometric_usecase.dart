import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BiometricUsecase extends BaseUseCase {
  BiometricUsecase() : super();

  Future<DeviceAuthenticationOption> getBiometricOptions() async {
    return await coreServiceProvider.getDeviceService().authenticationOption();
  }

  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate for biometric login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      return authenticated;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> enableBiometricsWithPassword(String password) async {
    final success = await authenticateWithBiometrics();
    if (success) {
      final result = coreServiceProvider
          .getBiometricAuthenticationService()
          .enableBiometricAuthentication(password);

      return result;
    }

    return false;
  }

  Future<bool> enableBiometricsWhileLoggedIn(String password) async {
    final serviceCallResult = await coreServiceProvider
        .getBiometricAuthenticationService()
        .authenticate(password);
    if (serviceCallResult) {
      final result = await enableBiometricsWithPassword(password);
      return result;
    }

    return false;
  }

  Future<void> cancelBiometricSignIn() async {
    await coreServiceProvider
        .getBiometricAuthenticationService()
        .logoutWithStoredCredentials();
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

  Future<void> markCurrentUserHasSeenBiometricOptions() async {
    await coreServiceProvider
        .getBiometricAuthenticationService()
        .markCurrentUserAsSeenEnableBiometricOptionView();
  }

  Future<bool> isBiometricAuthenticationEnableForCurrentUser() async {
    return await coreServiceProvider
        .getBiometricAuthenticationService()
        .isBiometricAuthenticationEnableForCurrentUser();
  }

  Future<bool> disableBiometricAuthentication() async {
    return await coreServiceProvider
        .getBiometricAuthenticationService()
        .disableBiometricAuthentication();
  }
}
