part of 'order_approval_details_cubit.dart';

class OrderApprovalDetailsState extends Equatable {
  final Cart cart;
  final OrderStatus status;
  final bool shouldShowWarehouseInventoryButton;
  const OrderApprovalDetailsState({
    required this.cart,
    required this.status,
    required this.shouldShowWarehouseInventoryButton,
  });

  @override
  List<Object> get props => [
        cart,
        status,
        shouldShowWarehouseInventoryButton,
      ];

  OrderApprovalDetailsState copyWith({
    Cart? cart,
    OrderStatus? status,
    bool? shouldShowWarehouseInventoryButton,
  }) {
    return OrderApprovalDetailsState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
      shouldShowWarehouseInventoryButton: shouldShowWarehouseInventoryButton ??
          this.shouldShowWarehouseInventoryButton,
    );
  }
}
