// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ship_tos_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetShipTosResult _$GetShipTosResultFromJson(Map<String, dynamic> json) =>
    GetShipTosResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      shipTos: (json['shipTos'] as List<dynamic>?)
          ?.map((e) => ShipTo.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetShipTosResultToJson(GetShipTosResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull('shipTos', instance.shipTos?.map((e) => e.toJson()).toList());
  return val;
}
