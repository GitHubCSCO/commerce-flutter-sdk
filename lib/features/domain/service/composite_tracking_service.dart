import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/service/interfaces/tracking_service_interface.dart';

class CompositeTrackingService implements ITrackingService {
  final List<ITrackingService> trackers;

  CompositeTrackingService({
    required this.trackers,
  });

  @override
  Future<void> forceCrash() async {
    for (var tracker in trackers) {
      await tracker.forceCrash();
    }
  }

  @override
  Future<void> setUserID(String userId) async {
    for (var tracker in trackers) {
      await tracker.setUserID(userId);
    }
  }

  @override
  Future<void> trackError(e,
      {StackTrace? trace, Map<String, String>? reason}) async {
    for (var tracker in trackers) {
      await tracker.trackError(e, trace: trace, reason: reason);
    }
  }

  @override
  Future<void> trackEvent(AnalyticsEvent analyticsEvent) async {
    for (var tracker in trackers) {
      await tracker.trackEvent(analyticsEvent);
    }
  }
}
