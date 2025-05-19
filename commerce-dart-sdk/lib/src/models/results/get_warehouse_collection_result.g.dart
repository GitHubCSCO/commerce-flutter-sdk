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
    GetWarehouseCollectionResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull(
      'warehouses', instance.warehouses?.map((e) => e.toJson()).toList());
  writeNotNull('distanceUnitOfMeasure', instance.distanceUnitOfMeasure);
  writeNotNull('defaultLatitude', instance.defaultLatitude);
  writeNotNull('defaultLongitude', instance.defaultLongitude);
  writeNotNull('defaultRadius', instance.defaultRadius);
  return val;
}
