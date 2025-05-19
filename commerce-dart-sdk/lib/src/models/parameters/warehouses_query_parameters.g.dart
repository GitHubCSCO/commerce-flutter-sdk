// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouses_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$WarehousesQueryParametersToJson(
    WarehousesQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('onlyPickupWarehouses', instance.onlyPickupWarehouses);
  writeNotNull('useDefaultLocation', instance.useDefaultLocation);
  writeNotNull('radius', instance.radius);
  writeNotNull(
      'excludeCurrentPickupWarehouse', instance.excludeCurrentPickupWarehouse);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}
