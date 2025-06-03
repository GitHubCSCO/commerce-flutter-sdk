// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishListQueryParameters _$WishListQueryParametersFromJson(
        Map<String, dynamic> json) =>
    WishListQueryParameters(
      expand:
          (json['expand'] as List<dynamic>?)?.map((e) => e as String).toList(),
      exclude:
          (json['exclude'] as List<dynamic>?)?.map((e) => e as String).toList(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$WishListQueryParametersToJson(
        WishListQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.exclude)
          case final value?)
        'exclude': value,
    };
