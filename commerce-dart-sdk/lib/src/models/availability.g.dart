// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability(
      message: json['message'] as String?,
      messageType: (json['messageType'] as num?)?.toInt(),
      requiresRealTimeInventory: json['requiresRealTimeInventory'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AvailabilityToJson(Availability instance) {
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
  return val;
}
