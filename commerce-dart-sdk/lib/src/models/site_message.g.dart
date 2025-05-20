// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteMessage _$SiteMessageFromJson(Map<String, dynamic> json) => SiteMessage(
      name: json['name'] as String?,
      message: json['message'] as String?,
      languageCode: json['languageCode'] as String?,
    );

Map<String, dynamic> _$SiteMessageToJson(SiteMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('message', instance.message);
  writeNotNull('languageCode', instance.languageCode);
  return val;
}
