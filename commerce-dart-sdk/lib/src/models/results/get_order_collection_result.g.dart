// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_collection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderCollectionResult _$GetOrderCollectionResultFromJson(
        Map<String, dynamic> json) =>
    GetOrderCollectionResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      showErpOrderNumber: json['showErpOrderNumber'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetOrderCollectionResultToJson(
        GetOrderCollectionResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.orders?.map((e) => e.toJson()).toList() case final value?)
        'orders': value,
      if (instance.showErpOrderNumber case final value?)
        'showErpOrderNumber': value,
    };
