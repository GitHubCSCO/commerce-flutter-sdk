part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  final GetOrderCollectionResultEntity orderEntities;
  final OrderStatus orderStatus;
  final OrderSortOrder orderSortOrder;
  final bool showMyOrders;
  final bool temporaryShowMyOrdersValue;
  final Set<String> selectedFilterValueIds;
  final Set<String> temporarySelectedFilterValueIds;
  final List<FilterValueViewModel> filterValues;
  final FilterStatus filterStatus;
  final String searchQuery;

  const OrderHistoryState({
    required this.orderEntities,
    required this.orderStatus,
    required this.orderSortOrder,
    required this.showMyOrders,
    required this.selectedFilterValueIds,
    this.filterStatus = FilterStatus.unknown,
    required this.filterValues,
    required this.temporarySelectedFilterValueIds,
    required this.temporaryShowMyOrdersValue,
    required this.searchQuery,
  });

  @override
  List<Object> get props => [
        orderEntities,
        orderStatus,
        orderSortOrder,
        showMyOrders,
        selectedFilterValueIds,
        filterValues,
        filterStatus,
        temporarySelectedFilterValueIds,
        temporaryShowMyOrdersValue,
        searchQuery,
      ];

  OrderHistoryState copyWith({
    GetOrderCollectionResultEntity? orderEntities,
    OrderStatus? orderStatus,
    OrderSortOrder? orderSortOrder,
    bool? showMyOrders,
    bool? temporaryShowMyOrdersValue,
    Set<String>? selectedFilterValueIds,
    Set<String>? temporarySelectedFilterValueIds,
    List<FilterValueViewModel>? filterValues,
    FilterStatus? filterStatus,
    String? searchQuery,
  }) {
    return OrderHistoryState(
      orderEntities: orderEntities ?? this.orderEntities,
      orderStatus: orderStatus ?? this.orderStatus,
      orderSortOrder: orderSortOrder ?? this.orderSortOrder,
      showMyOrders: showMyOrders ?? this.showMyOrders,
      temporaryShowMyOrdersValue:
          temporaryShowMyOrdersValue ?? this.temporaryShowMyOrdersValue,
      selectedFilterValueIds:
          selectedFilterValueIds ?? this.selectedFilterValueIds,
      temporarySelectedFilterValueIds: temporarySelectedFilterValueIds ??
          this.temporarySelectedFilterValueIds,
      filterValues: filterValues ?? this.filterValues,
      filterStatus: filterStatus ?? this.filterStatus,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  int get numberOfFilters =>
      selectedFilterValueIds.length + (showMyOrders ? 1 : 0);
}
