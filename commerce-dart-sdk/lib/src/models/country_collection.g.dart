// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryCollection _$CountryCollectionFromJson(Map<String, dynamic> json) =>
    CountryCollection(
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CountryCollectionToJson(CountryCollection instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.countries?.map((e) => e.toJson()).toList() case final value?)
        'countries': value,
    };
