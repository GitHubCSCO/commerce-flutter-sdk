import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandCategoryScreenParameters {
  final Brand brand;
  final BrandCategory? brandCategory;
  final GetBrandSubCategoriesResult? brandSubCategoriesResult;

  BrandCategoryScreenParameters({
    required this.brand,
    required this.brandCategory,
    required this.brandSubCategoriesResult,
  });

  BrandCategoryScreenParameters copyWith({
    Brand? brand,
    BrandCategory? brandCategory,
    GetBrandSubCategoriesResult? brandSubCategoriesResult,
  }) {
    return BrandCategoryScreenParameters(
      brand: brand ?? this.brand,
      brandCategory: brandCategory ?? this.brandCategory,
      brandSubCategoriesResult:
          brandSubCategoriesResult ?? this.brandSubCategoriesResult,
    );
  }

  factory BrandCategoryScreenParameters.fromJson(Map<String, dynamic> json) {
    return BrandCategoryScreenParameters(
      brand: Brand.fromJson(json['brand']),
      brandCategory: json['brandCategory'] != null
          ? BrandCategory.fromJson(json['brandCategory'])
          : null,
      brandSubCategoriesResult: json['brandSubCategoriesResult'] != null
          ? GetBrandSubCategoriesResult.fromJson(
              json['brandSubCategoriesResult'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand.toJson(),
      'brandCategory': brandCategory?.toJson(),
      'brandSubCategoriesResult': brandSubCategoriesResult?.toJson(),
    };
  }
}
