// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_product_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandProductLine _$BrandProductLineFromJson(Map<String, dynamic> json) =>
    BrandProductLine(
      id: json['id'] as String?,
      name: json['name'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      productListPagePath: json['productListPagePath'] as String?,
      featuredImagePath: json['featuredImagePath'] as String?,
      featuredImageAltText: json['featuredImageAltText'] as String?,
      isFeatured: json['isFeatured'] as bool?,
      isSponsored: json['isSponsored'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$BrandProductLineToJson(BrandProductLine instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.productListPagePath case final value?)
        'productListPagePath': value,
      if (instance.featuredImagePath case final value?)
        'featuredImagePath': value,
      if (instance.featuredImageAltText case final value?)
        'featuredImageAltText': value,
      if (instance.isFeatured case final value?) 'isFeatured': value,
      if (instance.isSponsored case final value?) 'isSponsored': value,
    };
