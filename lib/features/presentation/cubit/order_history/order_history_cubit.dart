import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderUsecase _orderUsecase;

  OrderHistoryCubit({required OrderUsecase orderUsecase})
      : _orderUsecase = orderUsecase,
        super(OrderHistoryInitial());

  Future<void> loadOrderHistory() async {
    emit(OrderHistoryLoading());
    final result = await _orderUsecase.getOrderHistory();

    result != null
        ? emit(OrderHistoryLoaded(result))
        : emit(OrderHistoryError());
  }
}
