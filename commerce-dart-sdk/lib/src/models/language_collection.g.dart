// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageCollection _$LanguageCollectionFromJson(Map<String, dynamic> json) =>
    LanguageCollection(
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$LanguageCollectionToJson(LanguageCollection instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.languages?.map((e) => e.toJson()).toList() case final value?)
        'languages': value,
    };
