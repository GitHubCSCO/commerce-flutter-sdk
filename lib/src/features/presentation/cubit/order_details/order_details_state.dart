part of 'order_details_cubit.dart';

class OrderDetailsState extends Equatable {
  final OrderEntity order;
  final OrderStatus orderStatus;
  final bool isReorderViewVisible;
  final OrderSettingsEntity orderSettings;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final bool? cancelOrderEnable;
  final bool? returnOrderEnable;
  final String? errorMessage;

  const OrderDetailsState({
    required this.order,
    required this.isReorderViewVisible,
    required this.orderStatus,
    required this.orderSettings,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    this.cancelOrderEnable,
    this.returnOrderEnable,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        order,
        orderStatus,
        isReorderViewVisible,
        orderSettings,
        hidePricingEnable ?? false,
        hideInventoryEnable ?? false,
        cancelOrderEnable ?? false,
        returnOrderEnable ?? false,
        errorMessage ?? ''
      ];

  OrderDetailsState copyWith({
    OrderEntity? order,
    OrderStatus? orderStatus,
    bool? isReorderViewVisible,
    OrderSettingsEntity? orderSettings,
    bool? hidePricingEnable,
    bool? hideInventoryEnable,
    bool? cancelOrderEnable,
    bool? returnOrderEnable,
    String? errorMessage,
  }) {
    return OrderDetailsState(
      order: order ?? this.order,
      orderStatus: orderStatus ?? this.orderStatus,
      isReorderViewVisible: isReorderViewVisible ?? this.isReorderViewVisible,
      orderSettings: orderSettings ?? this.orderSettings,
      hidePricingEnable: hidePricingEnable ?? this.hidePricingEnable,
      hideInventoryEnable: hideInventoryEnable ?? this.hideInventoryEnable,
      cancelOrderEnable: cancelOrderEnable ?? this.cancelOrderEnable,
      returnOrderEnable: returnOrderEnable ?? this.returnOrderEnable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
