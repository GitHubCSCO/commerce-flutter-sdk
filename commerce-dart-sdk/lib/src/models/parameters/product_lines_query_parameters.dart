import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_lines_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class ProductLinesQueryParameters extends BaseQueryParameters {
  String? brandId;

  ProductLinesQueryParameters({
    this.brandId,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ProductLinesQueryParametersToJson(this));
}
