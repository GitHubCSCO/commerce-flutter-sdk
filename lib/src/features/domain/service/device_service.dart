import 'dart:io';

import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/device_interface.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DeviceService implements IDeviceService {
  PackageInfo? packageInfo;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final Connectivity _connectivity = Connectivity();

  DeviceService();

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  /// Get device and environment properties for telemetry
  @override
  Future<Map<String, String>> getDeviceEnvironmentProperties() async {
    final properties = <String, String>{};

    // App version
    properties['appVersion'] = packageInfo?.version ?? 'unknown';

    // Platform
    if (Platform.isIOS) {
      properties['platform'] = 'iOS';
      final iosInfo = await _deviceInfo.iosInfo;
      properties['deviceModel'] = iosInfo.model;
      properties['osVersion'] =
          '${iosInfo.systemName} ${iosInfo.systemVersion}';
    } else if (Platform.isAndroid) {
      properties['platform'] = 'Android';
      final androidInfo = await _deviceInfo.androidInfo;
      properties['deviceModel'] = androidInfo.model;
      properties['osVersion'] = 'Android ${androidInfo.version.release}';
    } else {
      properties['platform'] = Platform.operatingSystem;
      properties['deviceModel'] = 'unknown';
      properties['osVersion'] = 'unknown';
    }

    // Locale
    properties['locale'] = Platform.localeName;

    // Timezone
    properties['timezone'] = DateTime.now().timeZoneName;

    // Network type
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      properties['networkType'] = 'wifi';
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      properties['networkType'] = 'mobile';
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      properties['networkType'] = 'ethernet';
    } else {
      properties['networkType'] = 'none';
    }

    // Timestamp
    properties['timestamp'] = DateTime.now().toUtc().toIso8601String();

    properties['mobile'] = "true";

    return properties;
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
