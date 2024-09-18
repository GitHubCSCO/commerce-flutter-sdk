import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/filter_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/order_usecase/order_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderUsecase _orderUsecase;
  final PricingInventoryUseCase _pricingInventoryUseCase;

  OrderHistoryCubit(
      {required OrderUsecase orderUsecase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _orderUsecase = orderUsecase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(
          const OrderHistoryState(
            showMyOrders: false,
            selectedFilterValueIds: {},
            orderEntities: GetOrderCollectionResultEntity(
              pagination: null,
              orders: null,
              showErpOrderNumber: null,
            ),
            orderStatus: OrderStatus.initial,
            orderSortOrder: OrderSortOrder.orderDateDescending,
            filterValues: [],
            temporarySelectedFilterValueIds: {},
            filterStatus: FilterStatus.unknown,
            temporaryShowMyOrdersValue: false,
            searchQuery: '',
            isFromVMI: false,
          ),
        );

  void initialize({bool isFromVMI = false}) {
    emit(
      state.copyWith(
        isFromVMI: isFromVMI,
      ),
    );
    loadOrderHistory();
  }

  Future<void> loadFilterValues() async {
    emit(
      state.copyWith(
        temporarySelectedFilterValueIds: {},
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
              temporarySelectedFilterValueIds: state.selectedFilterValueIds,
              temporaryShowMyOrdersValue: state.showMyOrders,
            ),
          )
        : emit(
            state.copyWith(
              filterStatus: FilterStatus.failure,
            ),
          );
  }

  void addFilterValue(String id) {
    emit(
      state.copyWith(
        temporarySelectedFilterValueIds:
            Set<String>.from(state.temporarySelectedFilterValueIds)..add(id),
      ),
    );
  }

  void removeFilterValue(String id) {
    emit(
      state.copyWith(
        temporarySelectedFilterValueIds:
            Set<String>.from(state.temporarySelectedFilterValueIds)..remove(id),
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
        temporarySelectedFilterValueIds: {},
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
        selectedFilterValueIds: state.temporarySelectedFilterValueIds,
        showMyOrders: state.temporaryShowMyOrdersValue,
      ),
    );

    await loadOrderHistory();
  }

  Future<void> searchQueryChanged(String query) async {
    emit(state.copyWith(searchQuery: query));

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
        filterAttributes: state.selectedFilterValueIds.toList(),
        searchText: state.searchQuery,
        isFromVMI: state.isFromVMI);

    final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();

    result != null
        ? emit(
            OrderHistoryState(
                showMyOrders: state.showMyOrders,
                selectedFilterValueIds: state.selectedFilterValueIds,
                orderEntities: result,
                orderStatus: OrderStatus.success,
                orderSortOrder: state.orderSortOrder,
                filterValues: state.filterValues,
                temporarySelectedFilterValueIds:
                    state.temporarySelectedFilterValueIds,
                filterStatus: state.filterStatus,
                temporaryShowMyOrdersValue: state.temporaryShowMyOrdersValue,
                searchQuery: state.searchQuery,
                isFromVMI: state.isFromVMI,
                hidePricingEnable: hidePricingEnable),
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
        filterAttributes: state.selectedFilterValueIds.toList(),
        searchText: state.searchQuery,
        isFromVMI: state.isFromVMI);

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

  String? get vmiLocationId => _orderUsecase.getCurrentLocation()?.id;

  String get websitePath => state.isFromVMI == true
        ? WebsitePaths.vmiOrdersPath.format([vmiLocationId ?? ''])
        : WebsitePaths.ordersPath;
}
