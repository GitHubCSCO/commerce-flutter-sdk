// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability(
      message: json['message'] as String?,
      messageType: json['messageType'] as int?,
      requiresRealTimeInventory: json['requiresRealTimeInventory'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'messageType': instance.messageType,
      'message': instance.message,
      'requiresRealTimeInventory': instance.requiresRealTimeInventory,
    };
