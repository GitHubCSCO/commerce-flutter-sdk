// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/src/features/domain/mapper/brand_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandEntity extends Equatable {
  final String? id;
  final String? name;
  final String? urlSegment;
  final String? detailPagePath;
  final String? logoSmallImagePath;
  final String? logoLargeImagePath;
  final String? logoAltText;
  final String? logoImageAltText;

  const BrandEntity({
    this.id,
    this.name,
    this.urlSegment,
    this.detailPagePath,
    this.logoSmallImagePath,
    this.logoLargeImagePath,
    this.logoAltText,
    this.logoImageAltText,
  });

  BrandEntity copyWith({
    String? id,
    String? name,
    String? urlSegment,
    String? detailPagePath,
    String? logoSmallImagePath,
    String? logoLargeImagePath,
    String? logoAltText,
    String? logoImageAltText,
  }) {
    return BrandEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      urlSegment: urlSegment ?? this.urlSegment,
      detailPagePath: detailPagePath ?? this.detailPagePath,
      logoSmallImagePath: logoSmallImagePath ?? this.logoSmallImagePath,
      logoLargeImagePath: logoLargeImagePath ?? this.logoLargeImagePath,
      logoAltText: logoAltText ?? this.logoAltText,
      logoImageAltText: logoImageAltText ?? this.logoImageAltText,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        urlSegment,
        detailPagePath,
        logoSmallImagePath,
        logoLargeImagePath,
        logoAltText,
        logoImageAltText,
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
