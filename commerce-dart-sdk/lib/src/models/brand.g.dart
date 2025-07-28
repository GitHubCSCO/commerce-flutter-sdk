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
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.manufacturer case final value?) 'manufacturer': value,
      if (instance.externalUrl case final value?) 'externalUrl': value,
      if (instance.detailPagePath case final value?) 'detailPagePath': value,
      if (instance.productListPagePage case final value?)
        'productListPagePage': value,
      if (instance.logoSmallImagePath case final value?)
        'logoSmallImagePath': value,
      if (instance.logoLargeImagePath case final value?)
        'logoLargeImagePath': value,
      if (instance.logoAltText case final value?) 'logoAltText': value,
      if (instance.featuredImagePath case final value?)
        'featuredImagePath': value,
      if (instance.featuredImageAltText case final value?)
        'featuredImageAltText': value,
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.topSellerProducts?.map((e) => e.toJson()).toList()
          case final value?)
        'topSellerProducts': value,
    };

BrandAlphabet _$BrandAlphabetFromJson(Map<String, dynamic> json) =>
    BrandAlphabet(
      count: (json['count'] as num?)?.toInt(),
      letter: json['letter'] as String?,
    );

Map<String, dynamic> _$BrandAlphabetToJson(BrandAlphabet instance) =>
    <String, dynamic>{
      if (instance.letter case final value?) 'letter': value,
      if (instance.count case final value?) 'count': value,
    };
