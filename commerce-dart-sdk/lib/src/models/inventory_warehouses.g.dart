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

Map<String, dynamic> _$InventoryWarehousesToJson(
        InventoryWarehouses instance) =>
    <String, dynamic>{
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.warehouseDtos?.map((e) => e.toJson()).toList()
          case final value?)
        'warehouseDtos': value,
    };
