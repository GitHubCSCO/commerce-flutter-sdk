// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_real_time_inventory_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRealTimeInventoryResult _$GetRealTimeInventoryResultFromJson(
        Map<String, dynamic> json) =>
    GetRealTimeInventoryResult(
      realTimeInventoryResults:
          (json['realTimeInventoryResults'] as List<dynamic>?)
              ?.map((e) => ProductInventory.fromJson(e as Map<String, dynamic>))
              .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetRealTimeInventoryResultToJson(
    GetRealTimeInventoryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('realTimeInventoryResults',
      instance.realTimeInventoryResults?.map((e) => e.toJson()).toList());
  return val;
}
