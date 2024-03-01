import 'package:commerce_flutter_app/features/domain/service/interfaces/device_interface.dart';

class DeviceService implements IDeviceService {
  @override
  // TODO: implement applicationName
  String get applicationName => throw UnimplementedError();

  @override
  // TODO: implement authenticationOption
  Future<DeviceAuthenticationOption> get authenticationOption =>
      throw UnimplementedError();

  @override
  Future<void> biometricAuthentication(void Function() callback) {
    // TODO: implement biometricAuthentication
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentVersion
  String get currentVersion => throw UnimplementedError();

  @override
  // TODO: implement hasCamera
  bool get hasCamera => throw UnimplementedError();

  @override
  // TODO: implement isAndroid
  bool get isAndroid => throw UnimplementedError();

  @override
  // TODO: implement isDesktop
  bool get isDesktop => throw UnimplementedError();

  @override
  // TODO: implement isIOS
  bool get isIOS => throw UnimplementedError();

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
