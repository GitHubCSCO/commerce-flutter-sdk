part of 'order_approval_filter_cubit.dart';

class OrderApprovalFilterState {
  String? orderNumber;
  String? orderTotal;
  String? orderTotalOperator;
  DateTime? fromDate;
  DateTime? toDate;
  ShipTo? shipTo;
  BillTo? billTo;

  OrderApprovalFilterState({
    this.orderNumber,
    this.orderTotal,
    this.orderTotalOperator,
    this.fromDate,
    this.toDate,
    this.shipTo,
    this.billTo,
  });

  OrderApprovalFilterState copyWith({
    String? orderNumber,
    String? orderTotal,
    String? orderTotalOperator,
    DateTime? fromDate,
    DateTime? toDate,
    ShipTo? shipTo,
    BillTo? billTo,
  }) {
    return OrderApprovalFilterState(
      orderNumber: orderNumber ?? this.orderNumber,
      orderTotal: orderTotal ?? this.orderTotal,
      orderTotalOperator: orderTotalOperator ?? this.orderTotalOperator,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      shipTo: shipTo ?? this.shipTo,
      billTo: billTo ?? this.billTo,
    );
  }
}
