// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_time_inventory_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealTimeInventoryParameters _$RealTimeInventoryParametersFromJson(
        Map<String, dynamic> json) =>
    RealTimeInventoryParameters(
      includeAlternateInventory: json['includeAlternateInventory'] as bool?,
      expand: json['expand'] as String?,
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$RealTimeInventoryParametersToJson(
    RealTimeInventoryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('includeAlternateInventory', instance.includeAlternateInventory);
  writeNotNull('expand', instance.expand);
  return val;
}
