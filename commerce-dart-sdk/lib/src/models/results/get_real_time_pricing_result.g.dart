// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_real_time_pricing_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRealTimePricingResult _$GetRealTimePricingResultFromJson(
        Map<String, dynamic> json) =>
    GetRealTimePricingResult(
      realTimePricingResults: (json['realTimePricingResults'] as List<dynamic>?)
          ?.map((e) => ProductPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetRealTimePricingResultToJson(
    GetRealTimePricingResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('realTimePricingResults',
      instance.realTimePricingResults?.map((e) => e.toJson()).toList());
  return val;
}
