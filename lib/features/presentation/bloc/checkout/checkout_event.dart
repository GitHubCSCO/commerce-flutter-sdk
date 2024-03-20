part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class LoadCheckoutEvent extends CheckoutEvent {
  Cart cart;
  LoadCheckoutEvent({required this.cart});
}
