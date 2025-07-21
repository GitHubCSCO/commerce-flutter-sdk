// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_wish_list_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CreateWishListQueryParametersToJson(
        CreateWishListQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.wishListObj?.toJson() case final value?)
        'wishListObj': value,
    };
