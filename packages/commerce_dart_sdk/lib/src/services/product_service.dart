import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:flutter/foundation.dart';

class ProductService extends ServiceBase implements IProductService {
  ProductService({
    required super.clientService,
  });

  void fixProduct(Product product) {
    product.pricing ??= ProductPrice();
    product.availability ??= Availability();
  }

  @override
  Future<ServiceResponse<GetProductResult>> getProduct(String productId,
      {ProductsQueryParameters? parameters}) async {
    try {
      var url = Uri.parse('${CommerceAPIConstants.productsUrl}/$productId');
      if (parameters != null) {
        Map<String, dynamic> parametersMap = await compute(
            (ProductsQueryParameters parameters) => parameters.toJson(),
            parameters);

        url.replace(queryParameters: parametersMap);
      }

      String urlString = url.toString();
      final response = await getAsyncWithCachedResponse<GetProductResult>(
          urlString, GetProductResult.fromJson);

      final productResult = response.model;
      if (productResult == null) return response;
      if (productResult.product != null) fixProduct(productResult.product!);

      return response;
    } catch (e) {
      return ServiceResponse<GetProductResult>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<GetProductCollectionResult>> getProductCrossSells(
      String productId) async {
    try {
      final urlString =
          '${CommerceAPIConstants.productsUrl}/$productId/crosssells';
      var response =
          await getAsyncWithCachedResponse<GetProductCollectionResult>(
              urlString, GetProductCollectionResult.fromJson);

      final productsResult = response.model;
      if (productsResult == null) return response;
      if (productsResult.products == null) return response;

      for (Product product in productsResult.products!) {
        fixProduct(product);
      }

      return response;
    } catch (e) {
      return ServiceResponse<GetProductCollectionResult>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<ProductPrice>> getProductPrice(
      String productId, ProductPriceQueryParameter parameters) async {
    try {
      var url =
          Uri.parse('${CommerceAPIConstants.productsUrl}/$productId/price');
      if (parameters.configuration != null) {
        if (parameters.configuration!.isNotEmpty) {
          final Map<String, dynamic> parametersMap = await compute(
              (ProductPriceQueryParameter parameters) => parameters.toJson(),
              parameters);

          url.replace(queryParameters: parametersMap);
        }
      }

      final urlString = url.toString();
      final response = await getAsyncWithCachedResponse<ProductPrice>(
          urlString, ProductPrice.fromJson);

      return response;
    } catch (e) {
      return ServiceResponse<ProductPrice>(exception: Exception(e.toString()));
    }
  }

  @Deprecated('Caution: Will be removed in a future release.')
  @override
  Future<ServiceResponse<GetProductCollectionResult>> getProducts(
      ProductsQueryParameters parameters) async {
    try {
      var url = Uri.parse('${CommerceAPIConstants.productsUrl}/');
      final parametersMap = await compute(
          (ProductsQueryParameters parameters) => parameters.toJson(),
          parameters);
      url = url.replace(queryParameters: parametersMap);
      final urlString = url.toString();
      final response =
          await getAsyncWithCachedResponse<GetProductCollectionResult>(
              urlString, GetProductCollectionResult.fromJson);
      final productsResult = response.model;
      if (productsResult == null) return response;
      if (productsResult.products == null) return response;

      for (Product product in productsResult.products!) {
        fixProduct(product);
      }

      return response;
    } catch (e) {
      return ServiceResponse<GetProductCollectionResult>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<GetProductCollectionResult>> getProductsNoCache(
      ProductsQueryParameters parameters) async {
    try {
      Map<String, dynamic> parametersMap = await compute(
          (ProductsQueryParameters parameters) => parameters.toJson(),
          parameters);

      String url = Uri.parse(CommerceAPIConstants.productsUrl)
          .replace(queryParameters: parametersMap)
          .toString();

      final response = await getAsyncNoCache<GetProductCollectionResult>(
          url, GetProductCollectionResult.fromJson);
      final productResult = response.model;

      if (productResult == null) return response;
      if (productResult.products == null) return response;

      for (Product product in productResult.products!) {
        fixProduct(product);
      }

      return response;
    } catch (e) {
      return ServiceResponse<GetProductCollectionResult>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<bool> hasProductCache(ProductsQueryParameters parameters) {
    // TODO: implement hasProductCache
    throw UnimplementedError();
  }
}
