import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IBrandService {
  Future<Result<BrandAlphabetResult, ErrorResponse>> getAlphabetAsync();

  Future<Result<GetBrandsResult, ErrorResponse>> getBrands(
      BrandsQueryParameters parameters);

  Future<Result<Brand, ErrorResponse>> getBrand(String brandId,
      {BrandQueryParameters? brandParameters});

  Future<Result<GetBrandCategoriesResult, ErrorResponse>> getBrandCategories(
      BrandCategoriesQueryParameter parameters);

  Future<Result<GetBrandSubCategoriesResult, ErrorResponse>>
      getBrandCategorySubCategories(BrandCategoriesQueryParameter parameters);

  Future<Result<GetBrandProductLinesResult, ErrorResponse>>
      getBrandProductLines(ProductLinesQueryParameters parameters);
}
