part of 'order_approval_cubit.dart';

class OrderApprovalState extends Equatable {
  final OrderStatus status;
  final GetOrderApprovalCollectionResult orderApprovalCollectionModel;

  const OrderApprovalState({
    required this.status,
    required this.orderApprovalCollectionModel,
  });

  @override
  List<Object> get props => [
        status,
        orderApprovalCollectionModel,
      ];

  OrderApprovalState copyWith({
    OrderStatus? status,
    GetOrderApprovalCollectionResult? orderApprovalCollectionModel,
  }) {
    return OrderApprovalState(
      status: status ?? this.status,
      orderApprovalCollectionModel:
          orderApprovalCollectionModel ?? this.orderApprovalCollectionModel,
    );
  }
}
