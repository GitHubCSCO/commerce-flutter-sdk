part of 'order_approval_cubit.dart';

class OrderApprovalState extends Equatable {
  final OrderStatus status;
  final GetOrderApprovalCollectionResult orderApprovalCollectionModel;
  final OrderApprovalParameters orderApprovalParameters;

  const OrderApprovalState({
    required this.status,
    required this.orderApprovalCollectionModel,
    required this.orderApprovalParameters,
  });

  @override
  List<Object> get props => [
        status,
        orderApprovalCollectionModel,
        orderApprovalParameters,
      ];

  OrderApprovalState copyWith({
    OrderStatus? status,
    GetOrderApprovalCollectionResult? orderApprovalCollectionModel,
    OrderApprovalParameters? orderApprovalParameters,
  }) {
    return OrderApprovalState(
      status: status ?? this.status,
      orderApprovalCollectionModel:
          orderApprovalCollectionModel ?? this.orderApprovalCollectionModel,
      orderApprovalParameters:
          orderApprovalParameters ?? this.orderApprovalParameters,
    );
  }
}
