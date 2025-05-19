import 'package:collection/collection.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WebsiteService extends ServiceBase implements IWebsiteService {
  WebsiteService({
    required super.clientService,
    required this.sessionService,
    required super.cacheService,
    required super.networkService,
  });

  ISessionService sessionService;

  @override
  Future<Result<AddressFieldCollection, ErrorResponse>>
      getAddressFields() async {
    return await getAsyncNoCache<AddressFieldCollection>(
      CommerceAPIConstants.websitesAddressFieldsUrl,
      AddressFieldCollection.fromJson,
    );
  }

  Future<String> _getAuthorizedURL(String urlPath) async {
    // sign
    String? token = await clientService.getAccessToken();
    String? billTo = sessionService.getCachedCurrentSession()?.billTo?.id;
    String? shipTo = sessionService.getCachedCurrentSession()?.shipTo?.id;
    String? languageCode =
        sessionService.getCachedCurrentSession()?.language?.languageCode;
    String? currencyCode =
        sessionService.getCachedCurrentSession()?.currency?.currencyCode;
    String linkChar = urlPath.contains('?') ? '&' : '?';

    if (token.isNullOrEmpty || billTo.isNullOrEmpty || shipTo.isNullOrEmpty) {
      urlPath += '$linkChar'
          'SetContextLanguageCode=$languageCode'
          '&SetContextCurrencyCode=$currencyCode';
    } else {
      urlPath += '$linkChar'
          '&CurrentBillToId=$billTo'
          '&CurrentShipToId=$shipTo'
          '&SetContextLanguageCode=$languageCode'
          '&SetContextCurrencyCode=$currencyCode';
    }

    return urlPath;
  }

  @override
  Future<String?> getAuthorizedURL(String path) async {
    try {
      final split = path.split('?');
      final pathWithoutQuery = split.first;
      final query = split.length > 1 ? split.last : '';

      Uri? uri;
      if (pathWithoutQuery.contains('.') && !pathWithoutQuery.contains('://')) {
        uri = Uri.tryParse('https://$pathWithoutQuery');
      } else {
        uri = Uri.tryParse(pathWithoutQuery);
      }

      bool isFullPath = uri != null && (uri.isAbsolute || uri.host.isNotEmpty);
      Uri domain = clientService.url ?? Uri();

      if (path.contains(domain.host)) {
        return _getAuthorizedURL(Uri.parse(path).toString());
      }

      if (isFullPath) {
        return uri.toString();
      } else {
        if (domain.path.isEmpty || path.isEmpty) {
          return null;
        }

        String result = Uri(
          scheme: domain.scheme,
          host: domain.host,
          port: domain.port,
          path: pathWithoutQuery,
          query: query,
        ).toString();

        return _getAuthorizedURL(result);
      }
    } catch (e) {
      // loggerService.logConsole(
      //   LogLevel.INFO,
      //   "Can not create uri with path $path exception: ${e.toString()}",
      // );

      /// TODO - use logger service
      // print('Can not create uri with path $path exception: ${e}');
      return null;
    }
  }

  @override
  Future<Result<CountryCollection, ErrorResponse>> getCountries({
    CountriesQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.websitesCountriesUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache<CountryCollection>(
      url.toString(),
      CountryCollection.fromJson,
    );
  }

  @override
  Future<Result<Country, ErrorResponse>> getCountry(String countryId) async {
    return await getAsyncNoCache<Country>(
      '${CommerceAPIConstants.websitesCountriesUrl}/$countryId',
      Country.fromJson,
    );
  }

  @override
  Future<Result<WebsiteCrosssells, ErrorResponse>> getCrosssells() async {
    return await getAsyncNoCache<WebsiteCrosssells>(
      CommerceAPIConstants.websitesCrossSellsUrl,
      WebsiteCrosssells.fromJson,
    );
  }

  @override
  Future<Result<CurrencyCollection, ErrorResponse>> getCurrencies() async {
    return await getAsyncNoCache<CurrencyCollection>(
      CommerceAPIConstants.websitesCurrenciesUrl,
      CurrencyCollection.fromJson,
    );
  }

  @override
  Future<Result<Currency, ErrorResponse>> getCurrency(String currencyId) async {
    return getAsyncNoCache<Currency>(
      '${CommerceAPIConstants.websitesCurrenciesUrl}/$currencyId',
      Currency.fromJson,
    );
  }

  @override
  Future<Result<Language, ErrorResponse>> getLanguage(String languageId) async {
    return await getAsyncNoCache<Language>(
      '${CommerceAPIConstants.websitesLanguagesUrl}/$languageId',
      Language.fromJson,
    );
  }

  @override
  Future<Result<LanguageCollection, ErrorResponse>> getLanguages() async {
    return await getAsyncNoCache<LanguageCollection>(
      CommerceAPIConstants.websitesLanguagesUrl,
      LanguageCollection.fromJson,
    );
  }

  @override
  Future<String?> getSiteMessage(String messageName,
      {String? defaultMessage}) async {
    var response = await getSiteMessages(names: [messageName]);

    switch (response) {
      case Success(value: final value):
        {
          GetSiteMessageCollectionResult? messageResult = value;
          SiteMessage? siteMessageItem =
              messageResult?.siteMessages?.firstWhereOrNull(
            (x) =>
                x.message != null &&
                (x.languageCode != null &&
                    x.languageCode!.equalsIgnoreCase(sessionService
                        .getCachedCurrentSession()
                        ?.language
                        ?.languageCode)),
          );

          if (siteMessageItem != null) {
            return siteMessageItem.message?.isNullOrEmpty == true
                ? defaultMessage ?? ''
                : siteMessageItem.message?.stripHtml();
          } else {
            siteMessageItem = messageResult?.siteMessages?.firstWhereOrNull(
              (x) => x.languageCode.isNullOrEmpty && x.message != null,
            );

            if (siteMessageItem != null) {
              return siteMessageItem.message?.isNullOrEmpty == true
                  ? defaultMessage ?? ''
                  : siteMessageItem.message?.stripHtml();
            }
          }

          return defaultMessage ?? '';
        }

      case Failure():
        {
          return defaultMessage ?? '';
        }
    }
  }

  @override
  Future<Result<GetSiteMessageCollectionResult, ErrorResponse>>
      getSiteMessages({
    List<String>? names,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.websitesSiteMessagesUrl);
    if (names != null) {
      url = url.replace(queryParameters: {'parameter.name': names.join(',')});
    }

    return await getAsyncNoCache<GetSiteMessageCollectionResult>(
      url.toString(),
      GetSiteMessageCollectionResult.fromJson,
    );
  }

  @override
  Future<Result<StateModel, ErrorResponse>> getState(String stateId) async {
    return await getAsyncNoCache<StateModel>(
      '${CommerceAPIConstants.websitesStatesUrl}/$stateId',
      StateModel.fromJson,
    );
  }

  @override
  Future<Result<StateCollection, ErrorResponse>> getStates() async {
    return getAsyncNoCache<StateCollection>(
      CommerceAPIConstants.websitesStatesUrl,
      StateCollection.fromJson,
    );
  }

  @override
  Future<Result<Website, ErrorResponse>> getWebsite({
    WebsiteQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.websitesUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache<Website>(
      url.toString(),
      Website.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );
  }

  @Deprecated('Caution: Will be removed in a future release.')
  @override
  Future<bool> hasWebsiteCache() async {
    final sessionStateKey = await clientService.sessionStateKey;
    final key = (clientService.host ?? '') +
        CommerceAPIConstants.websitesUrl +
        (sessionStateKey ?? '');

    return await cacheService.hasOnlineCache(key);
  }

  @Deprecated('Caution: Will be removed in a future release.')
  @override
  Future<bool> hasWebsiteCrosssellsCache() async {
    final sessionStateKey = await clientService.sessionStateKey;
    final key = (clientService.host ?? '') +
        CommerceAPIConstants.websitesCrossSellsUrl +
        (sessionStateKey ?? '');

    return await cacheService.hasOnlineCache(key);
  }
}
