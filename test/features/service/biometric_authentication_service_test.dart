import 'package:commerce_flutter_sdk/src/features/domain/service/biometric_authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockSecureStorageService extends Mock implements ISecureStorageService {}

class MockLocalStorageService extends Mock implements ILocalStorageService {}

class MockAuthenticationService extends Mock
    implements IAuthenticationService {}

class MockSessionService extends Mock implements ISessionService {}

class MockClientService extends Mock implements IClientService {}

class MockSession extends Mock implements Session {}

void main() {
  late BiometricAuthenticationService service;
  late MockCommerceAPIServiceProvider mockProvider;
  late MockSecureStorageService mockSecureStorage;
  late MockLocalStorageService mockLocalStorage;
  late MockAuthenticationService mockAuthService;
  late MockSessionService mockSessionService;
  late MockClientService mockClientService;
  late MockSession mockSession;

  setUp(() {
    mockProvider = MockCommerceAPIServiceProvider();
    mockSecureStorage = MockSecureStorageService();
    mockLocalStorage = MockLocalStorageService();
    mockAuthService = MockAuthenticationService();
    mockSessionService = MockSessionService();
    mockClientService = MockClientService();
    mockSession = MockSession();

    when(() => mockProvider.getSecureStorageService())
        .thenReturn(mockSecureStorage);
    when(() => mockProvider.getLocalStorageService())
        .thenReturn(mockLocalStorage);
    when(() => mockProvider.getAuthenticationService())
        .thenReturn(mockAuthService);
    when(() => mockProvider.getSessionService()).thenReturn(mockSessionService);
    when(() => mockProvider.getClientService()).thenReturn(mockClientService);

    service = BiometricAuthenticationService(
        commerceAPIServiceProvider: mockProvider);
  });

  group('authenticate', () {
    test('returns false when no userName is available', () async {
      when(() => mockSessionService.getCachedCurrentSession()).thenReturn(null);

      final result = await service.authenticate('password123');

      expect(result, isFalse);
    });

    test('returns true when authentication succeeds', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockAuthService.logInAsync('testUser', 'password123'))
          .thenAnswer((_) async => Success(true));

      final result = await service.authenticate('password123');

      expect(result, isTrue);
    });

    test('returns false when authentication fails', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockAuthService.logInAsync('testUser', 'password123'))
          .thenAnswer(
              (_) async => Failure(ErrorResponse(error: 'Auth failed')));

      final result = await service.authenticate('password123');

      expect(result, isFalse);
    });
  });

  group('disableBiometricAuthentication', () {
    test('returns true when all storage items are successfully removed',
        () async {
      when(() => mockSecureStorage.remove('domain'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.remove('userName'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.remove('password'))
          .thenAnswer((_) async => true);

      final result = await service.disableBiometricAuthentication();

      expect(result, isTrue);
      verify(() => mockSecureStorage.remove('domain')).called(1);
      verify(() => mockSecureStorage.remove('userName')).called(1);
      verify(() => mockSecureStorage.remove('password')).called(1);
    });

    test('returns false when any storage item removal fails', () async {
      when(() => mockSecureStorage.remove('domain'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.remove('userName'))
          .thenAnswer((_) async => false);
      when(() => mockSecureStorage.remove('password'))
          .thenAnswer((_) async => true);

      final result = await service.disableBiometricAuthentication();

      expect(result, isFalse);
    });
  });

  group('enableBiometricAuthentication', () {
    test('returns false when userName is not available', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn(null);
      when(() => mockClientService.host).thenReturn('test-domain.com');

      final result = await service.enableBiometricAuthentication('password123');

      expect(result, isFalse);
    });

    test('returns false when domain is not available', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn(null);

      final result = await service.enableBiometricAuthentication('password123');

      expect(result, isFalse);
    });

    test('returns true when all credentials are saved successfully', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn('test-domain.com');
      when(() => mockSecureStorage.save('domain', 'test-domain.com'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.save('userName', 'testUser'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.save('password', 'password123'))
          .thenAnswer((_) async => true);

      final result = await service.enableBiometricAuthentication('password123');

      expect(result, isTrue);
      verify(() => mockSecureStorage.save('domain', 'test-domain.com'))
          .called(1);
      verify(() => mockSecureStorage.save('userName', 'testUser')).called(1);
      verify(() => mockSecureStorage.save('password', 'password123')).called(1);
    });

    test('returns false when any credential save fails', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn('test-domain.com');
      when(() => mockSecureStorage.save('domain', 'test-domain.com'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.save('userName', 'testUser'))
          .thenAnswer((_) async => false);
      when(() => mockSecureStorage.save('password', 'password123'))
          .thenAnswer((_) async => true);

      final result = await service.enableBiometricAuthentication('password123');

      expect(result, isFalse);
    });
  });

  group('hasCurrentUserSeenEnableBiometricOptionView', () {
    test('returns false when domain is not available', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn(null);

      final result =
          await service.hasCurrentUserSeenEnableBiometricOptionView();

      expect(result, isFalse);
    });

    test('returns false when userName is not available', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn(null);
      when(() => mockClientService.host).thenReturn('test-domain.com');

      final result =
          await service.hasCurrentUserSeenEnableBiometricOptionView();

      expect(result, isFalse);
    });

    test('returns true when user has seen the option view', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn('test-domain.com');
      when(() =>
              mockLocalStorage.load('biometricOptiontest-domain.comtestUser'))
          .thenAnswer((_) async => 'testUser');

      final result =
          await service.hasCurrentUserSeenEnableBiometricOptionView();

      expect(result, isTrue);
    });

    test('returns false when user has not seen the option view', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn('test-domain.com');
      when(() =>
              mockLocalStorage.load('biometricOptiontest-domain.comtestUser'))
          .thenAnswer((_) async => null);

      final result =
          await service.hasCurrentUserSeenEnableBiometricOptionView();

      expect(result, isFalse);
    });
  });

  group('hasStoredCredentialsForCurrentDomain', () {
    test('returns false when stored domain does not match current domain',
        () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => 'other-domain.com');

      final result = await service.hasStoredCredentialsForCurrentDomain();

      expect(result, isFalse);
    });

    test('returns false when stored domain is empty', () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => null);

      final result = await service.hasStoredCredentialsForCurrentDomain();

      expect(result, isFalse);
    });

    test('returns true when stored domain matches and credentials exist',
        () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => 'current-domain.com');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'testUser');
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => 'password123');

      final result = await service.hasStoredCredentialsForCurrentDomain();

      expect(result, isTrue);
    });

    test('returns false when stored domain matches but userName is missing',
        () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => 'current-domain.com');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => null);
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => 'password123');

      final result = await service.hasStoredCredentialsForCurrentDomain();

      expect(result, isFalse);
    });

    test('returns false when stored domain matches but password is missing',
        () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => 'current-domain.com');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'testUser');
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => null);

      final result = await service.hasStoredCredentialsForCurrentDomain();

      expect(result, isFalse);
    });
  });

  group('isBiometricAuthenticationEnableForCurrentUser', () {
    test('returns false when no stored credentials exist for current domain',
        () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => null);

      final result =
          await service.isBiometricAuthenticationEnableForCurrentUser();

      expect(result, isFalse);
    });

    test('returns true when stored userName matches current userName',
        () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => 'current-domain.com');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'testUser');
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => 'password123');
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');

      final result =
          await service.isBiometricAuthenticationEnableForCurrentUser();

      expect(result, isTrue);
    });

    test('returns false when stored userName does not match current userName',
        () async {
      when(() => mockClientService.host).thenReturn('current-domain.com');
      when(() => mockSecureStorage.load('domain'))
          .thenAnswer((_) async => 'current-domain.com');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'storedUser');
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => 'password123');
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('currentUser');

      final result =
          await service.isBiometricAuthenticationEnableForCurrentUser();

      expect(result, isFalse);
    });
  });

  group('logInWithStoredCredentials', () {
    test('returns false when stored userName is missing', () async {
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => null);
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => 'password123');

      final result = await service.logInWithStoredCredentials();

      expect(result, isFalse);
    });

    test('returns false when stored password is missing', () async {
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'testUser');
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => null);

      final result = await service.logInWithStoredCredentials();

      expect(result, isFalse);
    });

    test('returns true when login succeeds with stored credentials', () async {
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'testUser');
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => 'password123');
      when(() => mockAuthService.logInAsync('testUser', 'password123'))
          .thenAnswer((_) async => Success(true));

      final result = await service.logInWithStoredCredentials();

      expect(result, isTrue);
    });

    test('returns false when login fails with stored credentials', () async {
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'testUser');
      when(() => mockSecureStorage.load('password'))
          .thenAnswer((_) async => 'password123');
      when(() => mockAuthService.logInAsync('testUser', 'password123'))
          .thenAnswer(
              (_) async => Failure(ErrorResponse(error: 'Auth failed')));

      final result = await service.logInWithStoredCredentials();

      expect(result, isFalse);
    });
  });

  group('logoutWithStoredCredentials', () {
    test('removes credentials when current userName matches stored userName',
        () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'testUser');
      when(() => mockSecureStorage.remove('domain'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.remove('userName'))
          .thenAnswer((_) async => true);
      when(() => mockSecureStorage.remove('password'))
          .thenAnswer((_) async => true);

      await service.logoutWithStoredCredentials();

      verify(() => mockSecureStorage.remove('domain')).called(1);
      verify(() => mockSecureStorage.remove('userName')).called(1);
      verify(() => mockSecureStorage.remove('password')).called(1);
    });

    test(
        'does not remove credentials when current userName does not match stored userName',
        () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('currentUser');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'storedUser');

      await service.logoutWithStoredCredentials();

      verifyNever(() => mockSecureStorage.remove(any()));
    });

    test('does not remove credentials when current userName is missing',
        () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn(null);
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => 'storedUser');

      await service.logoutWithStoredCredentials();

      verifyNever(() => mockSecureStorage.remove(any()));
    });

    test('does not remove credentials when stored userName is missing',
        () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('currentUser');
      when(() => mockSecureStorage.load('userName'))
          .thenAnswer((_) async => null);

      await service.logoutWithStoredCredentials();

      verifyNever(() => mockSecureStorage.remove(any()));
    });
  });

  group('markCurrentUserAsSeenEnableBiometricOptionView', () {
    test('saves user preference when domain and userName are available',
        () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn('test-domain.com');
      when(() => mockLocalStorage.save(
              'biometricOptiontest-domain.comtestUser', 'testUser'))
          .thenAnswer((_) async => true);

      await service.markCurrentUserAsSeenEnableBiometricOptionView();

      verify(() => mockLocalStorage.save(
          'biometricOptiontest-domain.comtestUser', 'testUser')).called(1);
    });

    test('does not save when domain is missing', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn('testUser');
      when(() => mockClientService.host).thenReturn(null);

      await service.markCurrentUserAsSeenEnableBiometricOptionView();

      verifyNever(() => mockLocalStorage.save(any(), any()));
    });

    test('does not save when userName is missing', () async {
      when(() => mockSessionService.getCachedCurrentSession())
          .thenReturn(mockSession);
      when(() => mockSession.userName).thenReturn(null);
      when(() => mockClientService.host).thenReturn('test-domain.com');

      await service.markCurrentUserAsSeenEnableBiometricOptionView();

      verifyNever(() => mockLocalStorage.save(any(), any()));
    });
  });
}
