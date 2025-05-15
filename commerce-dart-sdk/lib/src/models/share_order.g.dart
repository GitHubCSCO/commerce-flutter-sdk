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

Map<String, dynamic> _$ShareOrderToJson(ShareOrder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('stEmail', instance.stEmail);
  writeNotNull('stPostalCode', instance.stPostalCode);
  writeNotNull('emailTo', instance.emailTo);
  writeNotNull('emailFrom', instance.emailFrom);
  writeNotNull('subject', instance.subject);
  writeNotNull('message', instance.message);
  writeNotNull('entityId', instance.entityId);
  writeNotNull('entityName', instance.entityName);
  return val;
}
