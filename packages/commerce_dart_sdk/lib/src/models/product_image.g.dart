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
      sortOrder: json['sortOrder'] as int?,
    );

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortOrder': instance.sortOrder,
      'name': instance.name,
      'smallImagePath': instance.smallImagePath,
      'mediumImagePath': instance.mediumImagePath,
      'largeImagePath': instance.largeImagePath,
      'altText': instance.altText,
      'imageType': instance.imageType,
    };
