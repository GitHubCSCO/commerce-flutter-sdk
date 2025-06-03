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

Map<String, dynamic> _$GetShipTosResultToJson(GetShipTosResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.shipTos?.map((e) => e.toJson()).toList() case final value?)
        'shipTos': value,
    };
