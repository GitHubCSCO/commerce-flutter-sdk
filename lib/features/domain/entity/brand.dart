// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandEntity extends Equatable {
  final String? id;
  final String? name;
  final String? manufacturer;
  final String? externalUrl;
  final String? detailPagePath;
  final String? productListPagePage;
  final String? logoSmallImagePath;
  final String? logoLargeImagePath;
  final String? logoAltText;
  final String? featuredImagePath;
  final String? featuredImageAltText;
  final String? htmlContent;
  final List<ProductEntity>? topSellerProducts;

  const BrandEntity({
    this.id,
    this.name,
    this.manufacturer,
    this.externalUrl,
    this.detailPagePath,
    this.productListPagePage,
    this.logoSmallImagePath,
    this.logoLargeImagePath,
    this.logoAltText,
    this.featuredImagePath,
    this.featuredImageAltText,
    this.htmlContent,
    this.topSellerProducts,
  });

  BrandEntity copyWith({
    String? id,
    String? name,
    String? manufacturer,
    String? externalUrl,
    String? detailPagePath,
    String? productListPagePage,
    String? logoSmallImagePath,
    String? logoLargeImagePath,
    String? logoAltText,
    String? featuredImagePath,
    String? featuredImageAltText,
    String? htmlContent,
    List<ProductEntity>? topSellerProducts,
  }) {
    return BrandEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      externalUrl: externalUrl ?? this.externalUrl,
      detailPagePath: detailPagePath ?? this.detailPagePath,
      productListPagePage: productListPagePage ?? this.productListPagePage,
      logoSmallImagePath: logoSmallImagePath ?? this.logoSmallImagePath,
      logoLargeImagePath: logoLargeImagePath ?? this.logoLargeImagePath,
      logoAltText: logoAltText ?? this.logoAltText,
      featuredImagePath: featuredImagePath ?? this.featuredImagePath,
      featuredImageAltText: featuredImageAltText ?? this.featuredImageAltText,
      htmlContent: htmlContent ?? this.htmlContent,
      topSellerProducts: topSellerProducts ?? this.topSellerProducts,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        manufacturer,
        externalUrl,
        detailPagePath,
        productListPagePage,
        logoSmallImagePath,
        logoLargeImagePath,
        logoAltText,
        featuredImagePath,
        featuredImageAltText,
        htmlContent,
        topSellerProducts,
      ];

  factory BrandEntity.fromJson(Map<String, dynamic> json) =>
      BrandEntityMapper.toEntity(Brand.fromJson(json));

  Map<String, dynamic> toJson() => BrandEntityMapper.toModel(this).toJson();
}

class BrandAlphabetEntity extends Equatable {
  final String? letter;
  final int? count;

  const BrandAlphabetEntity({this.letter, this.count});

  @override
  List<Object?> get props => [
        letter,
        count,
      ];

  BrandAlphabetEntity copyWith({
    String? letter,
    int? count,
  }) {
    return BrandAlphabetEntity(
      letter: letter ?? this.letter,
      count: count ?? this.count,
    );
  }
}
