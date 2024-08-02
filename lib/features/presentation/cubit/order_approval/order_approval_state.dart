part of 'order_approval_cubit.dart';

class OrderApprovalState extends Equatable {
  final OrderStatus status;
  final GetOrderApprovalCollectionResult orderApprovalCollectionModel;
  final OrderApprovalParameters orderApprovalParameters;
  final bool? hidePricingEnable;
  final String? errorMessage;

  const OrderApprovalState(
      {required this.status,
      required this.orderApprovalCollectionModel,
      required this.orderApprovalParameters,
      this.hidePricingEnable,
      this.errorMessage});

  @override
  List<Object> get props => [
        status,
        orderApprovalCollectionModel,
        orderApprovalParameters,
        hidePricingEnable ?? false,
        errorMessage ?? ''
      ];

  OrderApprovalState copyWith({
    OrderStatus? status,
    GetOrderApprovalCollectionResult? orderApprovalCollectionModel,
    OrderApprovalParameters? orderApprovalParameters,
    bool? hidePricingEnable,
    String? errorMessage,
  }) {
    return OrderApprovalState(
      status: status ?? this.status,
      orderApprovalCollectionModel:
          orderApprovalCollectionModel ?? this.orderApprovalCollectionModel,
      orderApprovalParameters:
          orderApprovalParameters ?? this.orderApprovalParameters,
      hidePricingEnable: hidePricingEnable ?? this.hidePricingEnable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
