// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Website _$WebsiteFromJson(Map<String, dynamic> json) => Website(
      countriesUri: json['countriesUri'] as String?,
      statesUri: json['statesUri'] as String?,
      languagesUri: json['languagesUri'] as String?,
      currenciesUri: json['currenciesUri'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
      isRestricted: json['isRestricted'] as bool?,
      countries: json['countries'] == null
          ? null
          : CountryCollection.fromJson(
              json['countries'] as Map<String, dynamic>),
      states: json['states'] == null
          ? null
          : StateCollection.fromJson(json['states'] as Map<String, dynamic>),
      languages: json['languages'] == null
          ? null
          : LanguageCollection.fromJson(
              json['languages'] as Map<String, dynamic>),
      currencies: json['currencies'] == null
          ? null
          : CurrencyCollection.fromJson(
              json['currencies'] as Map<String, dynamic>),
      mobilePrimaryColor: json['mobilePrimaryColor'] as String?,
      mobilePrivacyPolicyUrl: json['mobilePrivacyPolicyUrl'] as String?,
      mobileTermsOfUseUrl: json['mobileTermsOfUseUrl'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WebsiteToJson(Website instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('countriesUri', instance.countriesUri);
  writeNotNull('statesUri', instance.statesUri);
  writeNotNull('languagesUri', instance.languagesUri);
  writeNotNull('currenciesUri', instance.currenciesUri);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('isRestricted', instance.isRestricted);
  writeNotNull('countries', instance.countries?.toJson());
  writeNotNull('states', instance.states?.toJson());
  writeNotNull('languages', instance.languages?.toJson());
  writeNotNull('currencies', instance.currencies?.toJson());
  writeNotNull('mobilePrimaryColor', instance.mobilePrimaryColor);
  writeNotNull('mobilePrivacyPolicyUrl', instance.mobilePrivacyPolicyUrl);
  writeNotNull('mobileTermsOfUseUrl', instance.mobileTermsOfUseUrl);
  return val;
}
