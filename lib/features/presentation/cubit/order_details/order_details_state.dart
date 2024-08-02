part of 'order_details_cubit.dart';

class OrderDetailsState extends Equatable {
  final OrderEntity order;
  final OrderStatus orderStatus;
  final bool isReorderViewVisible;
  final OrderSettingsEntity orderSettings;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;

  const OrderDetailsState(
      {required this.order,
      required this.isReorderViewVisible,
      required this.orderStatus,
      required this.orderSettings,
      this.hidePricingEnable,
      this.hideInventoryEnable});

  @override
  List<Object> get props => [
        order,
        orderStatus,
        isReorderViewVisible,
        orderSettings,
        hidePricingEnable ?? false,
        hideInventoryEnable ?? false
      ];

  OrderDetailsState copyWith({
    OrderEntity? order,
    OrderStatus? orderStatus,
    bool? isReorderViewVisible,
    OrderSettingsEntity? orderSettings,
    bool? hidePricingEnable,
    bool? hideInventoryEnable,
  }) {
    return OrderDetailsState(
      order: order ?? this.order,
      orderStatus: orderStatus ?? this.orderStatus,
      isReorderViewVisible: isReorderViewVisible ?? this.isReorderViewVisible,
      orderSettings: orderSettings ?? this.orderSettings,
      hidePricingEnable: hidePricingEnable ?? this.hidePricingEnable,
      hideInventoryEnable: hideInventoryEnable ?? this.hideInventoryEnable,
    );
  }
}
