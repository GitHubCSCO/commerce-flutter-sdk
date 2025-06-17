import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/firebase_tracking_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

// Mock dependencies
class MockSessionService extends Mock implements ISessionService {}

class MockAccountService extends Mock implements IAccountService {}

class MockAnalyticsConfig extends Mock implements AnalyticsConfig {}

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {}

class MockFirebaseOptions extends Mock implements FirebaseOptions {}

class MockSession extends Mock implements Session {}

class MockAccount extends Mock implements Account {}

class MockBillTo extends Mock implements BillTo {}

class MockShipTo extends Mock implements ShipTo {}

// Create a custom FirebaseOptionsWrapper to avoid extension method issues
class FirebaseOptionsWrapper {
  final FirebaseOptions options;
  final bool isValidValue;

  FirebaseOptionsWrapper(this.options, {this.isValidValue = true});

  bool isValid() => isValidValue;
}

// Create a testable version of FirebaseTrackingService
class TestableFirebaseTrackingService extends FirebaseTrackingService {
  TestableFirebaseTrackingService({
    required ISessionService sessionService,
    required IAccountService accountService,
    required AnalyticsConfig analyticsConfig,
  }) : super(
          sessionService: sessionService,
          accountService: accountService,
          analyticsConfig: analyticsConfig,
        );

  @override
  bool get isEnabled => _isEnabled;
  bool _isEnabled = true;

