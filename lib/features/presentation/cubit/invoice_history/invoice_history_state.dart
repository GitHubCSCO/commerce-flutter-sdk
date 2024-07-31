part of 'invoice_history_cubit.dart';

class InvoiceHistoryState extends Equatable {
  final InvoiceStatus status;
  final GetInvoiceResult invoiceCollectionModel;
  final InvoiceQueryParameters invoiceQueryParameters;
  final InvoiceSortOrder invoiceSortOrder;
  final String? errorMessage;

  const InvoiceHistoryState({
    required this.status,
    required this.invoiceCollectionModel,
    required this.invoiceQueryParameters,
    required this.invoiceSortOrder,
    this.errorMessage
  });

  @override
  List<Object> get props => [
        status,
        invoiceCollectionModel,
        invoiceQueryParameters,
        invoiceSortOrder,
        errorMessage ?? '',
      ];

  InvoiceHistoryState copyWith({
    InvoiceStatus? status,
    GetInvoiceResult? invoiceCollectionModel,
    InvoiceQueryParameters? invoiceQueryParameters,
    InvoiceSortOrder? invoiceSortOrder,
    String? errorMessage
  }) {
    return InvoiceHistoryState(
      status: status ?? this.status,
      invoiceCollectionModel:
          invoiceCollectionModel ?? this.invoiceCollectionModel,
      invoiceQueryParameters:
          invoiceQueryParameters ?? this.invoiceQueryParameters,
      invoiceSortOrder: invoiceSortOrder ?? this.invoiceSortOrder,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
