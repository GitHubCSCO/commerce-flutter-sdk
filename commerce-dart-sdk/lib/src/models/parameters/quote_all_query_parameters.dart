import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quote_all_query_parameters.g.dart';

@JsonSerializable()
class QuoteAllQueryParameters {
  String? calculationMethod;

  int? percent;

  String? quoteId;

  QuoteAllQueryParameters({
    this.calculationMethod,
    this.percent,
    this.quoteId,
  });

  factory QuoteAllQueryParameters.fromJson(Map<String, dynamic> json) =>
      _$QuoteAllQueryParametersFromJson(json);

  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$QuoteAllQueryParametersToJson(this));
}
