import 'models.dart';

part 'website.g.dart';

@JsonSerializable()
class Website extends BaseModel {
  /// Gets or sets the countries URI.
  String? countriesUri;

  /// Gets or sets the states URI.
  String? statesUri;

  /// Gets or sets the languages URI.
  String? languagesUri;

  /// Gets or sets the currencies URI.
  String? currenciesUri;

  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the name.
  String? name;

  /// Gets or sets the description.
  String? description;

  /// Gets or sets a value indicating whether this instance is active.
  bool? isActive;

  /// Gets or sets a value indicating whether this instance is restricted.
  bool? isRestricted;

  /// Gets or sets the countries.
  CountryCollection? countries;

  /// Gets or sets the states.
  StateCollection? states;

  /// Gets or sets the languages.
  LanguageCollection? languages;

  /// Gets or sets the currencies.
  CurrencyCollection? currencies;

  /// Gets or sets the mobile primary color
  String? mobilePrimaryColor;

  /// Gets or sets the mobile privacy policy url
  String? mobilePrivacyPolicyUrl;

  /// Gets or sets the mobile terms of use url
  String? mobileTermsOfUseUrl;

  Website({
    this.countriesUri,
    this.statesUri,
    this.languagesUri,
    this.currenciesUri,
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.isRestricted,
    this.countries,
    this.states,
    this.languages,
    this.currencies,
    this.mobilePrimaryColor,
    this.mobilePrivacyPolicyUrl,
    this.mobileTermsOfUseUrl,
  });

  factory Website.fromJson(Map<String, dynamic> json) =>
      _$WebsiteFromJson(json);

  Map<String, dynamic> toJson() => _$WebsiteToJson(this);
}
