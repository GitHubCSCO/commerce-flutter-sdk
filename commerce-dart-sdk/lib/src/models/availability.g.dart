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

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.messageType case final value?) 'messageType': value,
      if (instance.message case final value?) 'message': value,
      if (instance.requiresRealTimeInventory case final value?)
        'requiresRealTimeInventory': value,
    };
