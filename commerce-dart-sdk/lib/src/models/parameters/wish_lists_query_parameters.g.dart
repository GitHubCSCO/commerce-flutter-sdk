// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_lists_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListsQueryParameters _$WishListsQueryParametersFromJson(
        Map<String, dynamic> json) =>
    WishListsQueryParameters(
      query: json['query'] as String?,
      expand:
          (json['expand'] as List<dynamic>?)?.map((e) => e as String).toList(),
      wishListLinesSort: json['wishListLinesSort'] as String?,
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$WishListsQueryParametersToJson(
        WishListsQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.query case final value?) 'query': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
      if (instance.wishListLinesSort case final value?)
        'wishListLinesSort': value,
    };
