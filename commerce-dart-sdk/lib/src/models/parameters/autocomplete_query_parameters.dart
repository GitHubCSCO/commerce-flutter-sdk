import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'autocomplete_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class AutocompleteQueryParameters extends BaseQueryParameters {
  String? query;
  bool? categoryEnabled;
  bool? contentEnabled;
  bool? productEnabled;
  bool? brandEnabled;
  bool? searchOnTyping;
  bool? relevancy;
  bool? spireContent;

  AutocompleteQueryParameters({
    this.query,
    this.categoryEnabled,
    this.contentEnabled,
    this.productEnabled,
    this.brandEnabled,
    this.searchOnTyping,
    this.relevancy,
    this.spireContent,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$AutocompleteQueryParametersToJson(this));
}
