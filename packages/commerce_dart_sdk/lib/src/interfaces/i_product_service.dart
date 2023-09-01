import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

abstract class IProductService {
  Future<ServiceResponse<List<Product>>>? getProducts();
  Future<ServiceResponse<List<Product>>>? getProductListV2();
  Future<ServiceResponse<Product>>? getProduct(String queryParameters);
  Future<ServiceResponse<Product>>? getProductV2(String queryParameters);
}
