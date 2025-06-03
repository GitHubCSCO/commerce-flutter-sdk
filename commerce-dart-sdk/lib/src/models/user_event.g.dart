// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEvent _$UserEventFromJson(Map<String, dynamic> json) => UserEvent(
      eventName: json['eventName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      fullName: json['fullName'] as String?,
      properties: json['properties'] == null
          ? null
          : EventProperties.fromJson(
              json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserEventToJson(UserEvent instance) => <String, dynamic>{
      if (instance.eventName case final value?) 'eventName': value,
      if (instance.emailAddress case final value?) 'emailAddress': value,
      if (instance.fullName case final value?) 'fullName': value,
      if (instance.properties?.toJson() case final value?) 'properties': value,
    };

EventProperties _$EventPropertiesFromJson(Map<String, dynamic> json) =>
    EventProperties(
      appVersion: json['appVersion'] as String?,
      customTrait2: (json['customTrait2'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EventPropertiesToJson(EventProperties instance) =>
    <String, dynamic>{
      if (instance.appVersion case final value?) 'appVersion': value,
      if (instance.customTrait2 case final value?) 'customTrait2': value,
    };

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      if (instance.success case final value?) 'success': value,
      if (instance.message case final value?) 'message': value,
    };
