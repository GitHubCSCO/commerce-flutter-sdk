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
        TranslationDictionary instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.keyword case final value?) 'keyword': value,
      if (instance.source case final value?) 'source': value,
      if (instance.translation case final value?) 'translation': value,
      if (instance.languageId case final value?) 'languageId': value,
      if (instance.languageCode case final value?) 'languageCode': value,
    };
