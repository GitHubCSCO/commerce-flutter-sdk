import 'models.dart';

part 'inventory_availability.g.dart';

@JsonSerializable()
class InventoryAvailability {
  String? unitOfMeasure;

  Availability? availability;

  InventoryAvailability({
    this.unitOfMeasure,
    this.availability,
  });

  factory InventoryAvailability.fromJson(Map<String, dynamic> json) =>
      _$InventoryAvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryAvailabilityToJson(this);
}
