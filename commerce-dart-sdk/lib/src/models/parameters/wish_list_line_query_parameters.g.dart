// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_line_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$WishListLineQueryParametersToJson(
    WishListLineQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('query', instance.query);
  writeNotNull('defaultPageSize', instance.defaultPageSize);
  writeNotNull('changedSharedListLinesQuantities',
      instance.changedSharedListLinesQuantities);
  writeNotNull('sort', instance.sort);
  return val;
}
