import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartCountCubit extends Cubit<CountState> {
  final CartUseCase _cartUseCase;
  int cartItemCount = 0;
  bool _isCartItemsChanged = false;

  CartCountCubit({required CartUseCase cartUseCase})
      : _cartUseCase = cartUseCase,
        super(const CountInitialState(cartItemCount: 0));

  Future<void> loadCurrentCartCount() async {
    var result = await _cartUseCase.loadCurrentCart();

    switch (result) {
      case Success(value: final data):
        var cart = data;
        if (cart?.cartLines == null || cart!.cartLines!.isEmpty) {
          await emitCartCount(0);
          return;
        }
        await emitCartCount(cart.cartLines!.length);
      case Failure(errorResponse: final errorResponse):
        await emitCartCount(0);
    }
  }

  Future<void> emitCartCount(int count) async {
    cartItemCount = count;
    emit(CartCountState(
        cartItemCount: cartItemCount, timestamp: DateTime.now()));
  }

  Future<void> onCartItemChange() async {
    setCartItemChange(true);
    await loadCurrentCartCount();
  }

  void setCartItemChange(bool change) {
    _isCartItemsChanged = change;
  }

  Future<void> onSelectCartTab() async {
    emit(CartTabReloadState(
        timestamp: DateTime.now(), cartItemCount: cartItemCount));
  }

  bool cartItemChanged() => _isCartItemsChanged;
}
