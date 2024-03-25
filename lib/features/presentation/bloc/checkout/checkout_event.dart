part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class LoadCheckoutEvent extends CheckoutEvent {
  Cart cart;
  LoadCheckoutEvent({required this.cart});
}

class RequestDeliveryDateEvent extends CheckoutEvent {
  final DateTime dateTime;

  RequestDeliveryDateEvent(this.dateTime);
}
