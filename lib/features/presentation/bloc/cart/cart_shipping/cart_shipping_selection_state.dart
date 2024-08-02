part of 'cart_shipping_selection_bloc.dart';

class CartShippingSelectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

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
