import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/url_string_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/domain_change_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DomainUsecase extends BaseUseCase {
  DomainUsecase() : super();

  Future<String?> getDomainInSettingsScreen() async {
    bool isStaticDomain = coreServiceProvider
            .getAppConfigurationService()
            .baseConfig
            ?.shouldUseStaticDomain ??
        false;
    var devMode = await commerceAPIServiceProvider
        .getLocalStorageService()
        .load(CoreConstants.devMode);

    return isStaticDomain && devMode == null ? null : (await getDomain());
  }

  Future<String?> getDomain() async {
    var domain = await commerceAPIServiceProvider
        .getLocalStorageService()
        .load(CoreConstants.domainKey);

    if (coreServiceProvider
            .getAppConfigurationService()
            .baseConfig
            ?.shouldUseStaticDomain ??
        false) {
      domain = (coreServiceProvider
                      .getAppConfigurationService()
                      .baseConfig
                      ?.domain ??
                  "")
              .isEmpty
          ? domain
          : (domain != null && domain.isNotEmpty
              ? domain
              : coreServiceProvider
                  .getAppConfigurationService()
                  .baseConfig
                  ?.domain);
    }

    if (domain.isNullOrEmpty) {
      await commerceAPIServiceProvider.getSecureStorageService().clearAll();
      return null;
    }

    ClientConfig.hostUrl = domain;
    commerceAPIServiceProvider.getClientService().host = domain;
    commerceAPIServiceProvider.getAdminClientService().host = domain;

    return domain;
  }

  Future<DomainChangeStatus> domainSelectHandler(String domain) async {
    if (domain.trim().isEmpty) {
      return DomainChangeStatus.failedInvalidDomain;
    }
    final validUrlString = domain.makeValidUrl();

    var domainUri = Uri.parse(validUrlString);
    var extractedDomain = domainUri.host;

    // fixes problem when POST request are not redirected automatically when www is omitted
    if (!extractedDomain.startsWith('www.') &&
        extractedDomain.split('.').length < 3) {
      extractedDomain = 'www.$extractedDomain';
    }

    ClientConfig.hostUrl = extractedDomain;
    commerceAPIServiceProvider.getClientService().host = extractedDomain;
    commerceAPIServiceProvider.getAdminClientService().host = extractedDomain;

    final domainSelectionStatus = await _testAndGetSettings();

    if (domainSelectionStatus != DomainChangeStatus.success) {
      return domainSelectionStatus;
    }
    if (commerceAPIServiceProvider.getClientService().host != null) {
      await commerceAPIServiceProvider.getLocalStorageService().save(
          CoreConstants.domainKey,
          commerceAPIServiceProvider.getClientService().host!);
    }
    return DomainChangeStatus.success;
  }

  Future<DomainChangeStatus> _testAndGetSettings() async {
    var isOnline =
        await commerceAPIServiceProvider.getNetworkService().isOnline();

    if (!isOnline) {
      return DomainChangeStatus.failedOffline;
    }

    final futures = [
      commerceAPIServiceProvider.getSettingsService().getProductSettingsAsync(),
      commerceAPIServiceProvider.getSettingsService().getWebsiteSettingsAsync(),
    ];

    final responses = await Future.wait(futures);

    final productSettingsResponse =
        responses[0] as Result<ProductSettings, ErrorResponse>;
    final websiteSettingsResponse =
        responses[1] as Result<WebsiteSettings, ErrorResponse>;

    if (productSettingsResponse is Failure ||
        websiteSettingsResponse is Failure) {
      // fixes problem when domain is not responding when starting with www
      if (commerceAPIServiceProvider.getClientService().host != null &&
          commerceAPIServiceProvider
              .getClientService()
              .host!
              .startsWith('www.')) {
        final prefixRemoveUrl =
            commerceAPIServiceProvider.getClientService().host!.substring(4);
        ClientConfig.hostUrl = prefixRemoveUrl;
        commerceAPIServiceProvider.getClientService().host = prefixRemoveUrl;
        commerceAPIServiceProvider.getAdminClientService().host =
            prefixRemoveUrl;
        return await _testAndGetSettings();
      }

      return DomainChangeStatus.failedInvalidDomain;
    }

    // Check if websiteSettingsResponse is a Success
    final isMobileAppEnabled =
        (websiteSettingsResponse as Success<WebsiteSettings, ErrorResponse>)
                .value
                ?.mobileAppEnabled ??
            false;

    if (!isMobileAppEnabled) {
      return DomainChangeStatus.failedMobileAppDisabled;
    }

    return DomainChangeStatus.success;
  }

  Future<void> loadRemoteSettings() async {
    await coreServiceProvider.getAppConfigurationService().loadRemoteSettings();
  }

  Future<void> clearCache() async {
    await commerceAPIServiceProvider
        .getCacheService()
        .invalidateAllObjectsExcept([CoreConstants.domainKey]);
  }
}
