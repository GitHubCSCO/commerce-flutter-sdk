import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductService extends ServiceBase implements IProductService {
  ProductService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<GetProductResult, ErrorResponse>> getProduct(String productId,
      {ProductQueryParameters? parameters}) async {
    var url = Uri.parse('${CommerceAPIConstants.productsUrl}/$productId');
    if (parameters != null) {
      Map<String, dynamic> parametersMap = parameters.toJson();
      url = url.replace(queryParameters: parametersMap);
    }

    String urlString = url.toString();
    final response = await getAsyncNoCache<GetProductResult>(
        urlString, GetProductResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          final productResult = value;
          if (productResult == null) {
            return response;
          }
          return Success(productResult);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetProductCollectionResult, ErrorResponse>> getProducts(
      ProductsQueryParameters parameters) async {
    var url = Uri.parse(CommerceAPIConstants.productsUrl);
    final parametersMap = parameters.toJson();
    url = url.replace(queryParameters: parametersMap);
    final urlString = url.toString();
    final response = await getAsyncNoCache<GetProductCollectionResult>(
        urlString, GetProductCollectionResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          final productsResult = value;
          if (productsResult == null || productsResult.products == null) {
            return response;
          }
          return Success(productsResult);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetProductCollectionResult, ErrorResponse>> getProductsNoCache(
      ProductsQueryParameters parameters) async {
    Map<String, dynamic> parametersMap = parameters.toJson();

    String url = Uri.parse(CommerceAPIConstants.productsUrl)
        .replace(queryParameters: parametersMap)
        .toString();

    final response = await getAsyncNoCache<GetProductCollectionResult>(
        url, GetProductCollectionResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          final productsResult = value;
          if (productsResult == null || productsResult.products == null) {
            return response;
          }
          return Success(productsResult);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<bool> hasProductCache(ProductsQueryParameters parameters) async {
    var url = Uri.parse(CommerceAPIConstants.productsUrl);
    url = url.replace(queryParameters: parameters.toJson());

    final sessionStateKey = await clientService.sessionStateKey;
    final key =
        (clientService.host ?? '') + url.toString() + (sessionStateKey ?? '');

    bool result = await cacheService.hasOnlineCache(key);
    return result;
  }

  @override
  Future<Result<GetProductCollectionResult, ErrorResponse>> getVariantChildren(
      String productId) async {
    final urlString =
        '${CommerceAPIConstants.productsUrl}/$productId/variantchildren';
    final response = await getAsyncNoCache<GetProductCollectionResult>(
        urlString, GetProductCollectionResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          if (value == null || value.products == null) {
            return response;
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetProductCollectionResult, ErrorResponse>> getRelatedProducts(
      String productId) async {
    final urlString =
        '${CommerceAPIConstants.productsUrl}/$productId/relatedproducts';
    final response = await getAsyncNoCache<GetProductCollectionResult>(
        urlString, GetProductCollectionResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          if (value == null || value.products == null) {
            return response;
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetProductCollectionResult, ErrorResponse>> getAlsoPurchased(
      String productId) async {
    final urlString =
        '${CommerceAPIConstants.productsUrl}/$productId/alsopurchased';
    final response = await getAsyncNoCache<GetProductCollectionResult>(
        urlString, GetProductCollectionResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          if (value == null || value.products == null) {
            return response;
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }
}
