part of 'cart_shipping_selection_bloc.dart';

abstract class CartShippingSelectionState extends Equatable {}

class CartShippingDefaultState extends CartShippingSelectionState {
  final ShippingOption selectedOption;

  CartShippingDefaultState(this.selectedOption);

  @override
  List<Object?> get props => [selectedOption];
}

class CartShippingSelectionChangeState extends CartShippingSelectionState {
  final ShippingOption selectedOption;

  CartShippingSelectionChangeState(this.selectedOption);

  @override
  List<Object?> get props => [selectedOption];
}

