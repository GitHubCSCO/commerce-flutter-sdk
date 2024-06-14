import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ShippingAddressAddCallbackHelper {
  final void Function(ShipTo) onShippingAddressAdded;
  const ShippingAddressAddCallbackHelper({
    required this.onShippingAddressAdded,
  });
}
