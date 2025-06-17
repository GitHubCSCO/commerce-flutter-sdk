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

Map<String, dynamic> _$SiteMessageToJson(SiteMessage instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.message case final value?) 'message': value,
      if (instance.languageCode case final value?) 'languageCode': value,
    };
