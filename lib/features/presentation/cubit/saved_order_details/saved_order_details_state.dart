part of 'saved_order_details_cubit.dart';

class SavedOrderDetailsState extends Equatable {
  final Cart cart;
  final OrderStatus status;
  final bool shouldShowWarehouseInventoryButton;

  const SavedOrderDetailsState({
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

  SavedOrderDetailsState copyWith({
    Cart? cart,
    OrderStatus? status,
    bool? shouldShowWarehouseInventoryButton,
  }) {
    return SavedOrderDetailsState(
      cart: cart ?? this.cart,
      status: status ?? this.status,
      shouldShowWarehouseInventoryButton: shouldShowWarehouseInventoryButton ??
          this.shouldShowWarehouseInventoryButton,
    );
  }
}
