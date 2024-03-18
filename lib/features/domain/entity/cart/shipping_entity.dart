import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ShippingEntity {

  final Warehouse? warehouse;
  final ShippingOption? shippingMethod;

  ShippingEntity({this.warehouse, this.shippingMethod});

  ShippingEntity copyWith({Warehouse? warehouse, ShippingOption? shippingMethod}) {
    return ShippingEntity(
      warehouse: warehouse ?? this.warehouse,
      shippingMethod: shippingMethod ?? this.shippingMethod,
    );
  }

}