part of 'invoice_history_cubit.dart';

enum InvoiceStatus {
  initial,
  loading,
  moreLoading,
  success,
  failure,
  moreLoadingFailure,
}

class InvoiceHistoryState extends Equatable {
  final InvoiceStatus status;
  final GetInvoiceResult invoiceCollectionModel;
  final InvoiceQueryParameters invoiceQueryParameters;
  final InvoiceSortOrder invoiceSortOrder;

  const InvoiceHistoryState({
    required this.status,
    required this.invoiceCollectionModel,
    required this.invoiceQueryParameters,
    required this.invoiceSortOrder,
  });

  @override
  List<Object> get props => [
        status,
        invoiceCollectionModel,
        invoiceQueryParameters,
        invoiceSortOrder,
      ];

  InvoiceHistoryState copyWith({
    InvoiceStatus? status,
    GetInvoiceResult? invoiceCollectionModel,
    InvoiceQueryParameters? invoiceQueryParameters,
    InvoiceSortOrder? invoiceSortOrder,
  }) {
    return InvoiceHistoryState(
      status: status ?? this.status,
      invoiceCollectionModel:
          invoiceCollectionModel ?? this.invoiceCollectionModel,
      invoiceQueryParameters:
          invoiceQueryParameters ?? this.invoiceQueryParameters,
      invoiceSortOrder: invoiceSortOrder ?? this.invoiceSortOrder,
    );
  }
}
