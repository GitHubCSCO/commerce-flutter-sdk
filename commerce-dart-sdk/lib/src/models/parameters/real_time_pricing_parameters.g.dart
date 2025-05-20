// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_time_pricing_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RealTimePricingParametersToJson(
    RealTimePricingParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('productPriceParameters',
      instance.productPriceParameters?.map((e) => e.toJson()).toList());
  return val;
}
