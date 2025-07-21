// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_warehouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryWarehouse _$InventoryWarehouseFromJson(Map<String, dynamic> json) =>
    InventoryWarehouse(
      description: json['description'] as String?,
      name: json['name'] as String?,
      qty: json['qty'] as num?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      )
      ..messageType = (json['messageType'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..requiresRealTimeInventory = json['requiresRealTimeInventory'] as bool?;

Map<String, dynamic> _$InventoryWarehouseToJson(InventoryWarehouse instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.messageType case final value?) 'messageType': value,
      if (instance.message case final value?) 'message': value,
      if (instance.requiresRealTimeInventory case final value?)
        'requiresRealTimeInventory': value,
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.qty case final value?) 'qty': value,
    };
