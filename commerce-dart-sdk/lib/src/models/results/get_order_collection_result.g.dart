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
    GetOrderCollectionResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull('orders', instance.orders?.map((e) => e.toJson()).toList());
  writeNotNull('showErpOrderNumber', instance.showErpOrderNumber);
  return val;
}
