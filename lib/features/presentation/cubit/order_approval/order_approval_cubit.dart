import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_approval_usecase/order_approval_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_approval_state.dart';

class OrderApprovalCubit extends Cubit<OrderApprovalState> {
  final OrderApprovalUseCase _orderApprovalUseCase;
  final PricingInventoryUseCase _pricingInventoryUseCase;

  OrderApprovalCubit(
      {required OrderApprovalUseCase orderApprovalUseCase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _orderApprovalUseCase = orderApprovalUseCase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(
          OrderApprovalState(
            status: OrderStatus.initial,
            orderApprovalCollectionModel: GetOrderApprovalCollectionResult(),
            orderApprovalParameters: OrderApprovalParameters(),
          ),
        );

  Future<void> loadOrderApprovalList() async {
    emit(state.copyWith(status: OrderStatus.loading));

    final result = await _orderApprovalUseCase.loadOrderApproval(
      page: 1,
      orderApprovalParameters: state.orderApprovalParameters,
    );

    if (result == null) {
      emit(state.copyWith(status: OrderStatus.failure));
      return;
    }

    final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();

    emit(
      state.copyWith(
          status: OrderStatus.success,
          orderApprovalCollectionModel: result,
          hidePricingEnable: hidePricingEnable),
    );
  }

  Future<void> loadMoreOrderApprovalList() async {
    if (state.orderApprovalCollectionModel.pagination?.page == null ||
        state.orderApprovalCollectionModel.pagination!.page! + 1 >
            state.orderApprovalCollectionModel.pagination!.numberOfPages!) {
      return;
    }

    emit(state.copyWith(status: OrderStatus.moreLoading));
    final result = await _orderApprovalUseCase.loadOrderApproval(
      page: state.orderApprovalCollectionModel.pagination!.page! + 1,
      orderApprovalParameters: state.orderApprovalParameters,
    );

    if (result == null) {
      emit(state.copyWith(status: OrderStatus.moreLoadingFailure));
      return;
    }

    final newCarts = state.orderApprovalCollectionModel.cartCollection;
    newCarts?.addAll(result.cartCollection ?? []);

    emit(
      state.copyWith(
        status: OrderStatus.success,
        orderApprovalCollectionModel: GetOrderApprovalCollectionResult(
          cartCollection: newCarts,
          pagination: result.pagination,
        ),
      ),
    );
  }

  Future<void> applyFilter({
    String? orderNumber,
    String? orderTotal,
    String? orderTotalOperator,
    DateTime? fromDate,
    DateTime? toDate,
    ShipTo? shipTo,
  }) async {
    final newOrderApprovalParameters = OrderApprovalParameters(
      orderNumber: orderNumber?.trim(),
      orderTotal: orderTotal?.trim(),
      orderTotalOperator:
          orderTotalOperator != null ? [orderTotalOperator] : null,
      fromDate: fromDate,
      toDate: toDate,
      shipTo: shipTo,
      shipToId: shipTo?.id,
    );

    emit(
      state.copyWith(
        orderApprovalParameters: newOrderApprovalParameters,
      ),
    );

    await loadOrderApprovalList();
  }

  bool get hasFilter =>
      state.orderApprovalParameters.fromDate != null ||
      state.orderApprovalParameters.toDate != null ||
      !state.orderApprovalParameters.orderNumber.isNullOrEmpty ||
      !state.orderApprovalParameters.orderTotal.isNullOrEmpty ||
      !state.orderApprovalParameters.shipToId.isNullOrEmpty ||
      (state.orderApprovalParameters.orderTotalOperator != null &&
          state.orderApprovalParameters.orderTotalOperator?.isNotEmpty == true);
}
