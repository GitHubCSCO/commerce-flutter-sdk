import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_shipping_selection_event.dart';
part 'cart_shipping_selection_state.dart';

class CartShippingSelectionBloc extends Bloc<CartShippingSelectionEvent, CartShippingSelectionState> {
  CartShippingSelectionBloc() : super(const CartShippingSelectionState(ShippingOption.ship)) {
    on<CartShippingOptionEvent>(_onCartShippingSelectionState);
  }

  Future<void> _onCartShippingSelectionState(CartShippingOptionEvent event, Emitter<CartShippingSelectionState> emit) async {
    emit(CartShippingSelectionState(event.selectedOption));
  }

}
