import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_details_screen.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandUseCase extends BaseUseCase {

  static const int numberOfInitiallyVisibleCategories = 10;
  static const int numberOfInitiallyVisibleProductLines = 10;

  Future<Result<GetBrandSubCategoriesResult, ErrorResponse>> getBrandCategorySubCategories(
    BrandCategoriesQueryParameter brandCategoriesQueryParameter
  ) {
    return commerceAPIServiceProvider
                .getBrandService()
                .getBrandCategorySubCategories(brandCategoriesQueryParameter);
  }

  Future<Result<BrandAlphabetResult, ErrorResponse>> getAlphabet() async {
    return commerceAPIServiceProvider
                .getBrandService()
                .getAlphabetAsync();
  }

  Future<Result<GetBrandsResult, ErrorResponse>> getBrands(String name) async {
    final parameters = BrandsQueryParameters(
      startsWith: name
    );

    final result = await commerceAPIServiceProvider.getBrandService().getBrands(parameters);
    return result;
  }

  Future<Result<List<AutocompleteBrand>, ErrorResponse>> getAutoCompleteBrands(String searchQuery) async {
    final result = await commerceAPIServiceProvider.getAutocompleteService().getAutocompleteBrands(searchQuery);
    return result;
  }

  Future<Result<Brand, ErrorResponse>> getBrand(String id) async {
    final result = await commerceAPIServiceProvider.getBrandService().getBrand(id);
    return result;
  }

  Future<List<BrandCategory>?> _getBrandCategories(Brand brand) async {
    final brandCategoriesQueryParameter = BrandCategoriesQueryParameter(
        brandId: brand.id,
        page: 1,
        pageSize: numberOfInitiallyVisibleCategories,
        maximumDepth: 2);
    final brandCategoriesResultResponse = await commerceAPIServiceProvider
        .getBrandService()
        .getBrandCategories(brandCategoriesQueryParameter);
    final brandCategories =
        brandCategoriesResultResponse.getResultSuccessValue();

    return brandCategories?.brandCategories;
  }

  Future<List<BrandProductLine>?> _getBrandProductLines(Brand brand) async {
      final productLinesQueryParameters = ProductLinesQueryParameters(
        brandId: brand.id,
        page: 1,
        pageSize: numberOfInitiallyVisibleProductLines,
      );
      final brandProductLinesResultResponse = await commerceAPIServiceProvider.getBrandService().getBrandProductLines(productLinesQueryParameters);
      final brandProductLines = brandProductLinesResultResponse.getResultSuccessValue();

      return brandProductLines?.productLines; 
  }

  Future<BrandDetailsEntity> getBrandDetails(Brand brand) async {
    final detailsEntity = BrandDetailsEntity();

    final brandQueryParameters = BrandQueryParameters(
      expand: ['htmlcontent', 'topsellerproducts'],
    );

    final brandInfosResponse = await commerceAPIServiceProvider.getBrandService().getBrand(brand.id ?? '', brandParameters: brandQueryParameters);
    final brandEntity = BrandEntityMapper().toEntity(brandInfosResponse.getResultSuccessValue());
    detailsEntity.brandEntity = brandEntity;

    detailsEntity.brandCategories = await _getBrandCategories(brand);
    detailsEntity.brandProductLines = await _getBrandProductLines(brand);

    return detailsEntity;
  }
}