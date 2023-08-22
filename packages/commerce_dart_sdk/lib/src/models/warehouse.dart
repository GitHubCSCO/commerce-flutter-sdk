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

  String? id;
  String? name;
  String? address1;
  String? address2;
  String? city;
  String? contactName;
  String? countryId;
  DateTime? deactivateOn;
  String? description;
  String? phone;
  String? postalCode;
  String? shipSite;
  String? state;
  bool? isDefault;
  List<Warehouse>? alternateWarehouses;
  num? latitude;
  num? longitude;
  String? hours;
  double? distance;
  bool? allowPickup;
  String? pickupShipViaId;

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseFromJson(json);
  Map<String, dynamic> toJson() => _$WarehouseToJson(this);
}
