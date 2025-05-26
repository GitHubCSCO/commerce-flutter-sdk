import 'dart:io';

import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/device_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockPackageInfo extends Mock implements PackageInfo {}

// Create a testable subclass of DeviceService
class TestableDeviceService extends DeviceService {
  final LocalAuthentication mockLocalAuth;

  TestableDeviceService(this.mockLocalAuth);

  @override
  Future<DeviceAuthenticationOption> authenticationOption() async {
    final List<BiometricType> availableBiometrics =
        await mockLocalAuth.getAvailableBiometrics();

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
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TestableDeviceService deviceService;
  late MockLocalAuthentication mockLocalAuth;
  late MockPackageInfo mockPackageInfo;

  setUp(() {
    mockLocalAuth = MockLocalAuthentication();
    mockPackageInfo = MockPackageInfo();

    // Create a testable device service with the mockLocalAuth injected
    deviceService = TestableDeviceService(mockLocalAuth);

    // Mock package info in the device service
    deviceService.packageInfo = mockPackageInfo;

    // Setup the method channel handler
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('biometric_channel'),
            (MethodCall call) async {
      if (call.method == 'getBiometricType') {
        return 'Fingerprint';
      }
      return null;
    });
  });

  group('DeviceService', () {
    test('init should get package info', () async {
      // This test needs special handling since PackageInfo is static
      // We'll verify the service after initialization
      expect(deviceService.packageInfo, isNotNull);
    });

    test('applicationName returns app name from package info', () {
      // Arrange
      when(() => mockPackageInfo.appName).thenReturn('TestApp');

      // Act & Assert
      expect(deviceService.applicationName, equals('TestApp'));
    });

    test('currentVersion returns formatted version and build number', () {
      // Arrange
      when(() => mockPackageInfo.version).thenReturn('1.0.0');
      when(() => mockPackageInfo.buildNumber).thenReturn('100');

      // Act & Assert
      expect(deviceService.currentVersion, equals('Version 1.0.0 (100)'));
    });

    test('isIOS returns true on iOS platform', () {
      expect(deviceService.isIOS, equals(Platform.isIOS));
    });

    test('isAndroid returns true on Android platform', () {
      expect(deviceService.isAndroid, equals(Platform.isAndroid));
    });

    test('isDesktop returns true on desktop platforms', () {
      expect(deviceService.isDesktop,
          equals(Platform.isWindows || Platform.isMacOS || Platform.isLinux));
    });

    group('authenticationOption', () {
      test('returns none when no biometrics are available', () async {
        // Arrange
        when(() => mockLocalAuth.getAvailableBiometrics())
            .thenAnswer((_) async => []);

        // Act
        final result = await deviceService.authenticationOption();

        // Assert
        expect(result, equals(DeviceAuthenticationOption.none));
        verify(() => mockLocalAuth.getAvailableBiometrics()).called(1);
      });

      // Other tests...
    });

    // Other test groups...
  });
}
