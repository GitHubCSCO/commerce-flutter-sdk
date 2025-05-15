// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CategoryQueryParametersToJson(
    CategoryQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('startCategoryId', instance.startCategoryId);
  writeNotNull('maxDepth', instance.maxDepth);
  writeNotNull('includeStartCategory', instance.includeStartCategory);
  return val;
}
