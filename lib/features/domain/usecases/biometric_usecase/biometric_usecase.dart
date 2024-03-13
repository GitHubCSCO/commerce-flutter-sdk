import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

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
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
