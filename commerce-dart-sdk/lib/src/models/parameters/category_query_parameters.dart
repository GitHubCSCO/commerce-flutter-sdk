import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'category_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class CategoryQueryParameters extends BaseQueryParameters {
  String? startCategoryId;

  int? maxDepth;

  bool? includeStartCategory;

  CategoryQueryParameters({
    this.startCategoryId,
    this.maxDepth,
    this.includeStartCategory,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$CategoryQueryParametersToJson(this));
}
