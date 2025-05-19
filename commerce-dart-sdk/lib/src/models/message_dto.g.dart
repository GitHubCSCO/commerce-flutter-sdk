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

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('customerOrderId', instance.customerOrderId);
  writeNotNull('toUserProfileId', instance.toUserProfileId);
  writeNotNull('toUserProfileName', instance.toUserProfileName);
  writeNotNull('subject', instance.subject);
  writeNotNull('message', instance.message);
  writeNotNull('process', instance.process);
  return val;
}
