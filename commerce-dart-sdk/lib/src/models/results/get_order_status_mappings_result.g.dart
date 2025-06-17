// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_status_mappings_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderStatusMappingsResult _$GetOrderStatusMappingsResultFromJson(
        Map<String, dynamic> json) =>
    GetOrderStatusMappingsResult(
      orderStatusMappings: (json['orderStatusMappings'] as List<dynamic>?)
          ?.map((e) => OrderStatusMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetOrderStatusMappingsResultToJson(
        GetOrderStatusMappingsResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.orderStatusMappings?.map((e) => e.toJson()).toList()
          case final value?)
        'orderStatusMappings': value,
    };
