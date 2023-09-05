// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

State _$StateFromJson(Map<String, dynamic> json) => State(
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

Map<String, dynamic> _$StateToJson(State instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'states': instance.states?.map((e) => e.toJson()).toList(),
    };
