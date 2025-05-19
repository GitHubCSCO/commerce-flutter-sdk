import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'autocomplete_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class AutocompleteQueryParameters extends BaseQueryParameters {
  String? query;
  bool? categoryEnabled;
  bool? contentEnabled;
  bool? productEnabled;
  bool? brandEnabled;

  AutocompleteQueryParameters({
    this.query,
    this.categoryEnabled,
    this.contentEnabled,
    this.productEnabled,
    this.brandEnabled,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$AutocompleteQueryParametersToJson(this));
}
