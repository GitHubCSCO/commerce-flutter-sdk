import 'models.dart';

part 'inventory_warehouses.g.dart';

@JsonSerializable()
class InventoryWarehouses {
  String? unitOfMeasure;

  List<InventoryWarehouse>? warehouseDtos;

  InventoryWarehouses({
    this.unitOfMeasure,
    this.warehouseDtos,
  });

  factory InventoryWarehouses.fromJson(Map<String, dynamic> json) =>
      _$InventoryWarehousesFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryWarehousesToJson(this);
}
