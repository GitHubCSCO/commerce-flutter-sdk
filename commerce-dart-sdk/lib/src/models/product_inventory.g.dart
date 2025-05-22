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

Map<String, dynamic> _$ProductInventoryToJson(ProductInventory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('productId', instance.productId);
  writeNotNull('qtyOnHand', instance.qtyOnHand);
  writeNotNull('inventoryAvailabilityDtos',
      instance.inventoryAvailabilityDtos?.map((e) => e.toJson()).toList());
  writeNotNull('inventoryWarehousesDtos',
      instance.inventoryWarehousesDtos?.map((e) => e.toJson()).toList());
  writeNotNull('additionalResults', instance.additionalResults);
  return val;
}
