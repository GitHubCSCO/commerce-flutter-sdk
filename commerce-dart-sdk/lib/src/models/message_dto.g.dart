// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      customerOrderId: json['customerOrderId'] as String?,
      toUserProfileId: json['toUserProfileId'] as String?,
      toUserProfileName: json['toUserProfileName'] as String?,
      subject: json['subject'] as String?,
      message: json['message'] as String?,
      process: json['process'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.customerOrderId case final value?) 'customerOrderId': value,
      if (instance.toUserProfileId case final value?) 'toUserProfileId': value,
      if (instance.toUserProfileName case final value?)
        'toUserProfileName': value,
      if (instance.subject case final value?) 'subject': value,
      if (instance.message case final value?) 'message': value,
      if (instance.process case final value?) 'process': value,
    };
