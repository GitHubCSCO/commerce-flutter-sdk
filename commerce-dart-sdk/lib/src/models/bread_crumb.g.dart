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

Map<String, dynamic> _$BreadCrumbToJson(BreadCrumb instance) =>
    <String, dynamic>{
      if (instance.text case final value?) 'text': value,
      if (instance.url case final value?) 'url': value,
      if (instance.categoryId case final value?) 'categoryId': value,
    };
