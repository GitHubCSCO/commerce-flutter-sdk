// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrdersQueryParametersToJson(
        OrdersQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.orderNumber case final value?) 'orderNumber': value,
      if (instance.poNumber case final value?) 'poNumber': value,
      if (instance.search case final value?) 'search': value,
      if (instance.status case final value?) 'status': value,
      'customerSequence': instance.customerSequence,
      if (instance.fromDate?.toIso8601String() case final value?)
        'fromDate': value,
      if (instance.toDate?.toIso8601String() case final value?) 'toDate': value,
      if (instance.orderTotalOperator case final value?)
        'orderTotalOperator': value,
      if (instance.orderTotal case final value?) 'orderTotal': value,
      if (instance.productErpNumber case final value?)
        'productErpNumber': value,
      if (instance.showMyOrders case final value?) 'showMyOrders': value,
      if (instance.vmiOrdersOnly case final value?) 'vmiOrdersOnly': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      if (instance.vmiBinId case final value?) 'vmiBinId': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };
