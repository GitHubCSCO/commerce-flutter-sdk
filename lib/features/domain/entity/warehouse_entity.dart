// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';

class WarehouseEntity extends AvailabilityEntity {
  final String? id;
  final String? name;
  final String? address1;
  final String? address2;
  final String? city;
  final String? contactName;
  final String? countryId;
  final DateTime? deactivateOn;
  final String? description;
  final String? phone;
  final String? postalCode;
  final String? shipSite;
  final String? state;
  final bool? isDefault;
  final List<WarehouseEntity>? alternateWarehouses;
  final num? latitude;
  final num? longitude;
  final String? hours;
  final double? distance;
  final bool? allowPickup;
  final String? pickupShipViaId;
  final LatLong? latLong;

  const WarehouseEntity({
    final int? messageType,
    final String? message,
    final bool? requiresRealTimeInventory,
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
    this.latLong,
  }) : super(
            message: message,
            messageType: messageType,
            requiresRealTimeInventory: requiresRealTimeInventory);

  @override
  WarehouseEntity copyWith({
    int? messageType,
    String? message,
    bool? requiresRealTimeInventory,
    String? id,
    String? name,
    String? address1,
    String? address2,
    String? city,
    String? contactName,
    String? countryId,
    DateTime? deactivateOn,
    String? description,
    String? phone,
    String? postalCode,
    String? shipSite,
    String? state,
    bool? isDefault,
    List<WarehouseEntity>? alternateWarehouses,
    num? latitude,
    num? longitude,
    String? hours,
    double? distance,
    bool? allowPickup,
    String? pickupShipViaId,
    LatLong? latLong,
  }) {
    return WarehouseEntity(
      messageType: messageType ?? this.messageType,
      message: message ?? this.message,
      requiresRealTimeInventory:
          requiresRealTimeInventory ?? this.requiresRealTimeInventory,
      id: id ?? this.id,
      name: name ?? this.name,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      contactName: contactName ?? this.contactName,
      countryId: countryId ?? this.countryId,
      deactivateOn: deactivateOn ?? this.deactivateOn,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      postalCode: postalCode ?? this.postalCode,
      shipSite: shipSite ?? this.shipSite,
      state: state ?? this.state,
      isDefault: isDefault ?? this.isDefault,
      alternateWarehouses: alternateWarehouses ?? this.alternateWarehouses,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      hours: hours ?? this.hours,
      distance: distance ?? this.distance,
      allowPickup: allowPickup ?? this.allowPickup,
      pickupShipViaId: pickupShipViaId ?? this.pickupShipViaId,
      latLong: latLong ?? this.latLong,
    );
  }
}
