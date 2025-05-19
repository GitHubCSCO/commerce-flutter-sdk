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
    WishListQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  writeNotNull(
      'exclude', JsonEncodingMethods.commaSeparatedJson(instance.exclude));
  return val;
}
