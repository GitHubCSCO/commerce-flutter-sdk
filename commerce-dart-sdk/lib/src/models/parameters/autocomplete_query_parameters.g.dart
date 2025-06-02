// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AutocompleteQueryParametersToJson(
    AutocompleteQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('query', instance.query);
  writeNotNull('categoryEnabled', instance.categoryEnabled);
  writeNotNull('contentEnabled', instance.contentEnabled);
  writeNotNull('productEnabled', instance.productEnabled);
  writeNotNull('brandEnabled', instance.brandEnabled);
  return val;
}
