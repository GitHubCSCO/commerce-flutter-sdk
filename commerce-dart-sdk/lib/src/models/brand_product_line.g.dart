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

Map<String, dynamic> _$BrandProductLineToJson(BrandProductLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('productListPagePath', instance.productListPagePath);
  writeNotNull('featuredImagePath', instance.featuredImagePath);
  writeNotNull('featuredImageAltText', instance.featuredImageAltText);
  writeNotNull('isFeatured', instance.isFeatured);
  writeNotNull('isSponsored', instance.isSponsored);
  return val;
}
