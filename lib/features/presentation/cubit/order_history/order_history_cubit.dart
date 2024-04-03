import 'package:commerce_flutter_app/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderUsecase _orderUsecase;

  OrderHistoryCubit({required OrderUsecase orderUsecase})
      : _orderUsecase = orderUsecase,
        super(
          const OrderHistoryState(
            orderEntities: GetOrderCollectionResultEntity(
              pagination: null,
              orders: null,
              showErpOrderNumber: null,
            ),
            orderStatus: OrderStatus.initial,
            orderSortOrder: OrderSortOrder.orderDateDescending,
          ),
        );

  Future<void> loadOrderHistory() async {
    emit(
      state.copyWith(
        orderStatus: OrderStatus.loading,
      ),
    );

    final result = await _orderUsecase.getOrderHistory();

    result != null
        ? emit(
            OrderHistoryState(
              orderEntities: result,
              orderStatus: OrderStatus.success,
              orderSortOrder: state.orderSortOrder,
            ),
          )
        : emit(
            state.copyWith(
              orderStatus: OrderStatus.failure,
            ),
          );
  }

  Future<void> loadMoreOrderHistory() async {
    if (state.orderEntities.pagination?.page == null ||
        state.orderEntities.pagination!.page! + 1 >
            state.orderEntities.pagination!.numberOfPages! ||
        state.orderStatus == OrderStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(orderStatus: OrderStatus.moreLoading));
    final result = await _orderUsecase.getOrderHistory(
      page: state.orderEntities.pagination!.page! + 1,
    );

    if (result == null) {
      emit(state.copyWith(orderStatus: OrderStatus.moreLoadingFailure));
      return;
    }

    final orders = state.orderEntities.orders;
    orders?.addAll(result.orders!);

    emit(
      state.copyWith(
        orderEntities: state.orderEntities.copyWith(
          pagination: result.pagination,
          orders: orders,
        ),
        orderStatus: OrderStatus.success,
      ),
    );
  }
}
