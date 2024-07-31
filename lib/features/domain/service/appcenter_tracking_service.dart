import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:commerce_flutter_app/core/config/analytics_config.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/tracking_service_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AppCenterTrackingService implements ITrackingService {
  late ISessionService sessionService;
  late IAccountService accountService;
  late AnalyticsConfig analyticsConfig;

  AppCenterTrackingService({
    required this.sessionService,
    required this.accountService,
    required this.analyticsConfig,
  });

  bool get isEnabled => analyticsConfig.appCenterSecret.isNullOrEmpty == false;

  @override
  Future<void> forceCrash() async {
    if (isEnabled) {
      AppCenterCrashes.generateTestCrash();
    }
  }

  @override
  Future<void> setUserID(String userId) async {
    if (isEnabled) {
      AppCenter.setUserId(userId: userId);
    }
  }

  @override
  Future<void> trackEvent(AnalyticsEvent analyticsEvent) async {
    if (isEnabled) {
      var result = await sessionService.getCachedOrCurrentSession();
      var session = result.getResultSuccessValue();
      if (session != null && session.isAuthenticated == true) {
        try {
          var accountResult =
              await accountService.getCachedOrCurrentAccountAsync();
          var account = accountResult.getResultSuccessValue();

          analyticsEvent.withProperty(
              name: 'user_id', strValue: account?.id ?? '');

          if (!analyticsEvent.properties.containsKey('bill_to_id')) {
            analyticsEvent.withProperty(
                name: 'bill_to_id', strValue: session.billTo?.id ?? '');
          }

          if (!analyticsEvent.properties.containsKey('ship_to_id')) {
            analyticsEvent.withProperty(
                name: 'ship_to_id', strValue: session.shipTo?.id ?? '');
          }
        } catch (e) {
          await trackError(e);
        }
      }
      AppCenterAnalytics.trackEvent(
          name: analyticsEvent.eventName,
          properties: analyticsEvent.properties);
    }
  }

  @override
  Future<void> trackError(dynamic e,
      {StackTrace? trace, Map<String, String>? reason}) async {
    if (isEnabled) {
      if (e is ErrorResponse) {
        AppCenterCrashes.trackException(
            message: e.extractErrorMessage() ?? e.exception.toString(),
            stackTrace: trace,
            properties: reason);
      } else {
        AppCenterCrashes.trackException(
            message: e.toString(), stackTrace: trace, properties: reason);
      }
    }
  }
}
