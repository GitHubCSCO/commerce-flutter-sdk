// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carts_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CartsQueryParametersToJson(
    CartsQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('billToId', instance.billToId);
  writeNotNull('shipToId', instance.shipToId);
  writeNotNull('status', instance.status);
  writeNotNull('orderNumber', instance.orderNumber);
  writeNotNull('fromDate', instance.fromDate?.toIso8601String());
  writeNotNull('toDate', instance.toDate?.toIso8601String());
  writeNotNull('orderTotalOperator', instance.orderTotalOperator);
  writeNotNull('orderTotal', instance.orderTotal);
  writeNotNull('orderSubtotalOperator', instance.orderSubtotalOperator);
  writeNotNull('orderSubtotal', instance.orderSubtotal);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  return val;
}
