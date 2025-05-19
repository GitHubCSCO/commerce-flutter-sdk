import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'requeste_a_quote_parameters.g.dart';

@JsonSerializable()
class SalesRepRequesteAQuoteParameters extends RequesteAQuoteParameters {
  String? userId;

  SalesRepRequesteAQuoteParameters({
    this.userId,
    super.isJobQuote,
    super.jobName,
    super.note,
    super.quoteId,
  });

  factory SalesRepRequesteAQuoteParameters.fromJson(
          Map<String, dynamic> json) =>
      _$SalesRepRequesteAQuoteParametersFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$SalesRepRequesteAQuoteParametersToJson(this));
}

@JsonSerializable()
class RequesteAQuoteParameters {
  String? quoteId;

  String? jobName;

  String? note;

  bool? isJobQuote;

  RequesteAQuoteParameters({
    this.quoteId,
    this.jobName,
    this.note,
    this.isJobQuote,
  });

  factory RequesteAQuoteParameters.fromJson(Map<String, dynamic> json) =>
      _$RequesteAQuoteParametersFromJson(json);

  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$RequesteAQuoteParametersToJson(this));
}
