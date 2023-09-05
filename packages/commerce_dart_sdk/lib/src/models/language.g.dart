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
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'id': instance.id,
      'languageCode': instance.languageCode,
      'cultureCode': instance.cultureCode,
      'description': instance.description,
      'imageFilePath': instance.imageFilePath,
      'isDefault': instance.isDefault,
      'isLive': instance.isLive,
    };
