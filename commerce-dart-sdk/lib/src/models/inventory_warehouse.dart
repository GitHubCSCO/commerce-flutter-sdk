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

  // The product V2 endpoint (`expand=warehouses`) returns per-warehouse stock
  // as `qtyAvailable`, while the real-time inventory endpoint returns the same
  // value under `qty`. Both responses deserialize through this model, so read
  // either key to keep both paths working.
  @JsonKey(readValue: _readQtyAvailable)
  num? qtyAvailable;

  static Object? _readQtyAvailable(Map json, String key) =>
      json[key] ?? json['qty'];

  factory InventoryWarehouse.fromJson(Map<String, dynamic> json) =>
      _$InventoryWarehouseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$InventoryWarehouseToJson(this);
}
