import 'package:commerce_flutter_sdk/features/domain/usecases/saved_order/saved_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'saved_order_handler_state.dart';

class SavedOrderHandlerCubit extends Cubit<SavedOrderHandlerState> {
  final SavedOrderUsecase _savedOrderUsecase;

  SavedOrderHandlerCubit({required SavedOrderUsecase savedOrderUsecase})
      : _savedOrderUsecase = savedOrderUsecase,
        super(
          SavedOrderHandlerState(
            status: SavedOrderHandlerStatus.initial,
            savedCart: Cart(),
          ),
        );

  Future<void> addCartToSavedOrders({required Cart? cart}) async {
    emit(state.copyWith(status: SavedOrderHandlerStatus.loading));

    if (cart == null) {
      emit(state.copyWith(status: SavedOrderHandlerStatus.failure));
      return;
    }

    final result = await _savedOrderUsecase.addCartToSavedOrders(cart: cart);

    if (result == null) {
      emit(state.copyWith(status: SavedOrderHandlerStatus.failure));
      return;
    }

    emit(
      state.copyWith(
        status: SavedOrderHandlerStatus.shouldClearCart,
        savedCart: result,
      ),
    );

    emit(
      state.copyWith(status: SavedOrderHandlerStatus.shouldRefreshSavedOrder),
    );
  }

  void shouldRefreshSavedOrder() {
    emit(
      state.copyWith(status: SavedOrderHandlerStatus.shouldRefreshSavedOrder),
    );
  }

  void resetState() {
    emit(
      SavedOrderHandlerState(
        status: SavedOrderHandlerStatus.initial,
        savedCart: Cart(),
      ),
    );
  }
}
