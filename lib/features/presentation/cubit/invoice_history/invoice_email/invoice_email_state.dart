part of 'invoice_email_cubit.dart';

sealed class InvoiceEmailState extends Equatable {
  const InvoiceEmailState();

  @override
  List<Object> get props => [];
}

final class InvoiceEmailInitial extends InvoiceEmailState {}

final class InvoiceEmailLoading extends InvoiceEmailState {}

final class InvoiceEmailSuccess extends InvoiceEmailState {}

final class InvoiceEmailFailure extends InvoiceEmailState {
  final String message;

  const InvoiceEmailFailure({required this.message});

  @override
  List<Object> get props => [message];
}
