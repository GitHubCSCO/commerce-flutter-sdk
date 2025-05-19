import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'job_quote_update_parameter.g.dart';

@JsonSerializable(createFactory: false)
class JobQuoteLineUpdate {
  String? id;
  num? qtyOrdered;

  JobQuoteLineUpdate({
    this.id,
    this.qtyOrdered,
  });

  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$JobQuoteLineUpdateToJson(this));
}

@JsonSerializable(createFactory: false)
class JobQuoteUpdateParameter {
  String? jobQuoteId;
  List<JobQuoteLineUpdate>? jobQuoteLineCollection;

  JobQuoteUpdateParameter({
    this.jobQuoteId,
    this.jobQuoteLineCollection,
  });

  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$JobQuoteUpdateParameterToJson(this));
}
