import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IProductService {
  Future<Result<GetProductCollectionResult, ErrorResponse>> getProducts(
      ProductsQueryParameters parameters);

  Future<Result<GetProductCollectionResult, ErrorResponse>> getProductsNoCache(
      ProductsQueryParameters parameters);

  Future<bool> hasProductCache(ProductsQueryParameters parameters);

  Future<Result<GetProductResult, ErrorResponse>> getProduct(String productId,
      {ProductQueryParameters? parameters});

  Future<Result<GetProductCollectionResult, ErrorResponse>>
      getProductCrossSells(String productId);

  Future<Result<ProductPrice, ErrorResponse>> getProductPrice(
      String productId, ProductPriceQueryParameter parameters);
}
