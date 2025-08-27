import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/telemetry_event_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BaseUseCase {
  final ICommerceAPIServiceProvider commerceAPIServiceProvider;
  final ICoreServiceProvider coreServiceProvider;

  BaseUseCase()
      : commerceAPIServiceProvider = sl<ICommerceAPIServiceProvider>(),
        coreServiceProvider = sl<ICoreServiceProvider>();

  void trackTelemetryEvent(
    TelemetryEvent telemetryEvent,
  ) async {
    await _enrichTelemetryEventWithDeviceProperties(telemetryEvent);

    if (telemetryEvent.screenName != null) {
      var screenViewEvent = TelemetryEventMapper.toScreenView(telemetryEvent);
      coreServiceProvider
          .getTelemetryService()
          .screenView(screenViewEvent)
          .ignore();
    } else {
      var userEvent = TelemetryEventMapper.toUserEvent(telemetryEvent);
      coreServiceProvider.getTelemetryService().trackEvent(userEvent).ignore();
    }
  }

  Future<void> _enrichTelemetryEventWithDeviceProperties(
    TelemetryEvent telemetryEvent,
  ) async {
    final deviceProperties = await coreServiceProvider
        .getDeviceService()
        .getDeviceEnvironmentProperties();
    for (final entry in deviceProperties.entries) {
      telemetryEvent.properties[entry.key] = entry.value;
    }
  }

  void trackEvent(AnalyticsEvent analyticsEvent) async {
    coreServiceProvider
        .getTrackingService()
        .trackEvent(analyticsEvent)
        .ignore();
  }

  void trackError(dynamic e,
      {StackTrace? trace, Map<String, String>? reason}) async {
    coreServiceProvider
        .getTrackingService()
        .trackError(e, trace: trace, reason: reason)
        .ignore();
  }

  void forceCrash() async {
    coreServiceProvider.getTrackingService().forceCrash().ignore();
  }

  void setUserID(String userId) async {
    coreServiceProvider.getTrackingService().setUserID(userId).ignore();
  }

  Future<String> getSiteMessage(
      String messageName, String? defaultMessage) async {
    var result = await commerceAPIServiceProvider
        .getWebsiteService()
        .getSiteMessage(messageName, defaultMessage: defaultMessage);
    return result ?? defaultMessage ?? '';
  }

  Future<bool> checkSignInRequired() async {
    final productSettings = await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();

    switch (productSettings) {
      case Failure():
        return false;
      case Success(value: final productSettings):
        return productSettings?.storefrontAccess ==
            StorefrontAccessConstants.signInRequiredToBrowse;
    }
  }

  Future<bool> isOnline() async {
    return commerceAPIServiceProvider.getNetworkService().isOnline();
  }

  String? get privacyPolicyUrl =>
      coreServiceProvider.getAppConfigurationService().privacyPolicyUrl;

  String? get termsOfUseUrl =>
      coreServiceProvider.getAppConfigurationService().termsOfUseUrl;
}
