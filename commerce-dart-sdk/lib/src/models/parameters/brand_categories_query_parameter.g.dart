// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_categories_query_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BrandCategoriesQueryParameterToJson(
    BrandCategoriesQueryParameter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('brandId', instance.brandId);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('productListPagePath', instance.productListPagePath);
  val['maximumDepth'] = instance.maximumDepth;
  return val;
}
