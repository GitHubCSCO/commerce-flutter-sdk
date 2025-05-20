// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationResults _$TranslationResultsFromJson(Map<String, dynamic> json) =>
    TranslationResults(
      translationDictionaries: (json['translationDictionaries']
              as List<dynamic>?)
          ?.map(
              (e) => TranslationDictionary.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$TranslationResultsToJson(TranslationResults instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('translationDictionaries',
      instance.translationDictionaries?.map((e) => e.toJson()).toList());
  writeNotNull('pagination', instance.pagination?.toJson());
  return val;
}
