import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/exceptions/brand_exceptions.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_details_screen.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandUseCase extends BaseUseCase {
  static const int numberOfInitiallyVisibleCategories = 10;
  static const int numberOfInitiallyVisibleProductLines = 10;

  Future<Result<GetBrandSubCategoriesResult, ErrorResponse>>
      getBrandCategorySubCategories(
          BrandCategoriesQueryParameter brandCategoriesQueryParameter) {
    return commerceAPIServiceProvider
        .getBrandService()
        .getBrandCategorySubCategories(brandCategoriesQueryParameter);
  }

  Future<Result<BrandAlphabetResult, ErrorResponse>> getAlphabet() async {
    return commerceAPIServiceProvider.getBrandService().getAlphabetAsync();
  }

  Future<Result<GetBrandsResult, ErrorResponse>> getBrands(String name) async {
    final parameters = BrandsQueryParameters(startsWith: name);

    final result = await commerceAPIServiceProvider
        .getBrandService()
        .getBrands(parameters);
    return result;
  }

  Future<Result<List<AutocompleteBrand>, ErrorResponse>> getAutoCompleteBrands(
      String searchQuery) async {
    final result = await commerceAPIServiceProvider
        .getAutocompleteService()
        .getAutocompleteBrands(searchQuery);
    return result;
  }

  Future<Result<Brand, ErrorResponse>> getBrand(String id) async {
    final result =
        await commerceAPIServiceProvider.getBrandService().getBrand(id);
    return result;
  }

  Future<dynamic> _getBrandCategories(Brand brand) async {
    var startingCategoryId = await coreServiceProvider
        .getAppConfigurationService()
        .startingCategoryForBrowsing();
    if (startingCategoryId.isNullOrEmpty ||
        startingCategoryId == CoreConstants.emptyGuidString) {
      final brandCategoriesResultResponse =
          await commerceAPIServiceProvider.getBrandService().getBrandCategories(
                BrandCategoriesQueryParameter(
                  brandId: brand.id,
                  page: 1,
                  pageSize: numberOfInitiallyVisibleCategories,
                  maximumDepth: 2,
                ),
              );
      return brandCategoriesResultResponse
          .getResultSuccessValue()
          ?.brandCategories;
    } else {
      final brandCategoriesResultResponse = await commerceAPIServiceProvider
          .getBrandService()
          .getBrandCategorySubCategories(
            BrandCategoriesQueryParameter(
              brandId: brand.id,
              categoryId: startingCategoryId,
              page: 1,
              pageSize: numberOfInitiallyVisibleCategories,
              maximumDepth: 2,
            ),
          );
      final brandCategoriesResult =
          brandCategoriesResultResponse.getResultSuccessValue();
      final brandCategories = brandCategoriesResult?.subCategories
          ?.map((c) => BrandCategory.mapCategoryToBrandCategory(c))
          .toList();

      if (brandCategories != null && brandCategories.isNotEmpty) {
        for (var brandCategory in brandCategories) {
          var brandSubCategoriesResultResponse =
              await commerceAPIServiceProvider
                  .getBrandService()
                  .getBrandCategorySubCategories(
                    BrandCategoriesQueryParameter(
                      brandId: brandCategory?.brandId,
                      categoryId: brandCategory?.categoryId,
                      page: 1,
                      pageSize: numberOfInitiallyVisibleCategories,
                      maximumDepth: 2,
                    ),
                  );

          var brandSubCategoriesResult =
              brandSubCategoriesResultResponse.getResultSuccessValue();
          brandCategory?.subCategories = brandSubCategoriesResult?.subCategories
              ?.map((c) => BrandCategory.mapCategoryToBrandCategory(c))
              .toList();
        }
      }
      return brandCategories;
    }
  }

  Future<List<BrandProductLine>?> _getBrandProductLines(Brand brand) async {
    final productLinesQueryParameters = ProductLinesQueryParameters(
      brandId: brand.id,
      page: 1,
      pageSize: numberOfInitiallyVisibleProductLines,
    );
    final brandProductLinesResultResponse = await commerceAPIServiceProvider
        .getBrandService()
        .getBrandProductLines(productLinesQueryParameters);
    final brandProductLines =
        brandProductLinesResultResponse.getResultSuccessValue();

    return brandProductLines?.productLines;
  }

  Future<Result<BrandDetailsEntity, ErrorResponse>> getBrandDetails(
      Brand brand) async {
    final detailsEntity = BrandDetailsEntity();

    final brandQueryParameters = BrandQueryParameters(
      expand: ['htmlcontent', 'topsellerproducts'],
    );

    final brandInfosResponse = await commerceAPIServiceProvider
        .getBrandService()
        .getBrand(brand.id ?? '', brandParameters: brandQueryParameters);
    switch (brandInfosResponse) {
      case Success(value: final value):
        {
          if (value != null) {
            final brandEntity = BrandEntityMapper.toEntity(value);
            detailsEntity.brandEntity = brandEntity;

            detailsEntity.brandCategories = await _getBrandCategories(brand);
            detailsEntity.brandProductLines =
                await _getBrandProductLines(brand);

            return Success(detailsEntity);
          } else {
            return Failure(ErrorResponse(
                message: LocalizationConstants.noBrandDetailsFound.localized(),
                exception: BrandDetailsException()));
          }
        }
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }
}
