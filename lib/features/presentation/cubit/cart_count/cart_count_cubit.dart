import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartCountCubit extends Cubit<CartCountState> {
  final CartUseCase _cartUseCase;
  CartCountCubit({required CartUseCase cartUseCase})
      : _cartUseCase = cartUseCase,
        super(CartCountState(cartItemCount: 0));

  Future<void> loadCurrentCartCount() async {
    var result = await _cartUseCase.loadCurrentCart();

    switch (result) {
      case Success(value: final data):
        var cart = data;
        if (cart?.cartLines == null || cart!.cartLines!.isEmpty) {
          emit(CartCountState(cartItemCount: 0));
          return;
        }
        emit(CartCountState(cartItemCount: cart.cartLines!.length));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CartCountState(cartItemCount: 0));
        break;
    }
  }
}
