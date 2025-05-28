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
    GetDealerCollectionResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull('dealers', instance.dealers?.map((e) => e.toJson()).toList());
  writeNotNull('defaultLatitude', instance.defaultLatitude);
  writeNotNull('defaultLongitude', instance.defaultLongitude);
  writeNotNull('defaultRadius', instance.defaultRadius);
  writeNotNull('distanceUnitOfMeasure', instance.distanceUnitOfMeasure);
  return val;
}
