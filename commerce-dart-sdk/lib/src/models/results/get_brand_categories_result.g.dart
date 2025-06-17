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
        GetBrandCategoriesResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.brandCategories?.map((e) => e.toJson()).toList()
          case final value?)
        'brandCategories': value,
    };
