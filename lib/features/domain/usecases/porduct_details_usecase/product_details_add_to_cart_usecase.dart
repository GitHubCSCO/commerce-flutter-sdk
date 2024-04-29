import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsAddToCartUseCase extends BaseUseCase {
  ProductDetailsAddToCartUseCase() : super() ;

  Future<Result<CartLine, ErrorResponse>> addToCart(AddCartLine addcartLine) async {
    var result = await commerceAPIServiceProvider.getCartService().addCartLine(addcartLine);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }
}
