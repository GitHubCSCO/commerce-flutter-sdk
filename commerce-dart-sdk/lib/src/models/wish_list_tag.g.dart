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

Map<String, dynamic> _$WishListTagModelToJson(WishListTagModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('tag', instance.tag);
  return val;
}
