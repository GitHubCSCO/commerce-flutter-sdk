// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_warehouses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryWarehouses _$InventoryWarehousesFromJson(Map<String, dynamic> json) =>
    InventoryWarehouses(
      unitOfMeasure: json['unitOfMeasure'] as String?,
      warehouseDtos: (json['warehouseDtos'] as List<dynamic>?)
          ?.map((e) => InventoryWarehouse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InventoryWarehousesToJson(InventoryWarehouses instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull(
      'warehouseDtos', instance.warehouseDtos?.map((e) => e.toJson()).toList());
  return val;
}
