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
        (k, e) => MapEntry(k, e as String),
      )
      ..messageType = json['messageType'] as int?
      ..message = json['message'] as String?
      ..requiresRealTimeInventory = json['requiresRealTimeInventory'] as bool?;

Map<String, dynamic> _$InventoryWarehouseToJson(InventoryWarehouse instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'messageType': instance.messageType,
      'message': instance.message,
      'requiresRealTimeInventory': instance.requiresRealTimeInventory,
      'name': instance.name,
      'description': instance.description,
      'qty': instance.qty,
    };
