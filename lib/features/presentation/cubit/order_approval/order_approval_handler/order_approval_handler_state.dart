part of 'order_approval_handler_cubit.dart';

enum OrderApprovalHandlerStatus {
  initial,
  shouldRefreshOrderApproval,
}

class OrderApprovalHandlerState extends Equatable {
  final OrderApprovalHandlerStatus status;

  const OrderApprovalHandlerState({
    required this.status,
  });

  @override
  List<Object> get props => [status];

  OrderApprovalHandlerState copyWith({
    OrderApprovalHandlerStatus? status,
  }) {
    return OrderApprovalHandlerState(
      status: status ?? this.status,
    );
  }
}
