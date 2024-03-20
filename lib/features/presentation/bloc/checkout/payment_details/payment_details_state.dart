abstract class PaymentDetailsState {}

class PaymentDetailsInitial extends PaymentDetailsState {}

class PaymentDetailsLoading extends PaymentDetailsState {}

class PaymentDetailsLoaded extends PaymentDetailsState {
  final String paymentMethodValue;

  PaymentDetailsLoaded({required this.paymentMethodValue});
}
