import 'package:equatable/equatable.dart';

class OrderSettingsEntity extends Equatable {
  final bool? allowCancellationRequest;
  final bool? allowQuickOrder;
  final bool? canReorderItems;
  final bool? canOrderUpload;
  final bool? allowRma;
  final bool? showCostCode;
  final bool? showPoNumber;
  final bool? showTermsCode;
  final bool? showErpOrderNumber;
  final bool? showWebOrderNumber;
  final bool? showOrderStatus;
  final bool? showOrders;
  final int? lookBackDays;
  final bool? vmiEnabled;

  const OrderSettingsEntity({
    this.allowCancellationRequest,
    this.allowQuickOrder,
    this.canReorderItems,
    this.canOrderUpload,
    this.allowRma,
    this.showCostCode,
    this.showPoNumber,
    this.showTermsCode,
    this.showErpOrderNumber,
    this.showWebOrderNumber,
    this.showOrderStatus,
    this.showOrders,
    this.lookBackDays,
    this.vmiEnabled,
  });

  @override
  List<Object?> get props => [
        allowCancellationRequest,
        allowQuickOrder,
        canReorderItems,
        canOrderUpload,
        allowRma,
        showCostCode,
        showPoNumber,
        showTermsCode,
        showErpOrderNumber,
        showWebOrderNumber,
        showOrderStatus,
        showOrders,
        lookBackDays,
        vmiEnabled,
      ];

  OrderSettingsEntity copyWith({
    bool? allowCancellationRequest,
    bool? allowQuickOrder,
    bool? canReorderItems,
    bool? canOrderUpload,
    bool? allowRma,
    bool? showCostCode,
    bool? showPoNumber,
    bool? showTermsCode,
    bool? showErpOrderNumber,
    bool? showWebOrderNumber,
    bool? showOrderStatus,
    bool? showOrders,
    int? lookBackDays,
    bool? vmiEnabled,
  }) {
    return OrderSettingsEntity(
      allowCancellationRequest:
          allowCancellationRequest ?? this.allowCancellationRequest,
      allowQuickOrder: allowQuickOrder ?? this.allowQuickOrder,
      canReorderItems: canReorderItems ?? this.canReorderItems,
      canOrderUpload: canOrderUpload ?? this.canOrderUpload,
      allowRma: allowRma ?? this.allowRma,
      showCostCode: showCostCode ?? this.showCostCode,
      showPoNumber: showPoNumber ?? this.showPoNumber,
      showTermsCode: showTermsCode ?? this.showTermsCode,
      showErpOrderNumber: showErpOrderNumber ?? this.showErpOrderNumber,
      showWebOrderNumber: showWebOrderNumber ?? this.showWebOrderNumber,
      showOrderStatus: showOrderStatus ?? this.showOrderStatus,
      showOrders: showOrders ?? this.showOrders,
      lookBackDays: lookBackDays ?? this.lookBackDays,
      vmiEnabled: vmiEnabled ?? this.vmiEnabled,
    );
  }
}
