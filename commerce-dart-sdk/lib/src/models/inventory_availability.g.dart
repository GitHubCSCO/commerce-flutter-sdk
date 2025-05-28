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
    InventoryAvailability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('availability', instance.availability?.toJson());
  return val;
}
