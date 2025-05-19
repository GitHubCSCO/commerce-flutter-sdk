// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_tos_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ShipTosQueryParametersToJson(
    ShipTosQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort', instance.sort);
  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('billToId', instance.billToId);
  writeNotNull('filter', instance.filter);
  writeNotNull(
      'exclude', JsonEncodingMethods.commaSeparatedJson(instance.exclude));
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}
