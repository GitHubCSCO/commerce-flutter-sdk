part of 'order_approval_details_cubit.dart';

class OrderApprovalDetailsState extends Equatable {
  final Cart cart;
  final OrderStatus status;
  final bool shouldShowWarehouseInventoryButton;
  final bool hasRestrictedCartLines;

  const OrderApprovalDetailsState({
    required this.cart,
    required this.status,
    required this.shouldShowWarehouseInventoryButton,
    this.hasRestrictedCartLines = false,
  });

  @override
  List<Object> get props => [
        cart,
        status,
        shouldShowWarehouseInventoryButton,
        hasRestrictedCartLines,
      ];

  OrderApprovalDetailsState copyWith({
    Cart? cart,
    OrderStatus? status,
    bool? shouldShowWarehouseInventoryButton,
    bool? hasRestrictedCartLines,
  }) {
    return OrderApprovalDetailsState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
      shouldShowWarehouseInventoryButton: shouldShowWarehouseInventoryButton ??
          this.shouldShowWarehouseInventoryButton,
      hasRestrictedCartLines:
          hasRestrictedCartLines ?? this.hasRestrictedCartLines,
    );
  }
}
