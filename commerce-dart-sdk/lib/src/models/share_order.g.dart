// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareOrder _$ShareOrderFromJson(Map<String, dynamic> json) => ShareOrder(
      stEmail: json['stEmail'] as String?,
      stPostalCode: json['stPostalCode'] as String?,
      emailTo: json['emailTo'] as String?,
      emailFrom: json['emailFrom'] as String?,
      subject: json['subject'] as String?,
      message: json['message'] as String?,
      entityId: json['entityId'] as String?,
      entityName: json['entityName'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$ShareOrderToJson(ShareOrder instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.stEmail case final value?) 'stEmail': value,
      if (instance.stPostalCode case final value?) 'stPostalCode': value,
      if (instance.emailTo case final value?) 'emailTo': value,
      if (instance.emailFrom case final value?) 'emailFrom': value,
      if (instance.subject case final value?) 'subject': value,
      if (instance.message case final value?) 'message': value,
      if (instance.entityId case final value?) 'entityId': value,
      if (instance.entityName case final value?) 'entityName': value,
    };
