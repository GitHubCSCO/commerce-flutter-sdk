import '../models.dart';

part 'get_brand_sub_categories_result.g.dart';

@JsonSerializable()
class GetBrandSubCategoriesResult extends BaseModel {
  String? brandId;

  String? categoryId;

  String? contentManagerId;

  String? categoryName;

  String? categoryShortDescription;

  String? featuredImagePath;

  String? featuredImageAltText;

  String? productListPagePath;

  String? htmlContent;

  List<GetBrandSubCategoriesResult>? subCategories;

  Pagination? pagination;

  GetBrandSubCategoriesResult({
    this.brandId,
    this.categoryId,
    this.contentManagerId,
    this.categoryName,
    this.categoryShortDescription,
    this.featuredImagePath,
    this.featuredImageAltText,
    this.productListPagePath,
    this.htmlContent,
    this.subCategories,
    this.pagination,
  });

  factory GetBrandSubCategoriesResult.fromJson(Map<String, dynamic> json) =>
      _$GetBrandSubCategoriesResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetBrandSubCategoriesResultToJson(this);
}
