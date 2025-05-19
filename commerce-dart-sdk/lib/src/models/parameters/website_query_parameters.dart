import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'website_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class WebsiteQueryParameters extends BaseQueryParameters {
  /// Available options when using Expand
  /// Options: countries, states, languages, currencies
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]

  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;
  WebsiteQueryParameters({
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$WebsiteQueryParametersToJson(this));
}
