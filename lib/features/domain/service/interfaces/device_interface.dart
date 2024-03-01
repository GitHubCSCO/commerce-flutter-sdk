abstract class IDeviceService {
  bool get isTablet;

  bool get isPhone;

  bool get isDesktop;

  bool get isIOS;

  bool get isAndroid;

  bool get isWindows;

  bool get isWinPhone;

  double get screenWidth;

  double get screenHeight;

  bool get isLandscape;

  bool get hasCamera;

  String get currentVersion;

  String get applicationName;

  Future<DeviceAuthenticationOption> get authenticationOption;

  Future<void> biometricAuthentication(void Function() callback);

  bool isRunningOSVersionOrGreater(int majorVersion, int minorVersion);
}

enum DeviceAuthenticationOption { none, touchID, faceID }
