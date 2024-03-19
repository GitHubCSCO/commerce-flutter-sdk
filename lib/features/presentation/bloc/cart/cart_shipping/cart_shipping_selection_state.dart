part of 'cart_shipping_selection_bloc.dart';

class CartShippingSelectionState extends Equatable {
  final ShippingOption selectedOption;

  const CartShippingSelectionState(this.selectedOption);

  @override
  List<Object?> get props => [selectedOption];
}

