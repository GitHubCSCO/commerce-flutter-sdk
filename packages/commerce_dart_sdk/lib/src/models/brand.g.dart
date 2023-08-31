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

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'id': instance.id,
      'name': instance.name,
      'manufacturer': instance.manufacturer,
      'externalUrl': instance.externalUrl,
      'detailPagePath': instance.detailPagePath,
      'productListPagePage': instance.productListPagePage,
      'logoSmallImagePath': instance.logoSmallImagePath,
      'logoLargeImagePath': instance.logoLargeImagePath,
      'logoAltText': instance.logoAltText,
      'featuredImagePath': instance.featuredImagePath,
      'featuredImageAltText': instance.featuredImageAltText,
      'htmlContent': instance.htmlContent,
      'topSellerProducts':
          instance.topSellerProducts?.map((e) => e.toJson()).toList(),
    };

BrandAlphabet _$BrandAlphabetFromJson(Map<String, dynamic> json) =>
    BrandAlphabet(
      count: json['count'] as int?,
      letter: json['letter'] as String?,
    );

Map<String, dynamic> _$BrandAlphabetToJson(BrandAlphabet instance) =>
    <String, dynamic>{
      'letter': instance.letter,
      'count': instance.count,
    };
