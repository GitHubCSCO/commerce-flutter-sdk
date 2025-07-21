// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInventory _$ProductInventoryFromJson(Map<String, dynamic> json) =>
    ProductInventory(
      productId: json['productId'] as String?,
      qtyOnHand: json['qtyOnHand'] as num?,
      inventoryAvailabilityDtos: (json['inventoryAvailabilityDtos']
              as List<dynamic>?)
          ?.map(
              (e) => InventoryAvailability.fromJson(e as Map<String, dynamic>))
          .toList(),
      inventoryWarehousesDtos: (json['inventoryWarehousesDtos']
              as List<dynamic>?)
          ?.map((e) => InventoryWarehouses.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalResults:
          (json['additionalResults'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$ProductInventoryToJson(ProductInventory instance) =>
    <String, dynamic>{
      if (instance.productId case final value?) 'productId': value,
      if (instance.qtyOnHand case final value?) 'qtyOnHand': value,
      if (instance.inventoryAvailabilityDtos?.map((e) => e.toJson()).toList()
          case final value?)
        'inventoryAvailabilityDtos': value,
      if (instance.inventoryWarehousesDtos?.map((e) => e.toJson()).toList()
          case final value?)
        'inventoryWarehousesDtos': value,
      if (instance.additionalResults case final value?)
        'additionalResults': value,
    };
