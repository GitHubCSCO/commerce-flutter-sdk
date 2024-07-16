part of 'invoice_history_filter_cubit.dart';

class InvoiceHistoryFilterState {
  String? customerSequence;
  String? invoiceNumber;
  String? orderNumber;
  String? poNumber;
  ShipTo? shipTo;
  BillTo? billTo;
  bool showOpenOnly;
  DateTime? fromDate;
  DateTime? toDate;

  InvoiceHistoryFilterState({
    this.customerSequence = '-1',
    this.invoiceNumber,
    this.orderNumber,
    this.poNumber,
    this.shipTo,
    this.billTo,
    this.showOpenOnly = false,
    this.fromDate,
    this.toDate,
  });

  InvoiceHistoryFilterState copyWith({
    String? customerSequence,
    String? invoiceNumber,
    String? orderNumber,
    String? poNumber,
    ShipTo? shipTo,
    BillTo? billTo,
    bool? showOpenOnly,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return InvoiceHistoryFilterState(
      customerSequence: customerSequence ?? this.customerSequence,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      orderNumber: orderNumber ?? this.orderNumber,
      poNumber: poNumber ?? this.poNumber,
      shipTo: shipTo ?? this.shipTo,
      billTo: billTo ?? this.billTo,
      showOpenOnly: showOpenOnly ?? this.showOpenOnly,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}
