part of 'order_approval_filter_cubit.dart';

class OrderApprovalFilterState {
  String? orderNumber;
  String? orderTotal;
  String? orderTotalOperator;
  DateTime? fromDate;
  DateTime? toDate;
  ShipTo? shipTo;

  OrderApprovalFilterState({
    this.orderNumber,
    this.orderTotal,
    this.orderTotalOperator,
    this.fromDate,
    this.toDate,
    this.shipTo,
  });

  OrderApprovalFilterState copyWith({
    String? orderNumber,
    String? orderTotal,
    String? orderTotalOperator,
    DateTime? fromDate,
    DateTime? toDate,
    ShipTo? shipTo,
  }) {
    return OrderApprovalFilterState(
      orderNumber: orderNumber ?? this.orderNumber,
      orderTotal: orderTotal ?? this.orderTotal,
      orderTotalOperator: orderTotalOperator ?? this.orderTotalOperator,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      shipTo: shipTo ?? this.shipTo,
    );
  }
}
