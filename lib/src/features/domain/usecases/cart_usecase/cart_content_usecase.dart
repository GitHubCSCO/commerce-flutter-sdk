import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartContentUseCase extends BaseUseCase {
  Future<Result<bool, ErrorResponse>> deleteCartLine(CartLine cartLine) async {
    var response = await commerceAPIServiceProvider
        .getCartService()
        .deleteCartLine(cartLine);

    switch (response) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<bool, ErrorResponse>> clearCart() async {
    var response =
        await commerceAPIServiceProvider.getCartService().clearCart();
    switch (response) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<CartLine, ErrorResponse>> updateCartLine(
      CartLine cartLine) async {
    var response = await commerceAPIServiceProvider
        .getCartService()
        .updateCartLine(cartLine);
    switch (response) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }
}
