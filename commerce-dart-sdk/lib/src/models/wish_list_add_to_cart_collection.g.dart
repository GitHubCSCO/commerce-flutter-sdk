// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_add_to_cart_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListAddToCartCollection _$WishListAddToCartCollectionFromJson(
        Map<String, dynamic> json) =>
    WishListAddToCartCollection(
      wishListLines: (json['wishListLines'] as List<dynamic>?)
          ?.map((e) => AddCartLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WishListAddToCartCollectionToJson(
    WishListAddToCartCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'wishListLines', instance.wishListLines?.map((e) => e.toJson()).toList());
  return val;
}
