import 'models.dart';

part 'inventory_warehouse.g.dart';

@JsonSerializable(explicitToJson: true)
class InventoryWarehouse extends Availability {
  InventoryWarehouse({
    this.id,
    this.description,
    this.name,
    this.qtyAvailable,
  });

  String? id;

  String? name;

  String? description;

  num? qtyAvailable;

  factory InventoryWarehouse.fromJson(Map<String, dynamic> json) =>
      _$InventoryWarehouseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$InventoryWarehouseToJson(this);
}
