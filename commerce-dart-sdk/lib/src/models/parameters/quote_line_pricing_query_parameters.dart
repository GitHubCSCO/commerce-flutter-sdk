import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quote_line_pricing_query_parameters.g.dart';

@JsonSerializable()
class QuoteLinePricingQueryParameters {
  String? id;

  PricingRfq? pricingRfq;

  QuoteLinePricingQueryParameters({
    this.id,
    this.pricingRfq,
  });

  factory QuoteLinePricingQueryParameters.fromJson(Map<String, dynamic> json) =>
      _$QuoteLinePricingQueryParametersFromJson(json);

  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$QuoteLinePricingQueryParametersToJson(this));
}
