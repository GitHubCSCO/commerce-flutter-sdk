import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartUseCase extends BaseUseCase {

  Future<Result<Cart, ErrorResponse>> loadCurrentCart() async {
    var cartParameters = CartQueryParameters(expand: [ "cartlines", "costcodes", "shipping", "tax" ]);
    var result = await commerceAPIServiceProvider.getCartService().getCurrentCart(cartParameters);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Warehouse? getPickUpWareHouse() {
    return commerceAPIServiceProvider.getSessionService().currentSession?.pickUpWarehouse;
  }

}