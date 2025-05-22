import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductService extends ServiceBase implements IProductService {
  ProductService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  void fixProduct(Product product) {
    product.pricing ??= ProductPrice();
    product.availability ??= Availability();
  }

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
          if (productResult.product != null) {
            fixProduct(productResult.product!);
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
  Future<Result<GetProductCollectionResult, ErrorResponse>>
      getProductCrossSells(String productId) async {
    final urlString =
        '${CommerceAPIConstants.productsUrl}/$productId/crosssells';
    var response = await getAsyncNoCache<GetProductCollectionResult>(
        urlString, GetProductCollectionResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          final productsResult = value;
          if (productsResult == null || productsResult.products == null) {
            return response;
          }

          for (Product product in productsResult.products!) {
            fixProduct(product);
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
  Future<Result<ProductPrice, ErrorResponse>> getProductPrice(
      String productId, ProductPriceQueryParameter parameters) async {
    var url = Uri.parse('${CommerceAPIConstants.productsUrl}/$productId/price');
    if (parameters.configuration != null) {
      if (parameters.configuration!.isNotEmpty) {
        final Map<String, dynamic> parametersMap = parameters.toJson();

        url = url.replace(queryParameters: parametersMap);
      }
    }

    final urlString = url.toString();
    final response =
        await getAsyncNoCache<ProductPrice>(urlString, ProductPrice.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          final productPrice = value;
          if (productPrice == null) {
            return response;
          }

          return Success(productPrice);
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @Deprecated('Caution: Will be removed in a future release.')
  @override
  Future<Result<GetProductCollectionResult, ErrorResponse>> getProducts(
      ProductsQueryParameters parameters) async {
    var url = Uri.parse('${CommerceAPIConstants.productsUrl}/');
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

          for (Product product in productsResult.products!) {
            fixProduct(product);
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

          for (Product product in productsResult.products!) {
            fixProduct(product);
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
}
