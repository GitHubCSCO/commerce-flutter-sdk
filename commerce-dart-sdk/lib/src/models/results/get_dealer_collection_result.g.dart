// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_dealer_collection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDealerCollectionResult _$GetDealerCollectionResultFromJson(
        Map<String, dynamic> json) =>
    GetDealerCollectionResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      dealers: (json['dealers'] as List<dynamic>?)
          ?.map((e) => Dealer.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultLatitude: (json['defaultLatitude'] as num?)?.toDouble(),
      defaultLongitude: (json['defaultLongitude'] as num?)?.toDouble(),
      defaultRadius: (json['defaultRadius'] as num?)?.toDouble(),
      distanceUnitOfMeasure: json['distanceUnitOfMeasure'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetDealerCollectionResultToJson(
        GetDealerCollectionResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.dealers?.map((e) => e.toJson()).toList() case final value?)
        'dealers': value,
      if (instance.defaultLatitude case final value?) 'defaultLatitude': value,
      if (instance.defaultLongitude case final value?)
        'defaultLongitude': value,
      if (instance.defaultRadius case final value?) 'defaultRadius': value,
      if (instance.distanceUnitOfMeasure case final value?)
        'distanceUnitOfMeasure': value,
    };
