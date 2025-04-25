import 'package:commerce_flutter_sdk/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ShippingEntity {
  final Warehouse? warehouse;
  final ShippingOption? shippingMethod;
  final bool hasWillCall;

  ShippingEntity(
      {this.warehouse, this.shippingMethod, required this.hasWillCall});

  ShippingEntity copyWith(
      {Warehouse? warehouse,
      ShippingOption? shippingMethod,
      bool? hasWillCall}) {
    return ShippingEntity(
      warehouse: warehouse ?? this.warehouse,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      hasWillCall: hasWillCall ?? this.hasWillCall,
    );
  }
}
