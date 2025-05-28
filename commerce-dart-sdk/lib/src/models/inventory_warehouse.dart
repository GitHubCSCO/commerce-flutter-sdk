import 'models.dart';

part 'inventory_warehouse.g.dart';

@JsonSerializable(explicitToJson: true)
class InventoryWarehouse extends Availability {
  InventoryWarehouse({
    this.description,
    this.name,
    this.qty,
  });

  String? name;

  String? description;

  num? qty;

  factory InventoryWarehouse.fromJson(Map<String, dynamic> json) =>
      _$InventoryWarehouseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$InventoryWarehouseToJson(this);
}
