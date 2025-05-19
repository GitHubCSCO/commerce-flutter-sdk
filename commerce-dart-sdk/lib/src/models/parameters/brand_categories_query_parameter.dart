import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'brand_categories_query_parameter.g.dart';

@JsonSerializable(createFactory: false)
class BrandCategoriesQueryParameter extends BaseQueryParameters {
  String? brandId;

  String? categoryId;

  String? productListPagePath;

  int maximumDepth;

  BrandCategoriesQueryParameter({
    this.brandId,
    this.categoryId,
    this.productListPagePath,
    this.maximumDepth = 2,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$BrandCategoriesQueryParameterToJson(this));
}
