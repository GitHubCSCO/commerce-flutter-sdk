// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_approval_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderApprovalParametersToJson(
    OrderApprovalParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('shipToId', instance.shipToId);
  writeNotNull('orderNumber', instance.orderNumber);
  writeNotNull('orderTotal', instance.orderTotal);
  writeNotNull('fromDate', instance.fromDate?.toIso8601String());
  writeNotNull('toDate', instance.toDate?.toIso8601String());
  writeNotNull('orderTotalOperator', instance.orderTotalOperator);
  return val;
}
