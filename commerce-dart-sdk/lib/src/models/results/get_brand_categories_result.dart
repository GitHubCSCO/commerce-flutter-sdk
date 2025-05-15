import '../models.dart';

part 'get_brand_categories_result.g.dart';

@JsonSerializable()
class GetBrandCategoriesResult extends BaseModel {
  Pagination? pagination;
  List<BrandCategory>? brandCategories;

  GetBrandCategoriesResult({
    this.pagination,
    this.brandCategories,
  });

  factory GetBrandCategoriesResult.fromJson(Map<String, dynamic> json) =>
      _$GetBrandCategoriesResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetBrandCategoriesResultToJson(this);
}
