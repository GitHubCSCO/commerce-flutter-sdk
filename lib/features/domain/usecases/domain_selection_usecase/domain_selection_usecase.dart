import 'package:commerce_flutter_app/core/extensions/url_string_extension.dart';
import 'package:commerce_flutter_app/core/utils/url_validator.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_selection_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DomainSelectionUsecase extends BaseUseCase {
  DomainSelectionUsecase() : super();

  static const _domainKey = 'DomainKey';

  Future<String?> getSavedDomain() async {
    final result = await commerceAPIServiceProvider
        .getLocalStorageService()
        .load(_domainKey);
    if (result != null) {
      ClientConfig.hostUrl = result;
      commerceAPIServiceProvider.getClientService().host = result;
      commerceAPIServiceProvider.getAdminClientService().host = result;
    }

    return result;
  }

  Future<DomainSelectionStatus> domainSelectHandler(String domain) async {
    if (domain.trim().isEmpty) {
      return DomainSelectionStatus.failedInvalidDomain;
    }
    if (!UrlValidator.isValidUrl(domain)) {
      return DomainSelectionStatus.failedInvalidDomain;
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

    if (domainSelectionStatus != DomainSelectionStatus.success) {
      return domainSelectionStatus;
    }
    if (commerceAPIServiceProvider.getClientService().host != null) {
      commerceAPIServiceProvider.getLocalStorageService().save(
          _domainKey, commerceAPIServiceProvider.getClientService().host!);
    }
    return DomainSelectionStatus.success;
  }

  Future<DomainSelectionStatus> _testAndGetSettings() async {
    var isOnline =
        await commerceAPIServiceProvider.getNetworkService().isOnline();

    if (!isOnline) {
      return DomainSelectionStatus.failedOffline;
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

      return DomainSelectionStatus.failedInvalidDomain;
    }

    // Check if websiteSettingsResponse is a Success
    final isMobileAppEnabled =
        (websiteSettingsResponse as Success<WebsiteSettings, ErrorResponse>)
                .value
                ?.mobileAppEnabled ??
            false;

    if (!isMobileAppEnabled) {
      return DomainSelectionStatus.failedMobileAppDisabled;
    }

    return DomainSelectionStatus.success;
  }
}
