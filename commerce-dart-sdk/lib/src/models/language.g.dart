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

Map<String, dynamic> _$LanguageToJson(Language instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('languageCode', instance.languageCode);
  writeNotNull('cultureCode', instance.cultureCode);
  writeNotNull('description', instance.description);
  writeNotNull('imageFilePath', instance.imageFilePath);
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull('isLive', instance.isLive);
  return val;
}
