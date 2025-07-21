// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      cultureCode: json['cultureCode'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      imageFilePath: json['imageFilePath'] as String?,
      isDefault: json['isDefault'] as bool?,
      isLive: json['isLive'] as bool?,
      languageCode: json['languageCode'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.languageCode case final value?) 'languageCode': value,
      if (instance.cultureCode case final value?) 'cultureCode': value,
      if (instance.description case final value?) 'description': value,
      if (instance.imageFilePath case final value?) 'imageFilePath': value,
      if (instance.isDefault case final value?) 'isDefault': value,
      if (instance.isLive case final value?) 'isLive': value,
    };
