import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_content_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartContentBloc extends Bloc<CartContentEvent, CartContentState> {
  final CartContentUseCase _contentUseCase;

  CartContentBloc({required CartContentUseCase contentUseCase})
      : _contentUseCase = contentUseCase,
        super(CartContentDefaultState()) {
    // on<CartContentQuantityChangedEvent>(_onCartContentQuantityChanged);
    on<CartContentRemoveEvent>(_onCartContentRemove);
    on<CartContentClearAllEvent>(_onCartContentClearAll);
  }

  // Future<void> _onCartContentQuantityChanged(
  //     CartContentQuantityChangedEvent event,
  //     Emitter<CartContentState> emit) async {
  //   final result =
  //       await _contentUseCase.patchCartContentQuantity(event.quantity);
  //   emit(result.fold(
  //     (l) => CartContentErrorState(l),
  //     (r) => CartContentLoadedState(r),
  //   ));
  // }

  Future<void> _onCartContentRemove(
      CartContentRemoveEvent event, Emitter<CartContentState> emit) async {
    final result = await _contentUseCase.deleteCartLine(event.cartLine);
    switch (result) {
      case Success(value: final data):
        emit(CartContentItemRemovedSuccessState());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CartContentItemRemovedFailureState(
            errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _onCartContentClearAll(
      CartContentClearAllEvent event, Emitter<CartContentState> emit) async {
    final result = await _contentUseCase.clearCart();
    switch (result) {
      case Success(value: final data):
        emit(CartContentClearAllSuccessState());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CartContentClearAllFailureState(
            errorResponse.errorDescription ?? ''));
        break;
    }
  }
}
