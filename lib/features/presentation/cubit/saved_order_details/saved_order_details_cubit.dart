import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/saved_order/saved_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'saved_order_details_state.dart';

class SavedOrderDetailsCubit extends Cubit<SavedOrderDetailsState> {
  final SavedOrderUsecase _savedOrderUsecase;

  SavedOrderDetailsCubit({
    required SavedOrderUsecase savedOrderUsecase,
  })  : _savedOrderUsecase = savedOrderUsecase,
        super(
          SavedOrderDetailsState(
            cart: Cart(),
            status: OrderStatus.initial,
            shouldShowWarehouseInventoryButton: false,
          ),
        );

  Future<void> loadCart({required String cartId}) async {
    emit(state.copyWith(status: OrderStatus.loading));

    final shouldShowWarehouseInventoryButton =
        await _savedOrderUsecase.shouldShowWarehouseInventoryButton();

    final cart = await _savedOrderUsecase.loadCart(cartId: cartId);

    if (cart != null) {
      emit(
        state.copyWith(
          cart: cart,
          status: OrderStatus.success,
          shouldShowWarehouseInventoryButton:
              shouldShowWarehouseInventoryButton,
        ),
      );
    } else {
      emit(state.copyWith(status: OrderStatus.failure));
    }
  }

  Future<void> placeOrder() async {
    emit(state.copyWith(status: OrderStatus.addToCartLoading));

    final result = await _savedOrderUsecase.placeOrder(cart: state.cart);

    emit(state.copyWith(status: result));
  }

  Future<void> deleteSavedOrders() async {
    emit(state.copyWith(status: OrderStatus.deleteCartLoading));

    final result =
        await _savedOrderUsecase.deleteSavedOrders(cartId: state.cart.id ?? '');

    if (result) {
      emit(state.copyWith(status: OrderStatus.deleteCartSuccess));
    } else {
      emit(state.copyWith(status: OrderStatus.deleteCartFailure));
    }
  }
}
