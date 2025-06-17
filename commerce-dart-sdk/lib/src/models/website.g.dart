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

Map<String, dynamic> _$WebsiteToJson(Website instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.countriesUri case final value?) 'countriesUri': value,
      if (instance.statesUri case final value?) 'statesUri': value,
      if (instance.languagesUri case final value?) 'languagesUri': value,
      if (instance.currenciesUri case final value?) 'currenciesUri': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.isRestricted case final value?) 'isRestricted': value,
      if (instance.countries?.toJson() case final value?) 'countries': value,
      if (instance.states?.toJson() case final value?) 'states': value,
      if (instance.languages?.toJson() case final value?) 'languages': value,
      if (instance.currencies?.toJson() case final value?) 'currencies': value,
      if (instance.mobilePrimaryColor case final value?)
        'mobilePrimaryColor': value,
      if (instance.mobilePrivacyPolicyUrl case final value?)
        'mobilePrivacyPolicyUrl': value,
      if (instance.mobileTermsOfUseUrl case final value?)
        'mobileTermsOfUseUrl': value,
    };
