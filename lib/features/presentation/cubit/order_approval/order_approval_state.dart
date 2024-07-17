part of 'order_approval_cubit.dart';

class OrderApprovalState extends Equatable {
  final OrderStatus status;
  final GetOrderApprovalCollectionResult orderApprovalCollectionModel;
  final OrderApprovalParameters orderApprovalParameters;
  final bool? hidePricingEnable;

  const OrderApprovalState({
    required this.status,
    required this.orderApprovalCollectionModel,
    required this.orderApprovalParameters,
    this.hidePricingEnable,
  });

  @override
  List<Object> get props => [
        status,
        orderApprovalCollectionModel,
        orderApprovalParameters,
        hidePricingEnable ?? false
      ];

  OrderApprovalState copyWith({
    OrderStatus? status,
    GetOrderApprovalCollectionResult? orderApprovalCollectionModel,
    OrderApprovalParameters? orderApprovalParameters,
    bool? hidePricingEnable,
  }) {
    return OrderApprovalState(
      status: status ?? this.status,
      orderApprovalCollectionModel:
          orderApprovalCollectionModel ?? this.orderApprovalCollectionModel,
      orderApprovalParameters:
          orderApprovalParameters ?? this.orderApprovalParameters,
      hidePricingEnable: hidePricingEnable ?? this.hidePricingEnable,
    );
  }
}
