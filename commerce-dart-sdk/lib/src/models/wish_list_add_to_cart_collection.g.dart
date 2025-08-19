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
        WishListAddToCartCollection instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.wishListLines?.map((e) => e.toJson()).toList()
          case final value?)
        'wishListLines': value,
    };
