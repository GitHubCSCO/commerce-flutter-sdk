import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'variant_children_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class VariantChildrenQueryParameters extends BaseQueryParameters {
  String? expand;
  String? includeAttributes;
  String? pageToken;

  VariantChildrenQueryParameters({
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
          _$VariantChildrenQueryParametersToJson(this));
}
