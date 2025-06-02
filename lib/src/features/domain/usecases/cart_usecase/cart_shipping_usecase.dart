import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartShippingUseCase extends BaseUseCase {
  Future<Result<Session, ErrorResponse>> patchCurrentShippingOption(
      ShippingOption shippingOption) async {
    var newSession = commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();
    newSession?.fulfillmentMethod = shippingOption.name;

    return await commerceAPIServiceProvider
        .getSessionService()
        .patchSession(newSession!);
  }
}
