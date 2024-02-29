import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsIdFetchUseCase extends BaseUseCase {
  ProductDetailsIdFetchUseCase() : super() {}

  Future<Result<String, ErrorResponse>> getProductDetailsId(
      String urlSegment) async {
    var response = await commerceAPIServiceProvider
        .getCatalogpagesService()
        .getProductCatalogInformation(urlSegment);
    switch (response) {
      case Success(value: final data):
        return Success(data?.productId);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }
}
