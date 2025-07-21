// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_tag_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListTagCollectionModel _$WishListTagCollectionModelFromJson(
        Map<String, dynamic> json) =>
    WishListTagCollectionModel(
      wishListTags: (json['wishListTags'] as List<dynamic>?)
          ?.map((e) => WishListTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WishListTagCollectionModelToJson(
        WishListTagCollectionModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.wishListTags?.map((e) => e.toJson()).toList()
          case final value?)
        'wishListTags': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
