// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_warehouse_collection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWarehouseCollectionResult _$GetWarehouseCollectionResultFromJson(
        Map<String, dynamic> json) =>
    GetWarehouseCollectionResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      warehouses: (json['warehouses'] as List<dynamic>?)
          ?.map((e) => Warehouse.fromJson(e as Map<String, dynamic>))
          .toList(),
      distanceUnitOfMeasure: json['distanceUnitOfMeasure'] as String?,
      defaultLatitude: (json['defaultLatitude'] as num?)?.toDouble(),
      defaultLongitude: (json['defaultLongitude'] as num?)?.toDouble(),
      defaultRadius: (json['defaultRadius'] as num?)?.toInt(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetWarehouseCollectionResultToJson(
        GetWarehouseCollectionResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.warehouses?.map((e) => e.toJson()).toList()
          case final value?)
        'warehouses': value,
      if (instance.distanceUnitOfMeasure case final value?)
        'distanceUnitOfMeasure': value,
      if (instance.defaultLatitude case final value?) 'defaultLatitude': value,
      if (instance.defaultLongitude case final value?)
        'defaultLongitude': value,
      if (instance.defaultRadius case final value?) 'defaultRadius': value,
    };
