// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandCategory _$BrandCategoryFromJson(Map<String, dynamic> json) =>
    BrandCategory(
      brandId: json['brandId'] as String?,
      categoryId: json['categoryId'] as String?,
      contentManagerId: json['contentManagerId'] as String?,
      categoryName: json['categoryName'] as String?,
      categoryShortDescription: json['categoryShortDescription'] as String?,
      featuredImagePath: json['featuredImagePath'] as String?,
      featuredImageAltText: json['featuredImageAltText'] as String?,
      productListPagePath: json['productListPagePath'] as String?,
      htmlContent: json['htmlContent'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BrandCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$BrandCategoryToJson(BrandCategory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('brandId', instance.brandId);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('contentManagerId', instance.contentManagerId);
  writeNotNull('categoryName', instance.categoryName);
  writeNotNull('categoryShortDescription', instance.categoryShortDescription);
  writeNotNull('featuredImagePath', instance.featuredImagePath);
  writeNotNull('featuredImageAltText', instance.featuredImageAltText);
  writeNotNull('productListPagePath', instance.productListPagePath);
  writeNotNull('htmlContent', instance.htmlContent);
  writeNotNull('subCategories',
      instance.subCategories?.map((e) => e?.toJson()).toList());
  return val;
}
