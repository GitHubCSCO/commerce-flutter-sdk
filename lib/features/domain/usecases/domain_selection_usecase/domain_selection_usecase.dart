import 'package:commerce_flutter_app/core/extensions/url_string_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_selection_status.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DomainSelectionUsecase {
  final ISettingsService _settingsService = sl<ISettingsService>();
  final IClientService _clientService = sl<IClientService>();
  final IAdminClientService _adminClientService = sl<IAdminClientService>();
  final INetworkService _networkService = sl<INetworkService>();
  final ILocalStorageService _localStorageService = sl<ILocalStorageService>();

  static const _domainKey = 'DomainKey';

  Future<DomainSelectionStatus> domainSelectHandler(String domain) async {
    final validUrlString = domain.makeValidUrl();

    var domainUri = Uri.parse(validUrlString);
    var extractedDomain = domainUri.host;

    // fixes problem when POST request are not redirected automatically when www is omitted
    if (!extractedDomain.startsWith('www.') &&
        extractedDomain.split('.').length < 3) {
      extractedDomain = 'www.$extractedDomain';
    }

    ClientConfig.hostUrl = extractedDomain;
    _clientService.host = extractedDomain;
    _adminClientService.host = extractedDomain;

    final domainSelectionStatus = await _testAndGetSettings();

    if (domainSelectionStatus != DomainSelectionStatus.success) {
      return domainSelectionStatus;
    }

    _localStorageService.save(_domainKey, _clientService.host!);
    return DomainSelectionStatus.success;
  }

  Future<DomainSelectionStatus> _testAndGetSettings() async {
    var isOnline = await _networkService.isOnline();

    if (!isOnline) {
      return DomainSelectionStatus.failedOffline;
    }

    final futures = [
      _settingsService.getProductSettingsAsync(),
      _settingsService.getWebsiteSettingsAsync(),
    ];

    final responses = await Future.wait(futures);

    final productSettingsResponse =
        responses[0] as Result<ProductSettings, ErrorResponse>;
    final websiteSettingsResponse =
        responses[1] as Result<WebsiteSettings, ErrorResponse>;

    if (productSettingsResponse is Failure ||
        websiteSettingsResponse is Failure) {
      // fixes problem when domain is not responding when starting with www
      if (_clientService.host != null &&
          _clientService.host!.startsWith('www.')) {
        final prefixRemoveUrl = _clientService.host!.substring(4);
        ClientConfig.hostUrl = prefixRemoveUrl;
        _clientService.host = prefixRemoveUrl;
        _adminClientService.host = prefixRemoveUrl;
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
