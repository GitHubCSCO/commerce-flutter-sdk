import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class ICatalogpagesService {
  Future<Result<CatalogPage, ErrorResponse>> getProductCatalogInformation(
      String productPath);
}
