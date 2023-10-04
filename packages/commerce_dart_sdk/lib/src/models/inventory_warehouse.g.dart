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

Map<String, dynamic> _$InventoryWarehouseToJson(InventoryWarehouse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('messageType', instance.messageType);
  writeNotNull('message', instance.message);
  writeNotNull('requiresRealTimeInventory', instance.requiresRealTimeInventory);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('qty', instance.qty);
  return val;
}
