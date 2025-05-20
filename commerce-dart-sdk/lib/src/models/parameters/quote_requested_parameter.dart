import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quote_requested_parameter.g.dart';

@JsonSerializable()
class QuoteRequestedParameter {
  String? quoteId;

  String? status;

  DateTime? expirationDate;

  QuoteRequestedParameter({
    this.quoteId,
    this.status,
    this.expirationDate,
  });

  factory QuoteRequestedParameter.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestedParameterFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteRequestedParameterToJson(this);
}
