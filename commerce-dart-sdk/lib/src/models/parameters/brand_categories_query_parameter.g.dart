// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_categories_query_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BrandCategoriesQueryParameterToJson(
        BrandCategoriesQueryParameter instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.brandId case final value?) 'brandId': value,
      if (instance.categoryId case final value?) 'categoryId': value,
      if (instance.productListPagePath case final value?)
        'productListPagePath': value,
      'maximumDepth': instance.maximumDepth,
    };
