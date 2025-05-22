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
    WishListsQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('query', instance.query);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  writeNotNull('wishListLinesSort', instance.wishListLinesSort);
  return val;
}
