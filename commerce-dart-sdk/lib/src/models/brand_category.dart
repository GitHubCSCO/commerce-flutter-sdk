import 'models.dart';

part 'brand_category.g.dart';

@JsonSerializable()
class BrandCategory extends BaseModel {
  String? brandId;

  String? categoryId;

  String? contentManagerId;

  String? categoryName;

  String? categoryShortDescription;

  String? featuredImagePath;

  String? featuredImageAltText;

  String? productListPagePath;

  String? htmlContent;

  List<BrandCategory?>? subCategories;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isLoading;

  BrandCategory({
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
    this.isLoading,
  });

  static BrandCategory? mapCategoryToBrandCategory(
    GetBrandSubCategoriesResult brandCategoryResult,
  ) {
    BrandCategory brandCategory = BrandCategory(
      brandId: brandCategoryResult.brandId,
      categoryId: brandCategoryResult.categoryId,
      categoryName: brandCategoryResult.categoryName,
      categoryShortDescription: brandCategoryResult.categoryShortDescription,
      featuredImagePath: brandCategoryResult.featuredImagePath,
      featuredImageAltText: brandCategoryResult.featuredImageAltText,
      productListPagePath: brandCategoryResult.productListPagePath,
      htmlContent: brandCategoryResult.htmlContent,
    );

    List<BrandCategory?> brandSubCategories = [];

    if (brandCategoryResult.subCategories != null) {
      for (GetBrandSubCategoriesResult subCategory
          in brandCategoryResult.subCategories!) {
        BrandCategory? brandSubCategory =
            mapCategoryToBrandCategory(subCategory);

        if (brandSubCategory != null) {
          brandSubCategories.add(brandSubCategory);
        }
      }
    }

    brandCategory.subCategories = brandSubCategories;

    return brandCategory;
  }

  factory BrandCategory.fromJson(Map<String, dynamic> json) =>
      _$BrandCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BrandCategoryToJson(this);
}
