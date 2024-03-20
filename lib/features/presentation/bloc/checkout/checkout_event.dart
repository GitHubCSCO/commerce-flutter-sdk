import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CheckoutEvent {}

class LoadCheckoutEvent extends CheckoutEvent {
  Cart cart;
  LoadCheckoutEvent({required this.cart});
}
