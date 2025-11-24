import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/device_token_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockBiometricAuthenticationService extends Mock
    implements IBiometricAuthenticationService {}

class MockDeviceService extends Mock implements IDeviceService {}

class MockDeviceTokenService extends Mock implements IDeviceTokenService {}

class MockPushNotificationService extends Mock
    implements IPushNotificationService {}

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

// Create a testable version of BiometricUsecase that allows mocking LocalAuthentication
class TestableBiometricUsecase extends BiometricUsecase {
  final LocalAuthentication? mockLocalAuth;

  TestableBiometricUsecase({this.mockLocalAuth}) : super();

  @override
  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication auth = mockLocalAuth ?? LocalAuthentication();
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
}

void main() {
  final sl = GetIt.instance;

  late TestableBiometricUsecase biometricUsecase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockBiometricAuthenticationService mockBiometricAuthenticationService;
  late MockDeviceService mockDeviceService;
  late MockDeviceTokenService mockDeviceTokenService;
  late MockPushNotificationService mockPushNotificationService;
  late MockAuthenticationService mockAuthenticationService;
  late MockCacheService mockCacheService;
  late MockTrackingService mockTrackingService;
  late MockLocalAuthentication mockLocalAuthentication;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(const AuthenticationOptions());
    registerFallbackValue(DeviceTokenUnregistrationParameters(deviceToken: ''));
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockBiometricAuthenticationService = MockBiometricAuthenticationService();
    mockDeviceService = MockDeviceService();
    mockDeviceTokenService = MockDeviceTokenService();
    mockPushNotificationService = MockPushNotificationService();
    mockAuthenticationService = MockAuthenticationService();
    mockCacheService = MockCacheService();
    mockTrackingService = MockTrackingService();
    mockLocalAuthentication = MockLocalAuthentication();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);
    sl.registerLazySingleton<ITrackingService>(() => mockTrackingService);

    // Mock service provider dependencies
    when(() => mockCoreServiceProvider.getBiometricAuthenticationService())
        .thenReturn(mockBiometricAuthenticationService);
    when(() => mockCoreServiceProvider.getDeviceService())
        .thenReturn(mockDeviceService);
    when(() => mockCoreServiceProvider.getDeviceTokenService())
        .thenReturn(mockDeviceTokenService);
    when(() => mockCommerceAPIServiceProvider.getAuthenticationService())
        .thenReturn(mockAuthenticationService);
    when(() => mockCommerceAPIServiceProvider.getCacheService())
        .thenReturn(mockCacheService);
    when(() => mockCommerceAPIServiceProvider.getPushNotificationService())
        .thenReturn(mockPushNotificationService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    // Set up tracking service mock
    when(() => mockTrackingService.trackError(any(),
        trace: any(named: 'trace'),
        reason: any(named: 'reason'))).thenAnswer((_) async {});

    // Initialize the use case with mock LocalAuthentication
    biometricUsecase = TestableBiometricUsecase(
      mockLocalAuth: mockLocalAuthentication,
    );
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('BiometricUsecase Tests', () {
    group('getBiometricOptions', () {
      test('should return DeviceAuthenticationOption when service succeeds',
          () async {
        // Arrange
        const expectedOption = DeviceAuthenticationOption.touchID;
        when(() => mockDeviceService.authenticationOption())
            .thenAnswer((_) async => expectedOption);

        // Act
        final result = await biometricUsecase.getBiometricOptions();

        // Assert
        expect(result, equals(DeviceAuthenticationOption.touchID));
        verify(() => mockDeviceService.authenticationOption()).called(1);
      });

      test('should return faceID when device supports it', () async {
        // Arrange
        const expectedOption = DeviceAuthenticationOption.faceID;
        when(() => mockDeviceService.authenticationOption())
            .thenAnswer((_) async => expectedOption);

        // Act
        final result = await biometricUsecase.getBiometricOptions();

        // Assert
        expect(result, equals(DeviceAuthenticationOption.faceID));
        verify(() => mockDeviceService.authenticationOption()).called(1);
      });

      test('should return none when device has no biometric options', () async {
        // Arrange
        const expectedOption = DeviceAuthenticationOption.none;
        when(() => mockDeviceService.authenticationOption())
            .thenAnswer((_) async => expectedOption);

        // Act
        final result = await biometricUsecase.getBiometricOptions();

        // Assert
        expect(result, equals(DeviceAuthenticationOption.none));
        verify(() => mockDeviceService.authenticationOption()).called(1);
      });

      test('should handle exceptions from device service', () async {
        // Arrange
        when(() => mockDeviceService.authenticationOption())
            .thenThrow(Exception('Device service error'));

        // Act & Assert
        expect(() => biometricUsecase.getBiometricOptions(), throwsException);
        verify(() => mockDeviceService.authenticationOption()).called(1);
      });
    });

    group('authenticateWithBiometrics', () {
      test('should return true when biometric authentication succeeds',
          () async {
        // Arrange
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);

        // Act
        final result = await biometricUsecase.authenticateWithBiometrics();

        // Assert
        expect(result, isTrue);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
      });

      test('should return false when biometric authentication fails', () async {
        // Arrange
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => false);

        // Act
        final result = await biometricUsecase.authenticateWithBiometrics();

        // Assert
        expect(result, isFalse);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
      });

      test('should return false when PlatformException is thrown', () async {
        // Arrange
        when(() => mockLocalAuthentication.authenticate(
                  localizedReason: any(named: 'localizedReason'),
                  options: any(named: 'options'),
                ))
            .thenThrow(
                PlatformException(code: 'error', message: 'Biometric failed'));

        // Act
        final result = await biometricUsecase.authenticateWithBiometrics();

        // Assert
        expect(result, isFalse);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
      });

      test('should use correct authentication options', () async {
        // Arrange
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);

        // Act
        await biometricUsecase.authenticateWithBiometrics();

        // Assert
        final captured = verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: captureAny(named: 'options'),
            )).captured.single as AuthenticationOptions;

        expect(captured.biometricOnly, isTrue);
        expect(captured.stickyAuth, isTrue);
      });
    });

    group('enableBiometricsWithPassword', () {
      test(
          'should return true when biometric auth succeeds and service enables biometrics',
          () async {
        // Arrange
        const password = 'testpassword';
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);
        when(() => mockBiometricAuthenticationService
                .enableBiometricAuthentication(password))
            .thenAnswer((_) async => true);

        // Act
        final result =
            await biometricUsecase.enableBiometricsWithPassword(password);

        // Assert
        expect(result, isTrue);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
        verify(() => mockBiometricAuthenticationService
            .enableBiometricAuthentication(password)).called(1);
      });

      test('should return false when biometric authentication fails', () async {
        // Arrange
        const password = 'testpassword';
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => false);

        // Act
        final result =
            await biometricUsecase.enableBiometricsWithPassword(password);

        // Assert
        expect(result, isFalse);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
        verifyNever(() => mockBiometricAuthenticationService
            .enableBiometricAuthentication(any()));
      });

      test(
          'should return false when biometric auth succeeds but service fails to enable',
          () async {
        // Arrange
        const password = 'testpassword';
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);
        when(() => mockBiometricAuthenticationService
                .enableBiometricAuthentication(password))
            .thenAnswer((_) async => false);

        // Act
        final result =
            await biometricUsecase.enableBiometricsWithPassword(password);

        // Assert
        expect(result, isFalse);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
        verify(() => mockBiometricAuthenticationService
            .enableBiometricAuthentication(password)).called(1);
      });
    });

    group('enableBiometricsWhileLoggedIn', () {
      test(
          'should return true when password auth and biometric enabling both succeed',
          () async {
        // Arrange
        const password = 'testpassword';
        when(() => mockBiometricAuthenticationService.authenticate(password))
            .thenAnswer((_) async => true);
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);
        when(() => mockBiometricAuthenticationService
                .enableBiometricAuthentication(password))
            .thenAnswer((_) async => true);

        // Act
        final result =
            await biometricUsecase.enableBiometricsWhileLoggedIn(password);

        // Assert
        expect(result, isTrue);
        verify(() => mockBiometricAuthenticationService.authenticate(password))
            .called(1);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
        verify(() => mockBiometricAuthenticationService
            .enableBiometricAuthentication(password)).called(1);
      });

      test('should return true when password authentication fails', () async {
        // Arrange
        const password = 'wrongpassword';
        when(() => mockBiometricAuthenticationService.authenticate(password))
            .thenAnswer((_) async => false);

        // Act
        final result =
            await biometricUsecase.enableBiometricsWhileLoggedIn(password);

        // Assert
        expect(result, isFalse);
        verify(() => mockBiometricAuthenticationService.authenticate(password))
            .called(1);
        verifyNever(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            ));
        verifyNever(() => mockBiometricAuthenticationService
            .enableBiometricAuthentication(any()));
      });

      test(
          'should return false when password auth succeeds but biometric enabling fails',
          () async {
        // Arrange
        const password = 'testpassword';
        when(() => mockBiometricAuthenticationService.authenticate(password))
            .thenAnswer((_) async => true);
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => false);

        // Act
        final result =
            await biometricUsecase.enableBiometricsWhileLoggedIn(password);

        // Assert
        expect(result, isFalse);
        verify(() => mockBiometricAuthenticationService.authenticate(password))
            .called(1);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
        verifyNever(() => mockBiometricAuthenticationService
            .enableBiometricAuthentication(any()));
      });
    });

    group('cancelBiometricSignIn', () {
      test('should call all required services to cancel biometric sign in',
          () async {
        // Arrange
        const deviceToken = 'test-device-token';
        when(() => mockBiometricAuthenticationService
            .logoutWithStoredCredentials()).thenAnswer((_) async {});
        when(() => mockCacheService.invalidateAllObjectsExcept(any()))
            .thenAnswer((_) async {});
        when(() => mockDeviceTokenService.getDeviceToken())
            .thenAnswer((_) async => deviceToken);
        when(() => mockPushNotificationService.unRegisterDeviceToken(any()))
            .thenAnswer(
                (_) async => Success(DeviceTokenResponse(success: true)));
        when(() => mockAuthenticationService.logoutAsync())
            .thenAnswer((_) async => const Success(true));

        // Act
        await biometricUsecase.cancelBiometricSignIn();

        // Assert
        verify(() => mockBiometricAuthenticationService
            .logoutWithStoredCredentials()).called(1);
        verify(() => mockCacheService
            .invalidateAllObjectsExcept([CoreConstants.domainKey])).called(1);
        verify(() => mockDeviceTokenService.getDeviceToken()).called(1);
        verify(() => mockPushNotificationService.unRegisterDeviceToken(any()))
            .called(1);
        verify(() => mockAuthenticationService.logoutAsync()).called(1);
      });

      test('should handle exceptions during cancellation gracefully', () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .logoutWithStoredCredentials())
            .thenThrow(Exception('Logout failed'));
        when(() => mockCacheService.invalidateAllObjectsExcept(any()))
            .thenAnswer((_) async {});
        when(() => mockAuthenticationService.logoutAsync())
            .thenAnswer((_) async => const Success(true));

        // Act & Assert
        expect(() => biometricUsecase.cancelBiometricSignIn(), throwsException);
        verify(() => mockBiometricAuthenticationService
            .logoutWithStoredCredentials()).called(1);
      });

      test(
          'should skip push notification unregister when device token is empty',
          () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
            .logoutWithStoredCredentials()).thenAnswer((_) async {});
        when(() => mockCacheService.invalidateAllObjectsExcept(any()))
            .thenAnswer((_) async {});
        when(() => mockDeviceTokenService.getDeviceToken())
            .thenAnswer((_) async => '');
        when(() => mockAuthenticationService.logoutAsync())
            .thenAnswer((_) async => const Success(true));

        // Act
        await biometricUsecase.cancelBiometricSignIn();

        // Assert
        verify(() => mockBiometricAuthenticationService
            .logoutWithStoredCredentials()).called(1);
        verify(() => mockCacheService
            .invalidateAllObjectsExcept([CoreConstants.domainKey])).called(1);
        verify(() => mockDeviceTokenService.getDeviceToken()).called(1);
        verifyNever(
            () => mockPushNotificationService.unRegisterDeviceToken(any()));
        verify(() => mockAuthenticationService.logoutAsync()).called(1);
      });
    });

    group('markCurrentUserHasSeenBiometricOptions', () {
      test('should call biometric service to mark user as seen options',
          () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .markCurrentUserAsSeenEnableBiometricOptionView())
            .thenAnswer((_) async {});

        // Act
        await biometricUsecase.markCurrentUserHasSeenBiometricOptions();

        // Assert
        verify(() => mockBiometricAuthenticationService
            .markCurrentUserAsSeenEnableBiometricOptionView()).called(1);
      });

      test('should handle exceptions from biometric service', () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .markCurrentUserAsSeenEnableBiometricOptionView())
            .thenThrow(Exception('Service error'));

        // Act & Assert
        expect(() => biometricUsecase.markCurrentUserHasSeenBiometricOptions(),
            throwsException);
        verify(() => mockBiometricAuthenticationService
            .markCurrentUserAsSeenEnableBiometricOptionView()).called(1);
      });
    });

    group('isBiometricAuthenticationEnableForCurrentUser', () {
      test('should return true when biometric authentication is enabled',
          () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .isBiometricAuthenticationEnableForCurrentUser())
            .thenAnswer((_) async => true);

        // Act
        final result = await biometricUsecase
            .isBiometricAuthenticationEnableForCurrentUser();

        // Assert
        expect(result, isTrue);
        verify(() => mockBiometricAuthenticationService
            .isBiometricAuthenticationEnableForCurrentUser()).called(1);
      });

      test('should return false when biometric authentication is disabled',
          () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .isBiometricAuthenticationEnableForCurrentUser())
            .thenAnswer((_) async => false);

        // Act
        final result = await biometricUsecase
            .isBiometricAuthenticationEnableForCurrentUser();

        // Assert
        expect(result, isFalse);
        verify(() => mockBiometricAuthenticationService
            .isBiometricAuthenticationEnableForCurrentUser()).called(1);
      });

      test('should handle exceptions from biometric service', () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .isBiometricAuthenticationEnableForCurrentUser())
            .thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
            () => biometricUsecase
                .isBiometricAuthenticationEnableForCurrentUser(),
            throwsException);
        verify(() => mockBiometricAuthenticationService
            .isBiometricAuthenticationEnableForCurrentUser()).called(1);
      });
    });

    group('disableBiometricAuthentication', () {
      test(
          'should return true when disabling biometric authentication succeeds',
          () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
            .disableBiometricAuthentication()).thenAnswer((_) async => true);

        // Act
        final result = await biometricUsecase.disableBiometricAuthentication();

        // Assert
        expect(result, isTrue);
        verify(() => mockBiometricAuthenticationService
            .disableBiometricAuthentication()).called(1);
      });

      test('should return false when disabling biometric authentication fails',
          () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
            .disableBiometricAuthentication()).thenAnswer((_) async => false);

        // Act
        final result = await biometricUsecase.disableBiometricAuthentication();

        // Assert
        expect(result, isFalse);
        verify(() => mockBiometricAuthenticationService
            .disableBiometricAuthentication()).called(1);
      });

      test('should handle exceptions from biometric service', () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .disableBiometricAuthentication())
            .thenThrow(Exception('Service error'));

        // Act & Assert
        expect(() => biometricUsecase.disableBiometricAuthentication(),
            throwsException);
        verify(() => mockBiometricAuthenticationService
            .disableBiometricAuthentication()).called(1);
      });
    });

    group('integration tests', () {
      test('should handle complete biometric enablement workflow', () async {
        // Arrange
        const password = 'testpassword';
        when(() => mockDeviceService.authenticationOption())
            .thenAnswer((_) async => DeviceAuthenticationOption.touchID);
        when(() => mockBiometricAuthenticationService.authenticate(password))
            .thenAnswer((_) async => true);
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);
        when(() => mockBiometricAuthenticationService
                .enableBiometricAuthentication(password))
            .thenAnswer((_) async => true);
        when(() => mockBiometricAuthenticationService
                .isBiometricAuthenticationEnableForCurrentUser())
            .thenAnswer((_) async => true);

        // Act
        final biometricOptions = await biometricUsecase.getBiometricOptions();
        final enableResult =
            await biometricUsecase.enableBiometricsWhileLoggedIn(password);
        final isEnabled = await biometricUsecase
            .isBiometricAuthenticationEnableForCurrentUser();

        // Assert
        expect(biometricOptions, equals(DeviceAuthenticationOption.touchID));
        expect(enableResult, isTrue);
        expect(isEnabled, isTrue);

        // Verify all service calls
        verify(() => mockDeviceService.authenticationOption()).called(1);
        verify(() => mockBiometricAuthenticationService.authenticate(password))
            .called(1);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(1);
        verify(() => mockBiometricAuthenticationService
            .enableBiometricAuthentication(password)).called(1);
        verify(() => mockBiometricAuthenticationService
            .isBiometricAuthenticationEnableForCurrentUser()).called(1);
      });

      test('should handle complete biometric disablement workflow', () async {
        // Arrange
        when(() => mockBiometricAuthenticationService
                .isBiometricAuthenticationEnableForCurrentUser())
            .thenAnswer((_) async => true);
        when(() => mockBiometricAuthenticationService
            .disableBiometricAuthentication()).thenAnswer((_) async => true);

        // Act
        final initiallyEnabled = await biometricUsecase
            .isBiometricAuthenticationEnableForCurrentUser();
        final disableResult =
            await biometricUsecase.disableBiometricAuthentication();

        // Change mock behavior for final check
        when(() => mockBiometricAuthenticationService
                .isBiometricAuthenticationEnableForCurrentUser())
            .thenAnswer((_) async => false);

        final finallyEnabled = await biometricUsecase
            .isBiometricAuthenticationEnableForCurrentUser();

        // Assert
        expect(initiallyEnabled, isTrue);
        expect(disableResult, isTrue);
        expect(finallyEnabled, isFalse);

        // Verify service calls
        verify(() => mockBiometricAuthenticationService
            .isBiometricAuthenticationEnableForCurrentUser()).called(2);
        verify(() => mockBiometricAuthenticationService
            .disableBiometricAuthentication()).called(1);
      });

      test('should handle complete cancellation workflow', () async {
        // Arrange
        const deviceToken = 'test-device-token';
        when(() => mockBiometricAuthenticationService
            .logoutWithStoredCredentials()).thenAnswer((_) async {});
        when(() => mockCacheService.invalidateAllObjectsExcept(any()))
            .thenAnswer((_) async {});
        when(() => mockDeviceTokenService.getDeviceToken())
            .thenAnswer((_) async => deviceToken);
        when(() => mockPushNotificationService.unRegisterDeviceToken(any()))
            .thenAnswer(
                (_) async => Success(DeviceTokenResponse(success: true)));
        when(() => mockAuthenticationService.logoutAsync())
            .thenAnswer((_) async => const Success(true));
        when(() => mockBiometricAuthenticationService
                .markCurrentUserAsSeenEnableBiometricOptionView())
            .thenAnswer((_) async {});

        // Act
        await biometricUsecase.cancelBiometricSignIn();
        await biometricUsecase.markCurrentUserHasSeenBiometricOptions();

        // Assert
        verify(() => mockBiometricAuthenticationService
            .logoutWithStoredCredentials()).called(1);
        verify(() => mockCacheService
            .invalidateAllObjectsExcept([CoreConstants.domainKey])).called(1);
        verify(() => mockDeviceTokenService.getDeviceToken()).called(1);
        verify(() => mockPushNotificationService.unRegisterDeviceToken(any()))
            .called(1);
        verify(() => mockAuthenticationService.logoutAsync()).called(1);
        verify(() => mockBiometricAuthenticationService
            .markCurrentUserAsSeenEnableBiometricOptionView()).called(1);
      });
    });

    group('edge cases', () {
      test('should handle multiple rapid authentication attempts', () async {
        // Arrange
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);

        // Act - Make multiple rapid calls
        final futures = List.generate(
            3, (index) => biometricUsecase.authenticateWithBiometrics());
        final results = await Future.wait(futures);

        // Assert
        expect(results, everyElement(isTrue));
        expect(results, hasLength(3));
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(3);
      });

      test('should handle mixed authentication results', () async {
        // Arrange
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => true);

        final result1 = await biometricUsecase.authenticateWithBiometrics();

        // Change mock behavior for second call
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenAnswer((_) async => false);

        final result2 = await biometricUsecase.authenticateWithBiometrics();

        // Change mock behavior for third call to throw exception
        when(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            )).thenThrow(PlatformException(code: 'error'));

        final result3 = await biometricUsecase.authenticateWithBiometrics();

        // Assert
        expect(result1, isTrue);
        expect(result2, isFalse);
        expect(result3, isFalse);
        verify(() => mockLocalAuthentication.authenticate(
              localizedReason: 'Authenticate for biometric login',
              options: any(named: 'options'),
            )).called(3);
      });

      test('should handle empty password in enable methods', () async {
        // Arrange
        const emptyPassword = '';
        when(() =>
                mockBiometricAuthenticationService.authenticate(emptyPassword))
            .thenAnswer((_) async => false);

        // Act
        final result =
            await biometricUsecase.enableBiometricsWhileLoggedIn(emptyPassword);

        // Assert
        expect(result, isFalse);
        verify(() =>
                mockBiometricAuthenticationService.authenticate(emptyPassword))
            .called(1);
        verifyNever(() => mockLocalAuthentication.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            ));
      });

      test(
          'should handle device service returning different authentication options',
          () async {
        // Arrange & Act & Assert for touchID
        when(() => mockDeviceService.authenticationOption())
            .thenAnswer((_) async => DeviceAuthenticationOption.touchID);
        final touchIDResult = await biometricUsecase.getBiometricOptions();
        expect(touchIDResult, equals(DeviceAuthenticationOption.touchID));

        // Change for faceID
        when(() => mockDeviceService.authenticationOption())
            .thenAnswer((_) async => DeviceAuthenticationOption.faceID);
        final faceIDResult = await biometricUsecase.getBiometricOptions();
        expect(faceIDResult, equals(DeviceAuthenticationOption.faceID));

        // Change for none
        when(() => mockDeviceService.authenticationOption())
            .thenAnswer((_) async => DeviceAuthenticationOption.none);
        final noneResult = await biometricUsecase.getBiometricOptions();
        expect(noneResult, equals(DeviceAuthenticationOption.none));

        verify(() => mockDeviceService.authenticationOption()).called(3);
      });
    });
  });
}
