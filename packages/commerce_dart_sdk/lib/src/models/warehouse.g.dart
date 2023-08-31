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
        (k, e) => MapEntry(k, e as String),
      )
      ..messageType = json['messageType'] as int?
      ..message = json['message'] as String?
      ..requiresRealTimeInventory = json['requiresRealTimeInventory'] as bool?;

Map<String, dynamic> _$WarehouseToJson(Warehouse instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'messageType': instance.messageType,
      'message': instance.message,
      'requiresRealTimeInventory': instance.requiresRealTimeInventory,
      'id': instance.id,
      'name': instance.name,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'contactName': instance.contactName,
      'countryId': instance.countryId,
      'deactivateOn': instance.deactivateOn?.toIso8601String(),
      'description': instance.description,
      'phone': instance.phone,
      'postalCode': instance.postalCode,
      'shipSite': instance.shipSite,
      'state': instance.state,
      'isDefault': instance.isDefault,
      'alternateWarehouses':
          instance.alternateWarehouses?.map((e) => e.toJson()).toList(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'hours': instance.hours,
      'distance': instance.distance,
      'allowPickup': instance.allowPickup,
      'pickupShipViaId': instance.pickupShipViaId,
    };
