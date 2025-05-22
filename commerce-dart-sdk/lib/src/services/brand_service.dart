import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandService extends ServiceBase implements IBrandService {
  BrandService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<BrandAlphabetResult, ErrorResponse>> getAlphabetAsync() async {
    return await getAsyncNoCache(
      CommerceAPIConstants.brandAlphabetUrl,
      BrandAlphabetResult.fromJson,
    );
  }

  @override
  Future<Result<Brand, ErrorResponse>> getBrand(
    String brandId, {
    BrandQueryParameters? brandParameters,
  }) async {
    if (brandId.isEmpty) {
      return Failure(ErrorResponse(message: 'Brand Id cannot be empty'));
    }

    var url = Uri.parse('${CommerceAPIConstants.brandUrl}/$brandId');
    if (brandParameters != null) {
      url = url.replace(queryParameters: brandParameters.toJson());
    }

    return await getAsyncNoCache<Brand>(
      url.toString(),
      Brand.fromJson,
    );
  }

  @override
  Future<Result<GetBrandCategoriesResult, ErrorResponse>> getBrandCategories(
    BrandCategoriesQueryParameter parameters,
  ) async {
    var url = Uri.parse(
      CommerceAPIConstants.brandCategoriesUrlFormat.replaceAll(
        '{0}',
        parameters.brandId ?? '',
      ),
    );

    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<GetBrandCategoriesResult>(
      url.toString(),
      GetBrandCategoriesResult.fromJson,
    );
  }

  @override
  Future<Result<GetBrandSubCategoriesResult, ErrorResponse>>
      getBrandCategorySubCategories(
    BrandCategoriesQueryParameter parameters,
  ) async {
    var url = Uri.parse(
      CommerceAPIConstants.brandSubCategoriesUrlFormat
          .replaceAll('{0}', parameters.brandId ?? '')
          .replaceAll('{1}', parameters.categoryId ?? ''),
    );

    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<GetBrandSubCategoriesResult>(
      url.toString(),
      GetBrandSubCategoriesResult.fromJson,
    );
  }

  @override
  Future<Result<GetBrandProductLinesResult, ErrorResponse>>
      getBrandProductLines(
    ProductLinesQueryParameters parameters,
  ) async {
    var url = Uri.parse(
      CommerceAPIConstants.brandProductLinesUrlFormat.replaceAll(
        '{0}',
        parameters.brandId ?? '',
      ),
    );

    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<GetBrandProductLinesResult>(
      url.toString(),
      GetBrandProductLinesResult.fromJson,
    );
  }

  @override
  Future<Result<GetBrandsResult, ErrorResponse>> getBrands(
    BrandsQueryParameters parameters,
  ) async {
    var url = Uri.parse(CommerceAPIConstants.brandUrl);
    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<GetBrandsResult>(
      url.toString(),
      GetBrandsResult.fromJson,
    );
  }
}
