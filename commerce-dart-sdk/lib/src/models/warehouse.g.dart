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

Map<String, dynamic> _$WarehouseToJson(Warehouse instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.messageType case final value?) 'messageType': value,
      if (instance.message case final value?) 'message': value,
      if (instance.requiresRealTimeInventory case final value?)
        'requiresRealTimeInventory': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.address1 case final value?) 'address1': value,
      if (instance.address2 case final value?) 'address2': value,
      if (instance.city case final value?) 'city': value,
      if (instance.contactName case final value?) 'contactName': value,
      if (instance.countryId case final value?) 'countryId': value,
      if (instance.deactivateOn?.toIso8601String() case final value?)
        'deactivateOn': value,
      if (instance.description case final value?) 'description': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.postalCode case final value?) 'postalCode': value,
      if (instance.shipSite case final value?) 'shipSite': value,
      if (instance.state case final value?) 'state': value,
      if (instance.isDefault case final value?) 'isDefault': value,
      if (instance.alternateWarehouses?.map((e) => e.toJson()).toList()
          case final value?)
        'alternateWarehouses': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.hours case final value?) 'hours': value,
      if (instance.distance case final value?) 'distance': value,
      if (instance.allowPickup case final value?) 'allowPickup': value,
      if (instance.pickupShipViaId case final value?) 'pickupShipViaId': value,
    };
