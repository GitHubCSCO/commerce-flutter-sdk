import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/fullfillment_method_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/billto_shipto_usecase/billto_shipto_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';

import '../../../../sdk/services/mock_services.dart';

class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockAppConfigurationService extends Mock
    implements IAppConfigurationService {}

// Fake classes for fallback values
class FakeSession extends Fake implements Session {}

class FakeAccount extends Fake implements Account {}

void main() {
  final sl = GetIt.instance;

  late BillToShipToUseCase billToShipToUseCase;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockSessionService mockSessionService;
  late MockAccountService mockAccountService;
  late MockCacheService mockCacheService;
  late MockAppConfigurationService mockAppConfigurationService;
  late MockTrackingService mockTrackingService;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(FakeSession());
    registerFallbackValue(FakeAccount());
  });

  setUp(() async {
    // Reset GetIt before each test
    await sl.reset();

    // Create mock instances
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockSessionService = MockSessionService();
    mockAccountService = MockAccountService();
    mockCacheService = MockCacheService();
    mockAppConfigurationService = MockAppConfigurationService();
    mockTrackingService = MockTrackingService();

    // Register mocks in GetIt
    sl.registerLazySingleton<ICommerceAPIServiceProvider>(
        () => mockCommerceAPIServiceProvider);
    sl.registerLazySingleton<ICoreServiceProvider>(
        () => mockCoreServiceProvider);
    sl.registerLazySingleton<ITrackingService>(() => mockTrackingService);

    // Mock dependencies
    when(() => mockCommerceAPIServiceProvider.getSessionService())
        .thenReturn(mockSessionService);
    when(() => mockCommerceAPIServiceProvider.getAccountService())
        .thenReturn(mockAccountService);
    when(() => mockCommerceAPIServiceProvider.getCacheService())
        .thenReturn(mockCacheService);
    when(() => mockCoreServiceProvider.getAppConfigurationService())
        .thenReturn(mockAppConfigurationService);

    // Set up tracking service mock
    when(() => mockTrackingService.trackError(any(),
        trace: any(named: 'trace'),
        reason: any(named: 'reason'))).thenAnswer((_) async {});

    // Initialize the use case
    billToShipToUseCase = BillToShipToUseCase();
  });

  tearDown(() async {
    // Reset GetIt after each test
    await sl.reset();
  });

  group('BillToShipToUseCase Tests', () {
    group('getCurrentSession', () {
      test('should return session when API call is successful', () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: true,
          userName: 'testuser',
          billTo: BillTo(isDefault: true),
        );
        final successResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => successResult);

        // Act
        final result = await billToShipToUseCase.getCurrentSession();

        // Assert
        expect(result, isNotNull);
        expect(result?.userName, equals('testuser'));
        expect(result?.isAuthenticated, isTrue);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should return null when API call fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(message: 'Session not found');
        final failureResult = Failure<Session, ErrorResponse>(errorResponse);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => failureResult);

        // Act
        final result = await billToShipToUseCase.getCurrentSession();

        // Assert
        expect(result, isNull);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });
    });

    group('updateCurrentSession', () {
      test('should update session successfully with Ship fulfillment method',
          () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: true,
          userName: 'testuser',
        );
        final billTo = BillTo(isDefault: true);
        final shipTo = ShipTo(isDefault: false);
        final warehouse = Warehouse(name: 'Test Warehouse');

        final getSessionResult = Success<Session, ErrorResponse>(mockSession);
        final patchSessionResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => getSessionResult);
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);
        when(() => mockSessionService.patchCustomerSession(any()))
            .thenAnswer((_) async => patchSessionResult);
        when(() => mockCacheService.invalidateAllObjectsExcept(any()))
            .thenAnswer((_) async {});

        // Act
        final result = await billToShipToUseCase.updateCurrentSession(
          billToAddress: billTo,
          shipToRecipientAddress: shipTo,
          pickUpWarehouse: warehouse,
          selectedShippingMethod: FulfillmentMethodType.Ship,
        );

        // Assert
        expect(result, isNotNull);
        expect(result?.userName, equals('testuser'));
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verify(() => mockAppConfigurationService.hasWillCall()).called(1);
        verify(() => mockSessionService.patchCustomerSession(any())).called(1);
        verify(() => mockCacheService
            .invalidateAllObjectsExcept([CoreConstants.domainKey])).called(1);
      });

      test('should update session successfully with PickUp fulfillment method',
          () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: true,
          userName: 'testuser',
        );
        final billTo = BillTo(isDefault: true);
        final shipTo = ShipTo(isDefault: false);
        final warehouse = Warehouse(name: 'Test Warehouse');

        final getSessionResult = Success<Session, ErrorResponse>(mockSession);
        final patchSessionResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => getSessionResult);
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);
        when(() => mockSessionService.patchCustomerSession(any()))
            .thenAnswer((_) async => patchSessionResult);
        when(() => mockCacheService.invalidateAllObjectsExcept(any()))
            .thenAnswer((_) async {});

        // Act
        final result = await billToShipToUseCase.updateCurrentSession(
          billToAddress: billTo,
          shipToRecipientAddress: shipTo,
          pickUpWarehouse: warehouse,
          selectedShippingMethod: FulfillmentMethodType.PickUp,
        );

        // Assert
        expect(result, isNotNull);
        expect(result?.userName, equals('testuser'));
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verify(() => mockAppConfigurationService.hasWillCall()).called(1);
        verify(() => mockSessionService.patchCustomerSession(any())).called(1);
        verify(() => mockCacheService
            .invalidateAllObjectsExcept([CoreConstants.domainKey])).called(1);
      });

      test('should return null when session is not authenticated', () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: false, // Not authenticated
          userName: 'testuser',
        );
        final getSessionResult = Success<Session, ErrorResponse>(mockSession);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => getSessionResult);

        // Act
        final result = await billToShipToUseCase.updateCurrentSession(
          billToAddress: BillTo(),
          selectedShippingMethod: FulfillmentMethodType.Ship,
        );

        // Assert
        expect(result, isNull);
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verifyNever(() => mockSessionService.patchCustomerSession(any()));
      });

      test('should return null when getCurrentSession fails', () async {
        // Arrange
        final errorResponse = ErrorResponse(message: 'Session error');
        final failureResult = Failure<Session, ErrorResponse>(errorResponse);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => failureResult);

        // Act
        final result = await billToShipToUseCase.updateCurrentSession(
          billToAddress: BillTo(),
          selectedShippingMethod: FulfillmentMethodType.Ship,
        );

        // Assert
        expect(result, isNull);
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verifyNever(() => mockSessionService.patchCustomerSession(any()));
      });

      test('should return null when patchCustomerSession fails', () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: true,
          userName: 'testuser',
        );
        final getSessionResult = Success<Session, ErrorResponse>(mockSession);
        final errorResponse = ErrorResponse(message: 'Patch failed');
        final patchFailureResult =
            Failure<Session, ErrorResponse>(errorResponse);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => getSessionResult);
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);
        when(() => mockSessionService.patchCustomerSession(any()))
            .thenAnswer((_) async => patchFailureResult);

        // Act
        final result = await billToShipToUseCase.updateCurrentSession(
          billToAddress: BillTo(),
          selectedShippingMethod: FulfillmentMethodType.Ship,
        );

        // Assert
        expect(result, isNull);
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verify(() => mockSessionService.patchCustomerSession(any())).called(1);
        verifyNever(() => mockCacheService.invalidateAllObjectsExcept(any()));
      });
    });

    group('updateDefaultCustomerIfNeeded', () {
      test('should update default customer when conditions are met', () async {
        // Arrange
        final mockSession = Session(
          userName: 'testuser',
          shipTo: ShipTo(isDefault: false),
          pickUpWarehouse: Warehouse(name: 'Test Warehouse'),
        );
        final mockAccount = Account(
          userName: 'testuser',
        );

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);
        when(() => mockAccountService.currentAccount).thenReturn(mockAccount);
        when(() => mockAccountService.patchAccountAsync(any()))
            .thenAnswer((_) async => Success(mockAccount));

        // Act
        await billToShipToUseCase.updateDefaultCustomerIfNeeded(
          true, // isDefaultEnable
          false, // isDefaultCustomer
          FulfillmentMethodType.PickUp,
          true, // wasShipToUpdated
        );

        // Assert
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verify(() => mockAppConfigurationService.hasWillCall()).called(1);
        verify(() => mockAccountService.patchAccountAsync(any())).called(1);
      });

      test('should not update when session is null', () async {
        // Arrange
        when(() => mockSessionService.getCurrentSession()).thenAnswer(
            (_) async => Failure(ErrorResponse(message: 'No session')));
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);

        // Act
        await billToShipToUseCase.updateDefaultCustomerIfNeeded(
          true, // isDefaultEnable
          false, // isDefaultCustomer
          FulfillmentMethodType.Ship,
          true, // wasShipToUpdated
        );

        // Assert
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verifyNever(() => mockAccountService.patchAccountAsync(any()));
      });

      test('should not update when account is null', () async {
        // Arrange
        final mockSession = Session(userName: 'testuser');

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);
        when(() => mockAccountService.currentAccount).thenReturn(null);

        // Act
        await billToShipToUseCase.updateDefaultCustomerIfNeeded(
          true, // isDefaultEnable
          false, // isDefaultCustomer
          FulfillmentMethodType.Ship,
          true, // wasShipToUpdated
        );

        // Assert
        verify(() => mockSessionService.getCurrentSession()).called(1);
        verifyNever(() => mockAccountService.patchAccountAsync(any()));
      });
    });

    group('isDefaultCustomerSelected', () {
      test('should return false when session shipTo is null', () async {
        // Arrange
        final mockSession = Session(userName: 'testuser', shipTo: null);

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => Success(mockSession));

        // Act
        final result = await billToShipToUseCase.isDefaultCustomerSelected(
          FulfillmentMethodType.Ship,
          true,
        );

        // Assert
        expect(result, isFalse);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should return false when fulfillment methods do not match',
          () async {
        // Arrange
        final mockSession = Session(
          userName: 'testuser',
          shipTo: ShipTo(isDefault: false),
        );
        final mockAccount = Account(
          defaultFulfillmentMethod: 'Ship',
        );

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockAccountService.currentAccount).thenReturn(mockAccount);

        // Act
        final result = await billToShipToUseCase.isDefaultCustomerSelected(
          FulfillmentMethodType.PickUp, // Different from account's default
          true,
        );

        // Assert
        expect(result, isFalse);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test('should return shipTo isDefault when wasShipToUpdated is true',
          () async {
        // Arrange
        final mockSession = Session(
          userName: 'testuser',
          shipTo: ShipTo(isDefault: true),
        );
        final mockAccount = Account(
          defaultFulfillmentMethod: 'Ship',
        );

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockAccountService.currentAccount).thenReturn(mockAccount);

        // Act
        final result = await billToShipToUseCase.isDefaultCustomerSelected(
          FulfillmentMethodType.Ship,
          true, // wasShipToUpdated
        );

        // Assert
        expect(result, isTrue);
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });

      test(
          'should return opposite of redirectToChangeCustomerPageOnSignIn when wasShipToUpdated is false',
          () async {
        // Arrange
        final mockSession = Session(
          userName: 'testuser',
          shipTo: ShipTo(isDefault: false),
          redirectToChangeCustomerPageOnSignIn: false,
        );
        final mockAccount = Account(
          defaultFulfillmentMethod: 'Ship',
        );

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockAccountService.currentAccount).thenReturn(mockAccount);

        // Act
        final result = await billToShipToUseCase.isDefaultCustomerSelected(
          FulfillmentMethodType.Ship,
          false, // wasShipToUpdated
        );

        // Assert
        expect(result, isTrue); // !false = true
        verify(() => mockSessionService.getCurrentSession()).called(1);
      });
    });

    group('hasWillCall', () {
      test('should return true when app configuration has will call', () async {
        // Arrange
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);

        // Act
        final result = await billToShipToUseCase.hasWillCall();

        // Assert
        expect(result, isTrue);
        verify(() => mockAppConfigurationService.hasWillCall()).called(1);
      });

      test('should return false when app configuration does not have will call',
          () async {
        // Arrange
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => false);

        // Act
        final result = await billToShipToUseCase.hasWillCall();

        // Assert
        expect(result, isFalse);
        verify(() => mockAppConfigurationService.hasWillCall()).called(1);
      });
    });

    group('integration tests', () {
      test('should handle complete flow for Ship fulfillment method', () async {
        // Arrange
        final mockSession = Session(
          isAuthenticated: true,
          userName: 'testuser',
          shipTo: ShipTo(isDefault: false),
        );
        final mockAccount = Account(
          defaultFulfillmentMethod: 'Ship',
        );

        when(() => mockSessionService.getCurrentSession())
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockAppConfigurationService.hasWillCall())
            .thenAnswer((_) async => true);
        when(() => mockAccountService.currentAccount).thenReturn(mockAccount);
        when(() => mockSessionService.patchCustomerSession(any()))
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockCacheService.invalidateAllObjectsExcept(any()))
            .thenAnswer((_) async {});
        when(() => mockAccountService.patchAccountAsync(any()))
            .thenAnswer((_) async => Success(mockAccount));

        // Act
        final currentSession = await billToShipToUseCase.getCurrentSession();
        final hasWillCall = await billToShipToUseCase.hasWillCall();
        final isDefaultSelected =
            await billToShipToUseCase.isDefaultCustomerSelected(
          FulfillmentMethodType.Ship,
          true,
        );
        final updatedSession = await billToShipToUseCase.updateCurrentSession(
          billToAddress: BillTo(),
          shipToRecipientAddress: ShipTo(),
          selectedShippingMethod: FulfillmentMethodType.Ship,
        );

        await billToShipToUseCase.updateDefaultCustomerIfNeeded(
          true,
          false,
          FulfillmentMethodType.Ship,
          true,
        );

        // Assert
        expect(currentSession, isNotNull);
        expect(hasWillCall, isTrue);
        expect(isDefaultSelected, isFalse);
        expect(updatedSession, isNotNull);

        // Verify all service calls
        verify(() => mockSessionService.getCurrentSession()).called(4);
        verify(() => mockAppConfigurationService.hasWillCall()).called(3);
        verify(() => mockSessionService.patchCustomerSession(any())).called(1);
        verify(() => mockAccountService.patchAccountAsync(any())).called(1);
      });
    });
  });
}
