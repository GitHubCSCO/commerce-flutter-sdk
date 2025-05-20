// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateModel _$StateModelFromJson(Map<String, dynamic> json) => StateModel(
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

Map<String, dynamic> _$StateModelToJson(StateModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('abbreviation', instance.abbreviation);
  writeNotNull('states', instance.states?.map((e) => e.toJson()).toList());
  return val;
}
