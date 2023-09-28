import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

abstract class IProductService {
  Future<ServiceResponse<GetProductCollectionResult>> getProducts(
      ProductsQueryParameters parameters);

  Future<ServiceResponse<GetProductCollectionResult>> getProductsNoCache(
      ProductsQueryParameters parameters);

  Future<bool> hasProductCache(ProductsQueryParameters parameters);

  Future<ServiceResponse<GetProductResult>> getProduct(String productId,
      {ProductsQueryParameters? parameters});

  Future<ServiceResponse<GetProductCollectionResult>> getProductCrossSells(
      String productId);

  Future<ServiceResponse<ProductPrice>> getProductPrice(
      String productId, ProductPriceQueryParameter parameters);
}
