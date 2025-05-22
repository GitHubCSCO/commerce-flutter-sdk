import 'dart:io';

import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/device_interface.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceService implements IDeviceService {
  PackageInfo? packageInfo;

  DeviceService();

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  @override
  String? get applicationName => packageInfo?.appName;

  @override
  Future<DeviceAuthenticationOption> authenticationOption() async {
    final LocalAuthentication auth = LocalAuthentication();
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      return DeviceAuthenticationOption.none;
    }

    if (isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        return DeviceAuthenticationOption.faceID;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return DeviceAuthenticationOption.touchID;
      } else {
        return DeviceAuthenticationOption.none;
      }
    } else if (isAndroid) {
      const platform = MethodChannel('biometric_channel');

      String biometricType = '';

      String type;
      try {
        final String result = await platform.invokeMethod('getBiometricType');
        type = result;
      } on PlatformException {
        type = 'Unknown';
      }

      biometricType = type;

      if (biometricType == 'Fingerprint') {
        return DeviceAuthenticationOption.touchID;
      } else if (biometricType == 'Face') {
        return DeviceAuthenticationOption.faceID;
      } else {
        return DeviceAuthenticationOption.none;
      }
    } else {
      return DeviceAuthenticationOption.none;
    }
  }

  @override
  Future<void> biometricAuthentication(void Function() callback) {
    // TODO: implement biometricAuthentication
    throw UnimplementedError();
  }

  @override
  String get currentVersion {
    String version = packageInfo!.version;
    String buildNumber = packageInfo!.buildNumber;

    String verionAndBuildNum = 'Version $version ($buildNumber)';

    return verionAndBuildNum;
  }

  @override
  // TODO: implement hasCamera
  bool get hasCamera => throw UnimplementedError();

  @override
  bool get isAndroid => Platform.isAndroid;

  @override
  bool get isDesktop =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  @override
  bool get isIOS => Platform.isIOS;

  @override
  // TODO: implement isLandscape
  bool get isLandscape => throw UnimplementedError();

  @override
  // TODO: implement isPhone
  bool get isPhone => throw UnimplementedError();

  @override
  bool isRunningOSVersionOrGreater(int majorVersion, int minorVersion) {
    // TODO: implement isRunningOSVersionOrGreater
    throw UnimplementedError();
  }

  @override
  // TODO: implement isTablet
  bool get isTablet => throw UnimplementedError();

  @override
  // TODO: implement isWinPhone
  bool get isWinPhone => throw UnimplementedError();

  @override
  // TODO: implement isWindows
  bool get isWindows => throw UnimplementedError();

  @override
  // TODO: implement screenHeight
  double get screenHeight => throw UnimplementedError();

  @override
  // TODO: implement screenWidth
  double get screenWidth => throw UnimplementedError();
}
