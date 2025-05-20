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

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('name', instance.name);
  writeNotNull('smallImagePath', instance.smallImagePath);
  writeNotNull('mediumImagePath', instance.mediumImagePath);
  writeNotNull('largeImagePath', instance.largeImagePath);
  writeNotNull('altText', instance.altText);
  writeNotNull('imageType', instance.imageType);
  return val;
}
