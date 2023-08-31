import 'package:commerce_dart_sdk/src/services/service_base.dart';

abstract class IProductService {
  Future<ServiceResponse>? getProducts();
  Future<ServiceResponse>? getProductsV2();
}
