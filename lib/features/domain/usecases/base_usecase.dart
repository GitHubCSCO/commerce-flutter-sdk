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

  Future<void> trackEvent(AnalyticsEvent analyticsEvent) async {
    await coreServiceProvider.getTrackingService().trackEvent(analyticsEvent);
  }

  Future<void> trackError(dynamic e,
      {StackTrace? trace, Map<String, String>? reason}) async {
    await coreServiceProvider
        .getTrackingService()
        .trackError(e, trace: trace, reason: reason);
  }

  Future<void> forceCrash() async {
    await coreServiceProvider.getTrackingService().forceCrash();
  }

  Future<void> setUserID(String userId) async {
    await coreServiceProvider.getTrackingService().setUserID(userId);
  }

  Future<String> getSiteMessage(
      String messageName, String? defaultMessage) async {
    var result = await commerceAPIServiceProvider
        .getWebsiteService()
        .getSiteMessage(messageName, defaultMessage: defaultMessage);
    return result ?? defaultMessage ?? '';
  }

}
