part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class LoadCheckoutEvent extends CheckoutEvent {
  Cart cart;
  LoadCheckoutEvent({required this.cart});
}

class PlaceOrderEvent extends CheckoutEvent {}

class RequestDeliveryDateEvent extends CheckoutEvent {
  final DateTime dateTime;

  RequestDeliveryDateEvent(this.dateTime);
}

class SelectCarrierEvent extends CheckoutEvent {
  final CarrierDto carrier;

  SelectCarrierEvent(this.carrier);
}

class SelectServiceEvent extends CheckoutEvent {
  final ShipViaDto service;

  SelectServiceEvent(this.service);
}

class SelectPaymentMethodEvent extends CheckoutEvent {
  final PaymentMethodDto paymentMethod;

  SelectPaymentMethodEvent(this.paymentMethod);
}

class SelectPaymentEvent extends CheckoutEvent {
  final PaymentOptionsDto paymentOption;

  SelectPaymentEvent(this.paymentOption);
}


