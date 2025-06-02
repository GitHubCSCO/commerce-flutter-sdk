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
    WishListTagCollectionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'wishListTags', instance.wishListTags?.map((e) => e.toJson()).toList());
  writeNotNull('pagination', instance.pagination?.toJson());
  return val;
}
