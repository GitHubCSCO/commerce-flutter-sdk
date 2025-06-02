import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IWebsiteService {
  Future<Result<Website, ErrorResponse>> getWebsite(
      {WebsiteQueryParameters? parameters});

  Future<Result<AddressFieldCollection, ErrorResponse>> getAddressFields();

  Future<Result<CountryCollection, ErrorResponse>> getCountries(
      {CountriesQueryParameters? parameters});

  Future<Result<Country, ErrorResponse>> getCountry(String countryId);

  Future<Result<WebsiteCrosssells, ErrorResponse>> getCrosssells();

  Future<Result<CurrencyCollection, ErrorResponse>> getCurrencies();

  Future<Result<Currency, ErrorResponse>> getCurrency(String currencyId);

  Future<Result<LanguageCollection, ErrorResponse>> getLanguages();

  Future<Result<Language, ErrorResponse>> getLanguage(String languageId);

  Future<Result<GetSiteMessageCollectionResult, ErrorResponse>> getSiteMessages(
      {List<String>? names});

  Future<Result<StateCollection, ErrorResponse>> getStates();

  Future<Result<StateModel, ErrorResponse>> getState(String stateId);

  /// get full URL for path with domain, access token and customer ids
  Future<String?> getAuthorizedURL(String path);

  Future<bool> hasWebsiteCache();

  Future<bool> hasWebsiteCrosssellsCache();

  Future<String?> getSiteMessage(String messageName, {String? defaultMessage});
}
