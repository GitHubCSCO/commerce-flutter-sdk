// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEvent _$UserEventFromJson(Map<String, dynamic> json) => UserEvent(
      eventName: json['eventName'] as String?,
      properties: json['properties'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserEventToJson(UserEvent instance) => <String, dynamic>{
      if (instance.eventName case final value?) 'eventName': value,
      if (instance.properties case final value?) 'properties': value,
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
