part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  final GetOrderCollectionResultEntity orderEntities;
  final OrderStatus orderStatus;
  final OrderSortOrder orderSortOrder;
  final bool showMyOrders;
  final bool temporaryShowMyOrdersValue;
  final Set<String> selectedFilterValues;
  final Set<String> temporarySelectedFilterValues;
  final List<String> filterValues;
  final FilterStatus filterStatus;

  const OrderHistoryState({
    required this.orderEntities,
    required this.orderStatus,
    required this.orderSortOrder,
    required this.showMyOrders,
    required this.selectedFilterValues,
    this.filterStatus = FilterStatus.unknown,
    required this.filterValues,
    required this.temporarySelectedFilterValues,
    required this.temporaryShowMyOrdersValue,
  });

  @override
  List<Object> get props => [
        orderEntities,
        orderStatus,
        orderSortOrder,
        showMyOrders,
        selectedFilterValues,
        filterStatus,
        filterValues,
        temporarySelectedFilterValues,
        temporaryShowMyOrdersValue,
      ];

  OrderHistoryState copyWith({
    GetOrderCollectionResultEntity? orderEntities,
    OrderStatus? orderStatus,
    OrderSortOrder? orderSortOrder,
    bool? showMyOrders,
    bool? temporaryShowMyOrdersValue,
    Set<String>? selectedFilterValues,
    Set<String>? temporarySelectedFilterValues,
    List<String>? filterValues,
    FilterStatus? filterStatus,
  }) {
    return OrderHistoryState(
      orderEntities: orderEntities ?? this.orderEntities,
      orderStatus: orderStatus ?? this.orderStatus,
      orderSortOrder: orderSortOrder ?? this.orderSortOrder,
      showMyOrders: showMyOrders ?? this.showMyOrders,
      temporaryShowMyOrdersValue:
          temporaryShowMyOrdersValue ?? this.temporaryShowMyOrdersValue,
      selectedFilterValues: selectedFilterValues ?? this.selectedFilterValues,
      temporarySelectedFilterValues:
          temporarySelectedFilterValues ?? this.temporarySelectedFilterValues,
      filterValues: filterValues ?? this.filterValues,
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }

  int get numberOfFilters =>
      selectedFilterValues.length + (showMyOrders ? 1 : 0);
}
