import 'package:commerce_flutter_sdk/src/core/config/analytics_config.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/firebase_options_extension.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/tracking_service_interface.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FirebaseTrackingService implements ITrackingService {
  late ISessionService sessionService;
  late IAccountService accountService;
  late AnalyticsConfig analyticsConfig;

  late FirebaseAnalytics analytics;
  late FirebaseCrashlytics crashlytics;

  FirebaseTrackingService({
    required this.sessionService,
    required this.accountService,
    required this.analyticsConfig,
  }) {
    if (analyticsConfig.firebaseOptions?.isValid() == true) {
      analytics = FirebaseAnalytics.instance;
      crashlytics = FirebaseCrashlytics.instance;
    }
  }

  bool get isEnabled => analyticsConfig.firebaseOptions?.isValid() == true;

  @override
  Future<void> forceCrash() async {
    if (isEnabled) {
      crashlytics.crash();
    }
  }

  @override
  Future<void> setUserID(String userId) async {
    if (isEnabled) {
      analytics.setUserId(id: userId).ignore();
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

      analytics
          .logEvent(
              name: analyticsEvent.eventName,
              parameters: analyticsEvent.properties)
          .ignore();
    }
  }

  @override
  Future<void> trackError(dynamic e,
      {StackTrace? trace, Map<String, String>? reason}) async {
    if (isEnabled) {
      if (e is ErrorResponse) {
        await crashlytics.recordError(e.exception, trace,
            reason: e.extractErrorMessage());
      } else {
        await crashlytics.recordError(e, trace, reason: reason);
      }
    }
  }
}
