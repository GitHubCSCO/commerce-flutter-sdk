import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/url_string_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DomainSelectionUsecase {
  final ISettingsService _settingsService = sl<ISettingsService>();
  final IClientService _clientService = sl<IClientService>();
  final IAdminClientService _adminClientService = sl<IAdminClientService>();
  final INetworkService _networkService = sl<INetworkService>();
  final ILocalStorageService _localStorageService = sl<ILocalStorageService>();

  static const _wasAdminLoginAdvertisedPreferenceKey =
      "wasAdminLoginAdvertisedPreferenceKey";
  static const _domainKey = 'DomainKey';

  Future<Result<bool, ErrorResponse>> domainSelectHandler(String domain) async {
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

    if (!await _testAndGetSettings()) {
      return Failure(
        ErrorResponse(
          message: LocalizationKeyword.domainWebsiteNotResponding,
        ),
      );
    }

    _localStorageService.save(_domainKey, _clientService.host!);
    return const Success(true);
  }

  Future<bool> _testAndGetSettings() async {
    var isOnline = await _networkService.isOnline();

    if (!isOnline) {
      return false;
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
      } else {
        return false;
      }
    }

    // Check if websiteSettingsResponse is a Success
    final isMobileAppEnabled =
        (websiteSettingsResponse as Success<WebsiteSettings, ErrorResponse>)
                .value
                ?.mobileAppEnabled ??
            false;

    if (!isMobileAppEnabled) {
      return false;
    }

    return true;
  }
}
