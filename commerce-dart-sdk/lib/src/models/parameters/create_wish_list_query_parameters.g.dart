// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_wish_list_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CreateWishListQueryParametersToJson(
    CreateWishListQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('wishListObj', instance.wishListObj?.toJson());
  return val;
}
