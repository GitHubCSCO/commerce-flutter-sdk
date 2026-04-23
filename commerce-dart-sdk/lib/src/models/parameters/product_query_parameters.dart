import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class ProductQueryParameters extends BaseQueryParameters {
  String? productId;

  String? categoryId;

  bool? addToRecentlyViewed;

  bool? applyPersonalization;

  String? includeAttributes;

  String? expand;

  ProductQueryParameters({
    this.productId,
    this.categoryId,
    this.addToRecentlyViewed,
    this.applyPersonalization,
    this.includeAttributes,
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ProductQueryParametersToJson(this));
}
