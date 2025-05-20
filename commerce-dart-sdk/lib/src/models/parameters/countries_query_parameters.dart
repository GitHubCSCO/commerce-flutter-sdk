import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'countries_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class CountriesQueryParameters extends BaseQueryParameters {
  /// Here are parameters to be passed in the Expand List.
  /// Options: states
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;
  CountriesQueryParameters({
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$CountriesQueryParametersToJson(this));
}
