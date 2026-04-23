// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_facet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryFacet _$CategoryFacetFromJson(Map<String, dynamic> json) =>
    CategoryFacet(
      categoryId: json['categoryId'] as String?,
      shortDescription: json['shortDescription'] as String?,
      count: (json['count'] as num?)?.toInt(),
      selected: json['selected'] as bool?,
      subCategoryFacets: (json['subCategoryFacets'] as List<dynamic>?)
          ?.map((e) => CategoryFacet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryFacetToJson(CategoryFacet instance) =>
    <String, dynamic>{
      if (instance.categoryId case final value?) 'categoryId': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.count case final value?) 'count': value,
      if (instance.selected case final value?) 'selected': value,
      if (instance.subCategoryFacets?.map((e) => e.toJson()).toList()
          case final value?)
        'subCategoryFacets': value,
    };