  void setEnabled(bool value) {
    _isEnabled = value;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TestableFirebaseTrackingService service;
  late MockSessionService mockSessionService;
  late MockAccountService mockAccountService;
  late MockAnalyticsConfig mockAnalyticsConfig;
  late MockFirebaseAnalytics mockAnalytics;
  late MockFirebaseCrashlytics mockCrashlytics;
  late MockFirebaseOptions mockFirebaseOptions;

  setUp(() {
    mockSessionService = MockSessionService();
    mockAccountService = MockAccountService();
    mockAnalyticsConfig = MockAnalyticsConfig();
    mockAnalytics = MockFirebaseAnalytics();
    mockCrashlytics = MockFirebaseCrashlytics();
    mockFirebaseOptions = MockFirebaseOptions();

    // Use our testable version
    service = TestableFirebaseTrackingService(
        sessionService: mockSessionService,
        accountService: mockAccountService,
        analyticsConfig: mockAnalyticsConfig);

    // Replace Firebase instances with mocks
    service.analytics = mockAnalytics;
    service.crashlytics = mockCrashlytics;
  });

  group('FirebaseTrackingService', () {
    test('isEnabled returns true by default', () {
      // Assert
      expect(service.isEnabled, isTrue);
    });

    test('isEnabled returns false when set to false', () {
      // Arrange
      service.setEnabled(false);

      // Assert
      expect(service.isEnabled, isFalse);
    });

    test('forceCrash calls crashlytics.crash when enabled', () async {
      // Arrange
      when(() => mockCrashlytics.crash()).thenAnswer((_) async {});

      // Act
      await service.forceCrash();

      // Assert
      verify(() => mockCrashlytics.crash()).called(1);
    });

    test('forceCrash does nothing when disabled', () async {
      // Arrange
      service.setEnabled(false);
      when(() => mockCrashlytics.crash()).thenAnswer((_) async {});

      // Act
      await service.forceCrash();

      // Assert
      verifyNever(() => mockCrashlytics.crash());
    });

    test('setUserID calls analytics.setUserId when enabled', () async {
      // Arrange
      when(() => mockAnalytics.setUserId(id: any(named: 'id')))
          .thenAnswer((_) async {});

      // Act
      await service.setUserID('user123');

      // Assert
      verify(() => mockAnalytics.setUserId(id: 'user123')).called(1);
    });

    test('setUserID does nothing when disabled', () async {
      // Arrange
      service.setEnabled(false);
      when(() => mockAnalytics.setUserId(id: any(named: 'id')))
          .thenAnswer((_) async {});

      // Act
      await service.setUserID('user123');

      // Assert
      verifyNever(() => mockAnalytics.setUserId(id: any(named: 'id')));
    });

    group('trackEvent', () {
      late MockSession mockSession;
      late MockAccount mockAccount;
      late MockBillTo mockBillTo;
      late MockShipTo mockShipTo;
      late AnalyticsEvent testEvent;

      setUp(() {
        mockSession = MockSession();
        mockAccount = MockAccount();
        mockBillTo = MockBillTo();
        mockShipTo = MockShipTo();
        testEvent = AnalyticsEvent('test_event', 'event_area');

        // Setup session data
        when(() => mockSession.isAuthenticated).thenReturn(true);
        when(() => mockSession.billTo).thenReturn(mockBillTo);
        when(() => mockSession.shipTo).thenReturn(mockShipTo);
        when(() => mockBillTo.id).thenReturn('bill123');
        when(() => mockShipTo.id).thenReturn('ship456');
        when(() => mockAccount.id).thenReturn('acc789');

        // Setup service responses
        when(() => mockSessionService.getCachedOrCurrentSession())
            .thenAnswer((_) async => Success(mockSession));
        when(() => mockAccountService.getCachedOrCurrentAccountAsync())
            .thenAnswer((_) async => Success(mockAccount));

        // Setup analytics mock
        when(() => mockAnalytics.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            )).thenAnswer((_) async {});
      });

      test('trackEvent adds user data when session is authenticated', () async {
        // Act
        await service.trackEvent(testEvent);

        // Assert
        verify(() => mockAnalytics.logEvent(
              name: 'test_event',
              parameters: {
                'screen_name': 'event_area',
                'user_id': 'acc789',
                'bill_to_id': 'bill123',
                'ship_to_id': 'ship456',
              },
            )).called(1);
      });

      test('trackEvent does not override custom bill_to_id and ship_to_id',
          () async {
        // Arrange
        testEvent.withProperty(name: 'bill_to_id', strValue: 'custom_bill');
        testEvent.withProperty(name: 'ship_to_id', strValue: 'custom_ship');

        // Act
        await service.trackEvent(testEvent);

        // Assert
        verify(() => mockAnalytics.logEvent(
              name: 'test_event',
              parameters: {
                'screen_name': 'event_area',
                'user_id': 'acc789',
                'bill_to_id': 'custom_bill',
                'ship_to_id': 'custom_ship',
              },
            )).called(1);
      });

      test('trackEvent handles exception when getting account', () async {
        // Arrange
        when(() => mockAccountService.getCachedOrCurrentAccountAsync())
            .thenThrow(Exception('Test error'));
        when(() => mockCrashlytics.recordError(any(), any(),
            reason: any(named: 'reason'))).thenAnswer((_) async {});

        // Act
        await service.trackEvent(testEvent);

        // Assert
        verify(() => mockCrashlytics.recordError(any(), any(),
            reason: any(named: 'reason'))).called(1);
        verify(() => mockAnalytics.logEvent(
              name: 'test_event',
              parameters: any(named: 'parameters'),
            )).called(1);
      });

      test(
          'trackEvent does not add user data when session is not authenticated',
          () async {
        // Arrange
        when(() => mockSession.isAuthenticated).thenReturn(false);

        // Act
        await service.trackEvent(testEvent);

        // Assert
        verify(() => mockAnalytics.logEvent(
              name: 'test_event',
              parameters: {
                'screen_name': 'event_area',
              },
            )).called(1);
      });

      test('trackEvent does nothing when disabled', () async {
        // Arrange
        service.setEnabled(false);

        // Act
        await service.trackEvent(testEvent);

        // Assert
        verifyNever(() => mockAnalytics.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ));
      });
    });

    group('trackError', () {
      test('trackError records ErrorResponse with message', () async {
        // Arrange
        final errorResponse = ErrorResponse(
            message: 'Test error', exception: Exception('Test exception'));

        when(() => mockCrashlytics.recordError(any(), any(),
            reason: any(named: 'reason'))).thenAnswer((_) async {});

        // Act
        await service.trackError(errorResponse);

        // Assert
        verify(() => mockCrashlytics.recordError(
              errorResponse.exception,
              null,
              reason: errorResponse.extractErrorMessage(),
            )).called(1);
      });

      test('trackError records general exception', () async {
        // Arrange
        final exception = Exception('Test exception');
        final trace = StackTrace.current;
        final reason = {'error_type': 'test_error'};

        when(() => mockCrashlytics.recordError(any(), any(),
            reason: any(named: 'reason'))).thenAnswer((_) async {});

        // Act
        await service.trackError(exception, trace: trace, reason: reason);

        // Assert
        verify(() => mockCrashlytics.recordError(
              exception,
              trace,
              reason: reason,
            )).called(1);
      });

      test('trackError does nothing when disabled', () async {
        // Arrange
        service.setEnabled(false);
        final exception = Exception('Test exception');

        when(() => mockCrashlytics.recordError(any(), any(),
            reason: any(named: 'reason'))).thenAnswer((_) async {});

        // Act
        await service.trackError(exception);

        // Assert
        verifyNever(() => mockCrashlytics.recordError(
              any(),
              any(),
              reason: any(named: 'reason'),
            ));
      });
    });
  });
}
