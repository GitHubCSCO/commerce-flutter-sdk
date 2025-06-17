// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListCollectionModel _$WishListCollectionModelFromJson(
        Map<String, dynamic> json) =>
    WishListCollectionModel(
      wishListCollection: (json['wishListCollection'] as List<dynamic>?)
          ?.map((e) => WishList.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WishListCollectionModelToJson(
        WishListCollectionModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.wishListCollection?.map((e) => e.toJson()).toList()
          case final value?)
        'wishListCollection': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
