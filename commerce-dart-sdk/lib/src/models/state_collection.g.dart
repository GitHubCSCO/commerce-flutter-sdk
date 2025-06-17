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

Map<String, dynamic> _$StateCollectionToJson(StateCollection instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.states?.map((e) => e.toJson()).toList() case final value?)
        'states': value,
    };
