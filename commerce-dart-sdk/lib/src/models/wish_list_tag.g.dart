// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListTagModel _$WishListTagModelFromJson(Map<String, dynamic> json) =>
    WishListTagModel(
      id: json['id'] as String?,
      tag: json['tag'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WishListTagModelToJson(WishListTagModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.tag case final value?) 'tag': value,
    };
