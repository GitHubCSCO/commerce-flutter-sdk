// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bread_crumb.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreadCrumb _$BreadCrumbFromJson(Map<String, dynamic> json) => BreadCrumb(
      text: json['text'] as String?,
      url: json['url'] as String?,
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$BreadCrumbToJson(BreadCrumb instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('text', instance.text);
  writeNotNull('url', instance.url);
  writeNotNull('categoryId', instance.categoryId);
  return val;
}
