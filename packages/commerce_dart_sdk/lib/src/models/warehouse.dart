import 'models.dart';

class Warehouse extends Availability {
  late String id;
  late String name;
  late String address1;
  late String address2;
  late String city;
  late String contactName;
  late String? countryId;
  late DateTime? deactivateOn;
  late String description;
  late String phone;
  late String postalCode;
  late String shipSite;
  late String state;
  late bool isDefault;
  late List<Warehouse> alternateWarehouses;
  late num latitude;
  late num longitude;
  late String hours;
  late double distance;
  late bool allowPickup;
  late String? pickupShipViaId;
}
