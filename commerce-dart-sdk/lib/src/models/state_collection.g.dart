// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateCollection _$StateCollectionFromJson(Map<String, dynamic> json) =>
    StateCollection(
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$StateCollectionToJson(StateCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('states', instance.states?.map((e) => e.toJson()).toList());
  return val;
}
