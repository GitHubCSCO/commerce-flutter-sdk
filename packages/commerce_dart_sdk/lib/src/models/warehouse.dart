import 'models.dart';

part 'warehouse.g.dart';

@JsonSerializable(explicitToJson: true)
class Warehouse extends Availability {
  Warehouse({
    required this.id,
    required this.name,
    required this.address1,
    required this.address2,
    required this.city,
    required this.contactName,
    this.countryId,
    this.deactivateOn,
    required this.description,
    required this.phone,
    required this.postalCode,
    required this.shipSite,
    required this.state,
    required this.isDefault,
    required this.alternateWarehouses,
    required this.latitude,
    required this.longitude,
    required this.hours,
    required this.distance,
    required this.allowPickup,
    this.pickupShipViaId,
  });

  late String? id;
  late String? name;
  late String? address1;
  late String? address2;
  late String? city;
  late String? contactName;
  late String? countryId;
  late DateTime? deactivateOn;
  late String? description;
  late String? phone;
  late String? postalCode;
  late String? shipSite;
  late String? state;
  late bool? isDefault;
  late List<Warehouse>? alternateWarehouses;
  late num? latitude;
  late num? longitude;
  late String? hours;
  late double? distance;
  late bool? allowPickup;
  late String? pickupShipViaId;

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseFromJson(json);
  Map<String, dynamic> toJson() => _$WarehouseToJson(this);
}
