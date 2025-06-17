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
        GetRealTimePricingResult instance) =>
    <String, dynamic>{
      if (instance.realTimePricingResults?.map((e) => e.toJson()).toList()
          case final value?)
        'realTimePricingResults': value,
    };
