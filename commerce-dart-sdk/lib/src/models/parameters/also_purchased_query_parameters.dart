import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'also_purchased_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class AlsoPurchasedQueryParameters extends BaseQueryParameters {
  String? expand;
  String? includeAttributes;
  String? pageToken;

  AlsoPurchasedQueryParameters({
    this.expand,
    this.includeAttributes,
    this.pageToken,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$AlsoPurchasedQueryParametersToJson(this));
}
