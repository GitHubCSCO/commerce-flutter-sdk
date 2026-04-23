import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'related_products_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class RelatedProductsQueryParameters extends BaseQueryParameters {
  String? relationship;
  String? expand;
  String? includeAttributes;
  String? pageToken;

  RelatedProductsQueryParameters({
    this.relationship,
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
          _$RelatedProductsQueryParametersToJson(this));
}
