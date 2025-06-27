import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/composite_tracking_service.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/tracking_service_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockTrackingService extends Mock implements ITrackingService {}

class MockAnalyticsEvent extends Mock implements AnalyticsEvent {}

class FakeAnalyticsEvent extends Fake implements AnalyticsEvent {}

void main() {
  setUpAll(() {
    // Register fallback value for AnalyticsEvent to use with any() matcher
    registerFallbackValue(FakeAnalyticsEvent());
  });

  late CompositeTrackingService compositeTrackingService;
  late MockTrackingService tracker1;
  late MockTrackingService tracker2;
  late MockAnalyticsEvent mockEvent;

  setUp(() {
    tracker1 = MockTrackingService();
    tracker2 = MockTrackingService();
    compositeTrackingService = CompositeTrackingService(
      trackers: [tracker1, tracker2],
    );
    mockEvent = MockAnalyticsEvent();
  });

  group('CompositeTrackingService', () {
    test('forceCrash should call forceCrash on all trackers', () async {
      // Arrange
      when(() => tracker1.forceCrash()).thenAnswer((_) async {});
      when(() => tracker2.forceCrash()).thenAnswer((_) async {});

      // Act
      await compositeTrackingService.forceCrash();

      // Assert
      verify(() => tracker1.forceCrash()).called(1);
      verify(() => tracker2.forceCrash()).called(1);
    });

    test('setUserID should call setUserID on all trackers', () async {
      // Arrange
      const userId = 'test-user-123';
      when(() => tracker1.setUserID(any())).thenAnswer((_) async {});
      when(() => tracker2.setUserID(any())).thenAnswer((_) async {});

      // Act
      await compositeTrackingService.setUserID(userId);

      // Assert
      verify(() => tracker1.setUserID(userId)).called(1);
      verify(() => tracker2.setUserID(userId)).called(1);
    });

    test('trackError should call trackError on all trackers', () async {
      // Arrange
      final exception = Exception('Test error');
      final stackTrace = StackTrace.current;
      final reason = {'key': 'value'};

      when(() => tracker1.trackError(
            any(),
            trace: any(named: 'trace'),
            reason: any(named: 'reason'),
          )).thenAnswer((_) async {});

      when(() => tracker2.trackError(
            any(),
            trace: any(named: 'trace'),
            reason: any(named: 'reason'),
          )).thenAnswer((_) async {});

      // Act
      await compositeTrackingService.trackError(
        exception,
        trace: stackTrace,
        reason: reason,
      );

      // Assert
      verify(() => tracker1.trackError(
            exception,
            trace: stackTrace,
            reason: reason,
          )).called(1);

      verify(() => tracker2.trackError(
            exception,
            trace: stackTrace,
            reason: reason,
          )).called(1);
    });

    test('trackEvent should call trackEvent on all trackers', () async {
      // Arrange
      when(() => tracker1.trackEvent(any())).thenAnswer((_) async {});
      when(() => tracker2.trackEvent(any())).thenAnswer((_) async {});

      // Act
      await compositeTrackingService.trackEvent(mockEvent);

      // Assert
      verify(() => tracker1.trackEvent(mockEvent)).called(1);
      verify(() => tracker2.trackEvent(mockEvent)).called(1);
    });

    test('should work with empty trackers list', () {
      // Arrange
      final emptyService = CompositeTrackingService(trackers: []);

      // Act & Assert - should not throw
      expect(() async => await emptyService.trackEvent(mockEvent),
          returnsNormally);
      expect(
          () async => await emptyService.trackError('error'), returnsNormally);
      expect(() async => await emptyService.setUserID('user'), returnsNormally);
      expect(() async => await emptyService.forceCrash(), returnsNormally);
    });
  });
}
