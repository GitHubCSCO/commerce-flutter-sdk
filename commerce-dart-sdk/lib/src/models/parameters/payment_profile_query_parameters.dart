import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'payment_profile_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class PaymentProfileQueryParameters extends BaseQueryParameters {
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  PaymentProfileQueryParameters({
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$PaymentProfileQueryParametersToJson(this));
}
