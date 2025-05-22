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

Map<String, dynamic> _$LanguageCollectionToJson(LanguageCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'languages', instance.languages?.map((e) => e.toJson()).toList());
  return val;
}
