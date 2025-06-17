// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      abbreviation: json['abbreviation'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.abbreviation case final value?) 'abbreviation': value,
      if (instance.states?.map((e) => e.toJson()).toList() case final value?)
        'states': value,
    };
