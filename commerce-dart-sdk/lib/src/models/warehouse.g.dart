// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Warehouse _$WarehouseFromJson(Map<String, dynamic> json) => Warehouse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      contactName: json['contactName'] as String?,
      countryId: json['countryId'] as String?,
      deactivateOn: json['deactivateOn'] == null
          ? null
          : DateTime.parse(json['deactivateOn'] as String),
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      postalCode: json['postalCode'] as String?,
      shipSite: json['shipSite'] as String?,
      state: json['state'] as String?,
      isDefault: json['isDefault'] as bool?,
      alternateWarehouses: (json['alternateWarehouses'] as List<dynamic>?)
          ?.map((e) => Warehouse.fromJson(e as Map<String, dynamic>))
          .toList(),
      latitude: json['latitude'] as num?,
      longitude: json['longitude'] as num?,
      hours: json['hours'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      allowPickup: json['allowPickup'] as bool?,
      pickupShipViaId: json['pickupShipViaId'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      )
      ..messageType = (json['messageType'] as num?)?.toInt()
      ..message = json['message'] as String?
      ..requiresRealTimeInventory = json['requiresRealTimeInventory'] as bool?;

Map<String, dynamic> _$WarehouseToJson(Warehouse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('messageType', instance.messageType);
  writeNotNull('message', instance.message);
  writeNotNull('requiresRealTimeInventory', instance.requiresRealTimeInventory);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('city', instance.city);
  writeNotNull('contactName', instance.contactName);
  writeNotNull('countryId', instance.countryId);
  writeNotNull('deactivateOn', instance.deactivateOn?.toIso8601String());
  writeNotNull('description', instance.description);
  writeNotNull('phone', instance.phone);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('shipSite', instance.shipSite);
  writeNotNull('state', instance.state);
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull('alternateWarehouses',
      instance.alternateWarehouses?.map((e) => e.toJson()).toList());
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('hours', instance.hours);
  writeNotNull('distance', instance.distance);
  writeNotNull('allowPickup', instance.allowPickup);
  writeNotNull('pickupShipViaId', instance.pickupShipViaId);
  return val;
}
