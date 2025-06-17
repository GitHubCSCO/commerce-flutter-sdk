// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryAvailability _$InventoryAvailabilityFromJson(
        Map<String, dynamic> json) =>
    InventoryAvailability(
      unitOfMeasure: json['unitOfMeasure'] as String?,
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InventoryAvailabilityToJson(
        InventoryAvailability instance) =>
    <String, dynamic>{
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.availability?.toJson() case final value?)
        'availability': value,
    };
