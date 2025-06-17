import 'package:commerce_flutter_sdk/src/features/domain/usecases/auth_usecase/auth_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class FakeAccount extends Fake implements Account {}

void main() {
  final sl = GetIt.instance;

  late AuthUsecase authUsecase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockAuthenticationService mockAuthenticationService;
  late MockAccountService mockAccountService;
  late MockTrackingService mockTrackingService;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeAccount());
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockAuthenticationService = MockAuthenticationService();
    mockAccountService = MockAccountService();
    mockTrackingService = MockTrackingService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);
    sl.registerLazySingleton<ITrackingService>(() => mockTrackingService);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getAuthenticationService())
        .thenReturn(mockAuthenticationService);
    when(() => mockCommerceAPIServiceProvider.getAccountService())
        .thenReturn(mockAccountService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    // Set up tracking service mock
    when(() => mockTrackingService.trackError(any(),
        trace: any(named: 'trace'),
        reason: any(named: 'reason'))).thenAnswer((_) async {});

    // Initialize the use case
    authUsecase = AuthUsecase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('AuthUsecase Tests', () {
    group('isAuthenticated', () {
      test('should return true when user is authenticated', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(true);
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act
        final result = await authUsecase.isAuthenticated();

        // Assert
        expect(result, isTrue);
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });

      test('should return false when user is not authenticated', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(false);
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act
        final result = await authUsecase.isAuthenticated();

        // Assert
        expect(result, isFalse);
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });

      test('should return false when authentication service fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(message: 'Authentication failed');
        final isAuthenticatedResult = Failure<bool, ErrorResponse>(errorResponse);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);

        // Act
        final result = await authUsecase.isAuthenticated();

        // Assert
        expect(result, isFalse);
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verifyNever(() => mockAccountService.getCurrentAccountAsync());
      });

      test('should still return true when getCurrentAccount fails but user is authenticated', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(true);
        final errorResponse = ErrorResponse(message: 'Account fetch failed');
        final getCurrentAccountResult = Failure<Account, ErrorResponse>(errorResponse);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act
        final result = await authUsecase.isAuthenticated();

        // Assert
        expect(result, isTrue);
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });

      test('should handle null authentication result value', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(null);
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act & Assert
        try {
          await authUsecase.isAuthenticated();
          fail('Expected TypeError to be thrown');
        } catch (e) {
          expect(e, isA<TypeError>());
        }
        
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });

      test('should handle exceptions during authentication check', () async {
        // Arrange
        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(() => authUsecase.isAuthenticated(), throwsException);
        
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verifyNever(() => mockAccountService.getCurrentAccountAsync());
      });

      test('should handle exceptions during getCurrentAccount call', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(true);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenThrow(Exception('Account service error'));

        // Act & Assert
        try {
          await authUsecase.isAuthenticated();
          fail('Expected Exception to be thrown');
        } catch (e) {
          expect(e, isA<Exception>());
        }
        
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });
    });

    group('integration tests', () {
      test('should handle complete authentication flow with valid user', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(true);
        final mockAccount = Account(
          userName: 'testuser',
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
        );
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act
        final result = await authUsecase.isAuthenticated();

        // Assert
        expect(result, isTrue);
        
        // Verify the complete flow
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });

      test('should handle authentication flow when user is not authenticated', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(false);
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act
        final result = await authUsecase.isAuthenticated();

        // Assert
        expect(result, isFalse);
        
        // Verify that getCurrentAccount is still called even when not authenticated
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });

      test('should handle multiple consecutive authentication checks', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(true);
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act
        final result1 = await authUsecase.isAuthenticated();
        final result2 = await authUsecase.isAuthenticated();
        final result3 = await authUsecase.isAuthenticated();

        // Assert
        expect(result1, isTrue);
        expect(result2, isTrue);
        expect(result3, isTrue);
        
        // Verify services are called for each check
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(3);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(3);
      });
    });

    group('edge cases', () {
      test('should handle rapid successive authentication calls', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(true);
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => isAuthenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act - Make multiple rapid calls
        final futures = List.generate(5, (index) => authUsecase.isAuthenticated());
        final results = await Future.wait(futures);

        // Assert
        expect(results, everyElement(isTrue));
        expect(results, hasLength(5));
        
        // Verify all calls were made
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(5);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(5);
      });

      test('should handle different authentication states in sequence', () async {
        // Arrange
        final authenticatedResult = Success<bool, ErrorResponse>(true);
        final notAuthenticatedResult = Success<bool, ErrorResponse>(false);
        final errorResult = Failure<bool, ErrorResponse>(ErrorResponse(message: 'Error'));
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => authenticatedResult);
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act & Assert - First call: authenticated
        final result1 = await authUsecase.isAuthenticated();
        expect(result1, isTrue);

        // Change mock behavior for second call: not authenticated
        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => notAuthenticatedResult);

        final result2 = await authUsecase.isAuthenticated();
        expect(result2, isFalse);

        // Change mock behavior for third call: error
        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async => errorResult);

        final result3 = await authUsecase.isAuthenticated();
        expect(result3, isFalse);

        // Verify all calls were made
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(3);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(2); // Not called on error
      });

      test('should handle slow authentication service response', () async {
        // Arrange
        final isAuthenticatedResult = Success<bool, ErrorResponse>(true);
        final mockAccount = Account(userName: 'testuser');
        final getCurrentAccountResult = Success<Account, ErrorResponse>(mockAccount);

        when(() => mockAuthenticationService.isAuthenticatedAsync())
            .thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 100));
          return isAuthenticatedResult;
        });
        when(() => mockAccountService.getCurrentAccountAsync())
            .thenAnswer((_) async => getCurrentAccountResult);

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await authUsecase.isAuthenticated();
        stopwatch.stop();

        // Assert
        expect(result, isTrue);
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(100));
        
        verify(() => mockAuthenticationService.isAuthenticatedAsync()).called(1);
        verify(() => mockAccountService.getCurrentAccountAsync()).called(1);
      });
    });
  });
}
