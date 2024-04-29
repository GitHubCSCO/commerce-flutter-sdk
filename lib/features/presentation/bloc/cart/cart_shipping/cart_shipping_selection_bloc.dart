import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_shipping_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_shipping_selection_event.dart';
part 'cart_shipping_selection_state.dart';

class CartShippingSelectionBloc extends Bloc<CartShippingSelectionEvent, CartShippingSelectionState> {

  final CartShippingUseCase _shippingUseCase;

  CartShippingSelectionBloc({required CartShippingUseCase shippingUseCase})
      : _shippingUseCase = shippingUseCase,
        super(CartShippingSelectionState()) {
    on<CartShippingOptionDefaultEvent>(_onCartShippingDefaultState);
    on<CartShippingOptionChangeEvent>(_onCartShippingSelectionChangeState);
  }

  Future<void> _onCartShippingDefaultState(CartShippingOptionDefaultEvent event, Emitter<CartShippingSelectionState> emit) async {
    emit(CartShippingDefaultState(event.selectedOption));
  }

  Future<void> _onCartShippingSelectionChangeState(CartShippingOptionChangeEvent event, Emitter<CartShippingSelectionState> emit) async {
    emit(CartShippingDefaultState(event.selectedOption));
    await _shippingUseCase.patchCurrentShippingOption(event.selectedOption);
    emit(CartShippingSelectionChangeState(event.selectedOption));
  }

}
