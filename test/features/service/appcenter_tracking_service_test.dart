import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/appcenter_tracking_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockAccountService extends Mock implements IAccountService {}

class MockAnalyticsConfig extends Mock implements AnalyticsConfig {}

class MockSession extends Mock implements Session {}

class MockAccount extends Mock implements Account {}

class MockShipTo extends Mock implements ShipTo {}

class MockBillTo extends Mock implements BillTo {}

void main() {
  late AppCenterTrackingService service;
  late MockSessionService mockSessionService;
  late MockAccountService mockAccountService;
  late MockAnalyticsConfig mockAnalyticsConfig;
  late MockSession mockSession;
  late MockAccount mockAccount;
  late MockShipTo mockShipTo;
  late MockBillTo mockBillTo;

  setUp(() {
    mockSessionService = MockSessionService();
    mockAccountService = MockAccountService();
    mockAnalyticsConfig = MockAnalyticsConfig();
    mockSession = MockSession();
    mockAccount = MockAccount();
    mockShipTo = MockShipTo();
    mockBillTo = MockBillTo();

    service = AppCenterTrackingService(
      sessionService: mockSessionService,
      accountService: mockAccountService,
      analyticsConfig: mockAnalyticsConfig,
    );

    // Set up default mocks
    when(() => mockSession.isAuthenticated).thenReturn(true);
    when(() => mockSession.shipTo).thenReturn(mockShipTo);
    when(() => mockSession.billTo).thenReturn(mockBillTo);
    when(() => mockShipTo.id).thenReturn('ship-to-123');
    when(() => mockBillTo.id).thenReturn('bill-to-456');
    when(() => mockAccount.id).thenReturn('account-789');
  });

  group('isEnabled', () {
    test('returns true when appCenterSecret is not empty', () {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn('secret');
      expect(service.isEnabled, isTrue);
    });

    test('returns false when appCenterSecret is empty', () {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn('');
      expect(service.isEnabled, isFalse);
    });

    test('returns false when appCenterSecret is null', () {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn(null);
      expect(service.isEnabled, isFalse);
    });
  });

  group('setUserId', () {
    test('does nothing when not enabled', () async {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn(null);

      await service.setUserID('test-user');
      // No exception should be thrown
    });

    // Note: We can't easily test the enabled path since AppCenter is a static class
  });

  group('trackEvent', () {
    setUp(() {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn('secret');
    });

    test('does nothing when not enabled', () async {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn(null);

      await service.trackEvent(AnalyticsEvent('test_event', 'event_area'));
      verifyNever(() => mockSessionService.getCachedOrCurrentSession());
    });

    test('adds user and location IDs when session is authenticated', () async {
      final analyticsEvent = AnalyticsEvent('test_event', 'event_area');

      when(() => mockSessionService.getCachedOrCurrentSession())
          .thenAnswer((_) async => Success(mockSession));
      when(() => mockAccountService.getCachedOrCurrentAccountAsync())
          .thenAnswer((_) async => Success(mockAccount));

      await service.trackEvent(analyticsEvent);

      expect(analyticsEvent.properties['user_id'], 'account-789');
      expect(analyticsEvent.properties['bill_to_id'], 'bill-to-456');
      expect(analyticsEvent.properties['ship_to_id'], 'ship-to-123');
    });

    test('does not override existing bill_to_id and ship_to_id properties',
        () async {
      final analyticsEvent = AnalyticsEvent('test_event', 'event_area')
        ..withProperty(name: 'bill_to_id', strValue: 'custom-bill-to')
        ..withProperty(name: 'ship_to_id', strValue: 'custom-ship-to');

      when(() => mockSessionService.getCachedOrCurrentSession())
          .thenAnswer((_) async => Success(mockSession));
      when(() => mockAccountService.getCachedOrCurrentAccountAsync())
          .thenAnswer((_) async => Success(mockAccount));

      await service.trackEvent(analyticsEvent);

      expect(analyticsEvent.properties['user_id'], 'account-789');
      expect(analyticsEvent.properties['bill_to_id'], 'custom-bill-to');
      expect(analyticsEvent.properties['ship_to_id'], 'custom-ship-to');
    });

    test('handles error in account service', () async {
      final analyticsEvent = AnalyticsEvent('test_event', 'event_area');
      final error = ErrorResponse(error: "Account error");

      when(() => mockSessionService.getCachedOrCurrentSession())
          .thenAnswer((_) async => Success(mockSession));
      when(() => mockAccountService.getCachedOrCurrentAccountAsync())
          .thenAnswer((_) async => Failure(error));

      await service.trackEvent(analyticsEvent);

      // Verify that properties were not set
      expect(analyticsEvent.properties.containsKey('user_id'), isFalse);
      expect(analyticsEvent.properties.containsKey('bill_to_id'), isFalse);
      expect(analyticsEvent.properties.containsKey('ship_to_id'), isFalse);
    });
  });

  group('trackError', () {
    setUp(() {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn('secret');
    });

    test('does nothing when not enabled', () async {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn(null);

      await service.trackError(Exception('Test error'));
      // No exception should be thrown
    });

    test('handles ErrorResponse specially', () async {
      final error = ErrorResponse(
          error: "Test error", exception: Exception("Test exception"));

      await service.trackError(error);
      // Can't easily verify the static AppCenterCrashes call
    });

    test('handles general errors', () async {
      final error = Exception("Test exception");

      await service.trackError(error);
      // Can't easily verify the static AppCenterCrashes call
    });
  });

  group('forceCrash', () {
    test('does nothing when not enabled', () async {
      when(() => mockAnalyticsConfig.appCenterSecret).thenReturn(null);

      await service.forceCrash();
      // No exception should be thrown
    });

    // Note: Can't easily test the enabled path since it calls a static method
  });
}
