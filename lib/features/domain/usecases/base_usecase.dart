import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BaseUseCase {
  final ICommerceAPIServiceProvider commerceAPIServiceProvider;
  final ICoreServiceProvider coreServiceProvider;

  BaseUseCase()
      : commerceAPIServiceProvider = sl<ICommerceAPIServiceProvider>(),
        coreServiceProvider = sl<ICoreServiceProvider>();

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

  String? get privacyPolicyUrl =>
      coreServiceProvider.getAppConfigurationService().privacyPolicyUrl;

  String? get termsOfUseUrl =>
      coreServiceProvider.getAppConfigurationService().termsOfUseUrl;
}
