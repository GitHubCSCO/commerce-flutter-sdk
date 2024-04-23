part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  final GetOrderCollectionResultEntity orderEntities;
  final OrderStatus orderStatus;
  final OrderSortOrder orderSortOrder;
  final bool showMyOrders;
  final List<String> selectedFilterValues;

  const OrderHistoryState({
    required this.orderEntities,
    required this.orderStatus,
    required this.orderSortOrder,
    required this.showMyOrders,
    required this.selectedFilterValues,
  });

  @override
  List<Object> get props => [
        orderEntities,
        orderStatus,
        orderSortOrder,
        showMyOrders,
        selectedFilterValues,
      ];

  OrderHistoryState copyWith({
    GetOrderCollectionResultEntity? orderEntities,
    OrderStatus? orderStatus,
    OrderSortOrder? orderSortOrder,
    bool? showMyOrders,
    List<String>? selectedFilterValues,
  }) {
    return OrderHistoryState(
      orderEntities: orderEntities ?? this.orderEntities,
      orderStatus: orderStatus ?? this.orderStatus,
      orderSortOrder: orderSortOrder ?? this.orderSortOrder,
      showMyOrders: showMyOrders ?? this.showMyOrders,
      selectedFilterValues: selectedFilterValues ?? this.selectedFilterValues,
    );
  }

  int get numberOfFilters =>
      selectedFilterValues.length + (showMyOrders ? 1 : 0);
}
