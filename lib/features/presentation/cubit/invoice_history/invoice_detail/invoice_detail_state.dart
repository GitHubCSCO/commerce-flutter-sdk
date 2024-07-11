part of 'invoice_detail_cubit.dart';

class InvoiceDetailState extends Equatable {
  final InvoiceStatus status;
  final Invoice invoice;

  const InvoiceDetailState({
    required this.status,
    required this.invoice,
  });

  @override
  List<Object> get props => [
        status,
        invoice,
      ];

  InvoiceDetailState copyWith({
    InvoiceStatus? status,
    Invoice? invoice,
  }) {
    return InvoiceDetailState(
      status: status ?? this.status,
      invoice: invoice ?? this.invoice,
    );
  }
}
