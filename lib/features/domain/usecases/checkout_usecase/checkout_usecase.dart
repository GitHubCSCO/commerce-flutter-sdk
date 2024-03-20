import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutUsecase extends BaseUseCase {
  CheckoutUsecase() : super();

  Future<Result<Cart, ErrorResponse>> getCart(String cartId) async {
    // cart get for IsAcceptQuote is different,, need to implement it later
    var cartParameters = CartQueryParameters(cartId: cartId, expand: [
      'cartlines',
      'costcodes',
      'shipping',
      'tax',
      'carriers',
      'paymentoptions'
    ]);
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(cartParameters);
  }
}
