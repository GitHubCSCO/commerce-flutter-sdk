// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrdersQueryParametersToJson(
    OrdersQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('orderNumber', instance.orderNumber);
  writeNotNull('poNumber', instance.poNumber);
  writeNotNull('search', instance.search);
  writeNotNull('status', instance.status);
  val['customerSequence'] = instance.customerSequence;
  writeNotNull('fromDate', instance.fromDate?.toIso8601String());
  writeNotNull('toDate', instance.toDate?.toIso8601String());
  writeNotNull('orderTotalOperator', instance.orderTotalOperator);
  writeNotNull('orderTotal', instance.orderTotal);
  writeNotNull('productErpNumber', instance.productErpNumber);
  writeNotNull('showMyOrders', instance.showMyOrders);
  writeNotNull('vmiOrdersOnly', instance.vmiOrdersOnly);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  writeNotNull('vmiBinId', instance.vmiBinId);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}
