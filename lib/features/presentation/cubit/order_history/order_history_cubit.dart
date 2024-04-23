import 'package:commerce_flutter_app/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/filter_status.dart';
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
            showMyOrders: false,
            selectedFilterValues: {},
            orderEntities: GetOrderCollectionResultEntity(
              pagination: null,
              orders: null,
              showErpOrderNumber: null,
            ),
            orderStatus: OrderStatus.initial,
            orderSortOrder: OrderSortOrder.orderDateDescending,
            filterValues: [],
            temporarySelectedFilterValues: {},
            filterStatus: FilterStatus.unknown,
            temporaryShowMyOrdersValue: false,
          ),
        );

  Future<void> loadFilterValues() async {
    emit(
      state.copyWith(
        temporarySelectedFilterValues: {},
        temporaryShowMyOrdersValue: false,
        filterStatus: FilterStatus.loading,
      ),
    );

    final result = await _orderUsecase.getFilterValues();

    result != null
        ? emit(
            state.copyWith(
              filterValues: result,
              filterStatus: FilterStatus.success,
              temporarySelectedFilterValues: state.selectedFilterValues,
              temporaryShowMyOrdersValue: state.showMyOrders,
            ),
          )
        : emit(
            state.copyWith(
              filterStatus: FilterStatus.failure,
            ),
          );
  }

  void addFilterValue(String value) {
    emit(
      state.copyWith(
        temporarySelectedFilterValues:
            Set<String>.from(state.temporarySelectedFilterValues)..add(value),
      ),
    );
  }

  void removeFilterValue(String value) {
    emit(
      state.copyWith(
        temporarySelectedFilterValues:
            Set<String>.from(state.temporarySelectedFilterValues)
              ..remove(value),
      ),
    );
  }

  void toggleShowMyOrders() {
    emit(
      state.copyWith(
        temporaryShowMyOrdersValue: !state.temporaryShowMyOrdersValue,
      ),
    );
  }

  void resetFilter() {
    emit(
      state.copyWith(
        temporarySelectedFilterValues: {},
        temporaryShowMyOrdersValue: false,
      ),
    );
  }

  Future<void> changeSortOrder(OrderSortOrder orderSortOrder) async {
    emit(
      state.copyWith(
        orderSortOrder: orderSortOrder,
      ),
    );

    await loadOrderHistory();
  }

  Future<void> applyFilter() async {
    emit(
      state.copyWith(
        selectedFilterValues: state.temporarySelectedFilterValues,
        showMyOrders: state.temporaryShowMyOrdersValue,
      ),
    );

    await loadOrderHistory();
  }

  Future<void> loadOrderHistory() async {
    emit(
      state.copyWith(
        orderStatus: OrderStatus.loading,
      ),
    );

    final result = await _orderUsecase.getOrderHistory(
      sortOrder: state.orderSortOrder,
      showMyOrders: state.showMyOrders,
      filterAttributes: state.selectedFilterValues.toList(),
    );

    result != null
        ? emit(
            OrderHistoryState(
              showMyOrders: state.showMyOrders,
              selectedFilterValues: state.selectedFilterValues,
              orderEntities: result,
              orderStatus: OrderStatus.success,
              orderSortOrder: state.orderSortOrder,
              filterValues: state.filterValues,
              temporarySelectedFilterValues:
                  state.temporarySelectedFilterValues,
              filterStatus: state.filterStatus,
              temporaryShowMyOrdersValue: state.temporaryShowMyOrdersValue,
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
      sortOrder: state.orderSortOrder,
      showMyOrders: state.showMyOrders,
      filterAttributes: state.selectedFilterValues.toList(),
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

  List<OrderSortOrder> get availableSortOrders =>
      _orderUsecase.availableSortOrders;
}
