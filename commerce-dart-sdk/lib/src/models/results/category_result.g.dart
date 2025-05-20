// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResult _$CategoryResultFromJson(Map<String, dynamic> json) =>
    CategoryResult(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CategoryResultToJson(CategoryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'categories', instance.categories?.map((e) => e.toJson()).toList());
  return val;
}
