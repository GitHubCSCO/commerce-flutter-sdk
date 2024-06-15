import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_details_screen.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandUseCase extends BaseUseCase {

  Future<Result<BrandAlphabetResult, ErrorResponse>> getAlphabet() async {
    final result = await commerceAPIServiceProvider.getBrandService().getAlphabetAsync();
    return result;
  }

  Future<Result<GetBrandsResult, ErrorResponse>> getBrands(String name) async {
    final parameters = BrandsQueryParameters(
      startsWith: name
    );

    final result = await commerceAPIServiceProvider.getBrandService().getBrands(parameters);
    return result;
  }

  Future<BrandDetailsEntity> getBrandDetails(Brand brand) async {
    final detailsEntity = BrandDetailsEntity();

    final brandQueryParameters = BrandQueryParameters(
      expand: ['htmlcontent', 'topsellerproducts'],
    );

    final brandInfosResponse = await commerceAPIServiceProvider.getBrandService().getBrand(brand.id ?? '', brandParameters: brandQueryParameters);
    final brandEntity = BrandEntityMapper().toEntity(brandInfosResponse.getResultSuccessValue());
    detailsEntity.brandEntity = brandEntity;

    final brandCategoriesQueryParameter = BrandCategoriesQueryParameter(
      brandId: brand.id,
      page: 1,
      pageSize: 10,
      maximumDepth: 2
    );
    final brandCategoriesResultResponse = await commerceAPIServiceProvider.getBrandService().getBrandCategories(brandCategoriesQueryParameter);
    final brandCategories = brandCategoriesResultResponse.getResultSuccessValue();
    detailsEntity.brandCategories = brandCategories?.brandCategories;

    final productLinesQueryParameters = ProductLinesQueryParameters(
      brandId: brand.id,
      page: 1,
      pageSize: 10,
    );
    final brandProductLinesResultResponse = await commerceAPIServiceProvider.getBrandService().getBrandProductLines(productLinesQueryParameters);
    final brandProductLines = brandProductLinesResultResponse.getResultSuccessValue();
    detailsEntity.brandProductLines = brandProductLines?.productLines;

    return detailsEntity;
  }

}