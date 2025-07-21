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
        RealTimeInventoryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.includeAlternateInventory case final value?)
        'includeAlternateInventory': value,
      if (instance.expand case final value?) 'expand': value,
    };
