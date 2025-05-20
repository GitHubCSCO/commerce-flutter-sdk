// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_brand_categories_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBrandCategoriesResult _$GetBrandCategoriesResultFromJson(
        Map<String, dynamic> json) =>
    GetBrandCategoriesResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      brandCategories: (json['brandCategories'] as List<dynamic>?)
          ?.map((e) => BrandCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetBrandCategoriesResultToJson(
    GetBrandCategoriesResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull('brandCategories',
      instance.brandCategories?.map((e) => e.toJson()).toList());
  return val;
}
