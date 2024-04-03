part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  final GetOrderCollectionResultEntity orderEntities;
  final OrderStatus orderStatus;
  final OrderSortOrder orderSortOrder;

  const OrderHistoryState({
    required this.orderEntities,
    required this.orderStatus,
    required this.orderSortOrder,
  });

  @override
  List<Object> get props => [orderEntities, orderStatus, orderSortOrder];

  OrderHistoryState copyWith({
    GetOrderCollectionResultEntity? orderEntities,
    OrderStatus? orderStatus,
    OrderSortOrder? orderSortOrder,
  }) {
    return OrderHistoryState(
      orderEntities: orderEntities ?? this.orderEntities,
      orderStatus: orderStatus ?? this.orderStatus,
      orderSortOrder: orderSortOrder ?? this.orderSortOrder,
    );
  }
}
