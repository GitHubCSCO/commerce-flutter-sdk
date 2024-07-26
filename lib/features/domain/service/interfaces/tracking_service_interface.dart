import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';

abstract class ITrackingService {
  Future<void> trackEvent(AnalyticsEvent analyticsEvent);

  Future<void> trackError(dynamic e, {StackTrace? trace, Map<String, String>? reason});

  Future<void> forceCrash();

  Future<void> setUserID(String userId);
}