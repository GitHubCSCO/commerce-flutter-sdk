// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouses_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$WarehousesQueryParametersToJson(
        WarehousesQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.onlyPickupWarehouses case final value?)
        'onlyPickupWarehouses': value,
      if (instance.useDefaultLocation case final value?)
        'useDefaultLocation': value,
      if (instance.radius case final value?) 'radius': value,
      if (instance.excludeCurrentPickupWarehouse case final value?)
        'excludeCurrentPickupWarehouse': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };
