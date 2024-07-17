part of 'saved_order_details_cubit.dart';

class SavedOrderDetailsState extends Equatable {
  final Cart cart;
  final OrderStatus status;
  final bool shouldShowWarehouseInventoryButton;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;

  const SavedOrderDetailsState({
    required this.cart,
    required this.status,
    required this.shouldShowWarehouseInventoryButton,
    this.hidePricingEnable,
    this.hideInventoryEnable
  });

  @override
  List<Object> get props => [
        cart,
        status,
        shouldShowWarehouseInventoryButton,
        hidePricingEnable ?? false,
        hideInventoryEnable ?? false
      ];

  SavedOrderDetailsState copyWith({
    Cart? cart,
    OrderStatus? status,
    bool? shouldShowWarehouseInventoryButton,
    bool? hidePricingEnable,
    bool? hideInventoryEnable,
  }) {
    return SavedOrderDetailsState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
      shouldShowWarehouseInventoryButton: shouldShowWarehouseInventoryButton ??
          this.shouldShowWarehouseInventoryButton,
      hidePricingEnable: hidePricingEnable ?? this.hidePricingEnable,
      hideInventoryEnable: hideInventoryEnable ?? this.hideInventoryEnable,
    );
  }
}
