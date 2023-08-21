import 'models.dart';

part 'warehouse.g.dart';

@JsonSerializable(explicitToJson: true)
class Warehouse extends Availability {
  Warehouse({
    this.id,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.contactName,
    this.countryId,
    this.deactivateOn,
    this.description,
    this.phone,
    this.postalCode,
    this.shipSite,
    this.state,
    this.isDefault,
    this.alternateWarehouses,
    this.latitude,
    this.longitude,
    this.hours,
    this.distance,
    this.allowPickup,
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
