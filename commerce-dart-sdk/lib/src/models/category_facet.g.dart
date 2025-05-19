// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_facet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryFacet _$CategoryFacetFromJson(Map<String, dynamic> json) =>
    CategoryFacet(
      categoryId: json['categoryId'] as String?,
      websiteId: json['websiteId'] as String?,
      shortDescription: json['shortDescription'] as String?,
      count: (json['count'] as num?)?.toInt(),
      selected: json['selected'] as bool?,
      subCategoryDtos: (json['subCategoryDtos'] as List<dynamic>?)
          ?.map((e) => CategoryFacet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryFacetToJson(CategoryFacet instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('websiteId', instance.websiteId);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('count', instance.count);
  writeNotNull('selected', instance.selected);
  writeNotNull('subCategoryDtos',
      instance.subCategoryDtos?.map((e) => e.toJson()).toList());
  return val;
}
