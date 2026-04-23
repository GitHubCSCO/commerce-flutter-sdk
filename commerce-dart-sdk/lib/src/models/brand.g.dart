// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      detailPagePath: json['detailPagePath'] as String?,
      id: json['id'] as String?,
      logoImageAltText: json['logoImageAltText'] as String?,
      logoLargeImagePath: json['logoLargeImagePath'] as String?,
      logoSmallImagePath: json['logoSmallImagePath'] as String?,
      name: json['name'] as String?,
      urlSegment: json['urlSegment'] as String?,
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
      if (instance.urlSegment case final value?) 'urlSegment': value,
      if (instance.logoSmallImagePath case final value?)
        'logoSmallImagePath': value,
      if (instance.logoLargeImagePath case final value?)
        'logoLargeImagePath': value,
      if (instance.logoImageAltText case final value?)
        'logoImageAltText': value,
      if (instance.detailPagePath case final value?) 'detailPagePath': value,
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
