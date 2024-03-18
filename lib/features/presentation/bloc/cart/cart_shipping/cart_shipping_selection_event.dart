part of 'cart_shipping_selection_bloc.dart';

abstract class CartShippingSelectionEvent {}

class CartShippingOptionChangeEvent extends CartShippingSelectionEvent {
  final ShippingOption selectedOption;

  CartShippingOptionChangeEvent(this.selectedOption);
}

class CartShippingOptionDefaultEvent extends CartShippingSelectionEvent {
  final ShippingOption selectedOption;

  CartShippingOptionDefaultEvent(this.selectedOption);
}
