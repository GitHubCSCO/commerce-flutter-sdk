import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandCategoryUseCase extends BaseUseCase {
  Future<Result<GetBrandCategoriesResult, ErrorResponse>> getBrandCategories(
      BrandCategoriesQueryParameter brandCategoriesQueryParameter) {
    return commerceAPIServiceProvider
        .getBrandService()
        .getBrandCategories(brandCategoriesQueryParameter);
  }

  Future<Result<GetBrandSubCategoriesResult, ErrorResponse>>
      getBrandCategorySubCategories(
          BrandCategoriesQueryParameter brandCategoriesQueryParameter) {
    return commerceAPIServiceProvider
        .getBrandService()
        .getBrandCategorySubCategories(brandCategoriesQueryParameter);
  }
}
