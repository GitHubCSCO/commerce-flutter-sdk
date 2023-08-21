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
