// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_line_pricing_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteLinePricingQueryParameters _$QuoteLinePricingQueryParametersFromJson(
        Map<String, dynamic> json) =>
    QuoteLinePricingQueryParameters(
      id: json['id'] as String?,
      pricingRfq: json['pricingRfq'] == null
          ? null
          : PricingRfq.fromJson(json['pricingRfq'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuoteLinePricingQueryParametersToJson(
    QuoteLinePricingQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('pricingRfq', instance.pricingRfq?.toJson());
  return val;
}
