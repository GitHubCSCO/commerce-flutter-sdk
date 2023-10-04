// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      detailPagePath: json['detailPagePath'] as String?,
      externalUrl: json['externalUrl'] as String?,
      featuredImageAltText: json['featuredImageAltText'] as String?,
      featuredImagePath: json['featuredImagePath'] as String?,
      htmlContent: json['htmlContent'] as String?,
      id: json['id'] as String?,
      logoAltText: json['logoAltText'] as String?,
      logoLargeImagePath: json['logoLargeImagePath'] as String?,
      logoSmallImagePath: json['logoSmallImagePath'] as String?,
      manufacturer: json['manufacturer'] as String?,
      name: json['name'] as String?,
      productListPagePage: json['productListPagePage'] as String?,
      topSellerProducts: (json['topSellerProducts'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$BrandToJson(Brand instance) {
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
  writeNotNull('manufacturer', instance.manufacturer);
  writeNotNull('externalUrl', instance.externalUrl);
  writeNotNull('detailPagePath', instance.detailPagePath);
  writeNotNull('productListPagePage', instance.productListPagePage);
  writeNotNull('logoSmallImagePath', instance.logoSmallImagePath);
  writeNotNull('logoLargeImagePath', instance.logoLargeImagePath);
  writeNotNull('logoAltText', instance.logoAltText);
  writeNotNull('featuredImagePath', instance.featuredImagePath);
  writeNotNull('featuredImageAltText', instance.featuredImageAltText);
  writeNotNull('htmlContent', instance.htmlContent);
  writeNotNull('topSellerProducts',
      instance.topSellerProducts?.map((e) => e.toJson()).toList());
  return val;
}

BrandAlphabet _$BrandAlphabetFromJson(Map<String, dynamic> json) =>
    BrandAlphabet(
      count: json['count'] as int?,
      letter: json['letter'] as String?,
    );

Map<String, dynamic> _$BrandAlphabetToJson(BrandAlphabet instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('letter', instance.letter);
  writeNotNull('count', instance.count);
  return val;
}
