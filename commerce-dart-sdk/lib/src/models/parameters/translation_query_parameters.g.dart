// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TranslationQueryParametersToJson(
    TranslationQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('keyword', instance.keyword);
  writeNotNull('source', instance.source);
  writeNotNull('languageCode', instance.languageCode);
  return val;
}
