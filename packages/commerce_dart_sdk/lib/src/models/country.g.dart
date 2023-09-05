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
          ?.map((e) => State.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'states': instance.states?.map((e) => e.toJson()).toList(),
    };
