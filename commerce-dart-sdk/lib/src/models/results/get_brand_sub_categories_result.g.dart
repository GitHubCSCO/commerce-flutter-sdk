// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_brand_sub_categories_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBrandSubCategoriesResult _$GetBrandSubCategoriesResultFromJson(
        Map<String, dynamic> json) =>
    GetBrandSubCategoriesResult(
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
          ?.map((e) =>
              GetBrandSubCategoriesResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetBrandSubCategoriesResultToJson(
        GetBrandSubCategoriesResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.brandId case final value?) 'brandId': value,
      if (instance.categoryId case final value?) 'categoryId': value,
      if (instance.contentManagerId case final value?)
        'contentManagerId': value,
      if (instance.categoryName case final value?) 'categoryName': value,
      if (instance.categoryShortDescription case final value?)
        'categoryShortDescription': value,
      if (instance.featuredImagePath case final value?)
        'featuredImagePath': value,
      if (instance.featuredImageAltText case final value?)
        'featuredImageAltText': value,
      if (instance.productListPagePath case final value?)
        'productListPagePath': value,
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.subCategories?.map((e) => e.toJson()).toList()
          case final value?)
        'subCategories': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
