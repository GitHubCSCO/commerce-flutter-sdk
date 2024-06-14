// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class LoadCheckoutEvent extends CheckoutEvent {
  Cart cart;
  LoadCheckoutEvent({required this.cart});
}

class PlaceOrderEvent extends CheckoutEvent {
  final ReviewOrderEntity? reviewOrderEntity;
  PlaceOrderEvent({this.reviewOrderEntity});
}

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

class UpdatePONumberEvent extends CheckoutEvent {
  final String poNumber;

  UpdatePONumberEvent(this.poNumber);
}

class UpdateShiptoAddressEvent extends CheckoutEvent {
  final ShipTo shipTo;

  UpdateShiptoAddressEvent(this.shipTo);
}
