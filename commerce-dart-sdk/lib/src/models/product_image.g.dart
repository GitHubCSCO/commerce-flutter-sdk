// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) => ProductImage(
      altText: json['altText'] as String?,
      id: json['id'] as String?,
      imageType: json['imageType'] as String?,
      largeImagePath: json['largeImagePath'] as String?,
      mediumImagePath: json['mediumImagePath'] as String?,
      name: json['name'] as String?,
      smallImagePath: json['smallImagePath'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.name case final value?) 'name': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.mediumImagePath case final value?) 'mediumImagePath': value,
      if (instance.largeImagePath case final value?) 'largeImagePath': value,
      if (instance.altText case final value?) 'altText': value,
      if (instance.imageType case final value?) 'imageType': value,
    };
