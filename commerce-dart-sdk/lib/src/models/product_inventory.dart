import 'models.dart';

part 'product_inventory.g.dart';

@JsonSerializable()
class ProductInventory {
  String? productId;

  num? qtyOnHand;

  List<InventoryAvailability>? inventoryAvailabilityDtos;

  List<InventoryWarehouses>? inventoryWarehousesDtos;

  Map<String, String>? additionalResults;

  ProductInventory({
    this.productId,
    this.qtyOnHand,
    this.inventoryAvailabilityDtos,
    this.inventoryWarehousesDtos,
    this.additionalResults,
  });

  factory ProductInventory.fromJson(Map<String, dynamic> json) =>
      _$ProductInventoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInventoryToJson(this);
}
