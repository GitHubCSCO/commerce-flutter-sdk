part of 'cart_shipping_selection_bloc.dart';

abstract class CartShippingSelectionEvent {}

class CartShippingOptionEvent extends CartShippingSelectionEvent {
  final ShippingOption selectedOption;

  CartShippingOptionEvent(this.selectedOption);
}
