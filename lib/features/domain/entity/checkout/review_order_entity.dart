import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ReviewOrderEntity {
  final BillTo? billTo;
  final ShipTo? shipTo;
  final Warehouse? warehouse;
  final ShippingOption? shippingMethod;
  final List<CarrierDto>? carriers;
  final CartSettings? cartSettings;
  final PaymentMethodDto? paymentMethod;

  ReviewOrderEntity(
      {this.billTo,
      this.shipTo,
      this.warehouse,
      this.shippingMethod,
      this.carriers,
      this.cartSettings,
      this.paymentMethod});

  ReviewOrderEntity copyWith(
      {BillTo? billTo,
        ShipTo? shipTo,
        Warehouse? warehouse,
        ShippingOption? shippingMethod,
        List<CarrierDto>? carriers,
        CartSettings? cartSettings,
        PaymentMethodDto? paymentMethod}) {
    return ReviewOrderEntity(
      billTo: billTo ?? this.billTo,
      shipTo: shipTo ?? this.shipTo,
      warehouse: warehouse ?? this.warehouse,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      carriers: carriers ?? this.carriers,
      cartSettings: cartSettings ?? this.cartSettings,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}