// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_line_collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListLineCollectionModel _$WishListLineCollectionModelFromJson(
        Map<String, dynamic> json) =>
    WishListLineCollectionModel(
      wishListLines: (json['wishListLines'] as List<dynamic>?)
          ?.map((e) => WishListLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishListLineCollectionModelToJson(
    WishListLineCollectionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'wishListLines', instance.wishListLines?.map((e) => e.toJson()).toList());
  writeNotNull('pagination', instance.pagination?.toJson());
  return val;
}
