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
        WishListLineCollectionModel instance) =>
    <String, dynamic>{
      if (instance.wishListLines?.map((e) => e.toJson()).toList()
          case final value?)
        'wishListLines': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
