part of 'order_approval_details_cubit.dart';

class OrderApprovalDetailsState extends Equatable {
  final Cart cart;
  final OrderStatus status;
  final bool shouldShowWarehouseInventoryButton;
  final bool hasRestrictedCartLines;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final String? errorMessage;

  const OrderApprovalDetailsState({
    required this.cart,
    required this.status,
    required this.shouldShowWarehouseInventoryButton,
    this.hasRestrictedCartLines = false,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        cart,
        status,
        shouldShowWarehouseInventoryButton,
        hasRestrictedCartLines,
        hidePricingEnable ?? false,
        hideInventoryEnable ?? false,
        errorMessage ?? '',
      ];

  OrderApprovalDetailsState copyWith({
    Cart? cart,
    OrderStatus? status,
    bool? shouldShowWarehouseInventoryButton,
    bool? hasRestrictedCartLines,
    bool? hidePricingEnable,
    bool? hideInventoryEnable,
    String? errorMessage,
  }) {
    return OrderApprovalDetailsState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
      shouldShowWarehouseInventoryButton: shouldShowWarehouseInventoryButton ??
          this.shouldShowWarehouseInventoryButton,
      hasRestrictedCartLines:
          hasRestrictedCartLines ?? this.hasRestrictedCartLines,
      hidePricingEnable: hidePricingEnable,
      hideInventoryEnable: hideInventoryEnable,
      errorMessage: errorMessage,
    );
  }
}
