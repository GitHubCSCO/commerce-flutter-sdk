// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carts_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CartsQueryParametersToJson(
        CartsQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.billToId case final value?) 'billToId': value,
      if (instance.shipToId case final value?) 'shipToId': value,
      if (instance.status case final value?) 'status': value,
      if (instance.orderNumber case final value?) 'orderNumber': value,
      if (instance.fromDate?.toIso8601String() case final value?)
        'fromDate': value,
      if (instance.toDate?.toIso8601String() case final value?) 'toDate': value,
      if (instance.orderTotalOperator case final value?)
        'orderTotalOperator': value,
      if (instance.orderTotal case final value?) 'orderTotal': value,
      if (instance.orderSubtotalOperator case final value?)
        'orderSubtotalOperator': value,
      if (instance.orderSubtotal case final value?) 'orderSubtotal': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
    };
