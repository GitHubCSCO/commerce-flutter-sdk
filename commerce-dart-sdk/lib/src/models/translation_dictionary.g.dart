// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_dictionary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationDictionary _$TranslationDictionaryFromJson(
        Map<String, dynamic> json) =>
    TranslationDictionary(
      keyword: json['keyword'] as String?,
      source: json['source'] as String?,
      translation: json['translation'] as String?,
      languageId: json['languageId'] as String?,
      languageCode: json['languageCode'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$TranslationDictionaryToJson(
    TranslationDictionary instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('keyword', instance.keyword);
  writeNotNull('source', instance.source);
  writeNotNull('translation', instance.translation);
  writeNotNull('languageId', instance.languageId);
  writeNotNull('languageCode', instance.languageCode);
  return val;
}
