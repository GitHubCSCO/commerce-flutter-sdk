import 'package:commerce_flutter_app/features/domain/usecases/saved_order/saved_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'saved_order_add_to_state.dart';

class SavedOrderAddToCubit extends Cubit<SavedOrderAddToState> {
  final SavedOrderUsecase _savedOrderUsecase;

  SavedOrderAddToCubit({required SavedOrderUsecase savedOrderUsecase})
      : _savedOrderUsecase = savedOrderUsecase,
        super(
          const SavedOrderAddToState(status: SavedOrderAddToStatus.initial),
        );

  Future<void> addCartToSavedOrders({required Cart cart}) async {
    emit(state.copyWith(status: SavedOrderAddToStatus.loading));
    final result = await _savedOrderUsecase.addCartToSavedOrders(cart: cart);

    if (!result) {
      emit(state.copyWith(status: SavedOrderAddToStatus.failure));
      return;
    }

    emit(state.copyWith(status: SavedOrderAddToStatus.shouldRefreshSavedOrder));
  }

  void resetState() {
    emit(const SavedOrderAddToState(status: SavedOrderAddToStatus.initial));
  }
}
