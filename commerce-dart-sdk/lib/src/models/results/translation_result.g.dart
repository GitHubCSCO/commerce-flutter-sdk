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

Map<String, dynamic> _$TranslationResultsToJson(TranslationResults instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.translationDictionaries?.map((e) => e.toJson()).toList()
          case final value?)
        'translationDictionaries': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
