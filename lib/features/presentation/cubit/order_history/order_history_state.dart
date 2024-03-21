part of 'order_history_cubit.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

final class OrderHistoryInitial extends OrderHistoryState {}

final class OrderHistoryLoading extends OrderHistoryState {}

final class OrderHistoryLoaded extends OrderHistoryState {
  final List<OrderEntity> orderEntities;

  const OrderHistoryLoaded(this.orderEntities);

  @override
  List<Object> get props => [orderEntities];
}

final class OrderHistoryError extends OrderHistoryState {}
