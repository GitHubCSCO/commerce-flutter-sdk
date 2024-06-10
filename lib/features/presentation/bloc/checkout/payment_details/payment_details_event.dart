import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class PaymentDetailsEvent {}

class LoadPaymentDetailsEvent extends PaymentDetailsEvent {
  final Cart cart;

  LoadPaymentDetailsEvent({required this.cart});
}

class UpdatePaymentMethodEvent extends PaymentDetailsEvent {
  final PaymentMethodDto? paymentMethodDto;
  final bool isCVVRequired;
  UpdatePaymentMethodEvent(
      {required this.paymentMethodDto, required this.isCVVRequired});
}

class UpdateCreditCartInfoEvent extends PaymentDetailsEvent {
  final String cardNumber;
  final String cardType;
  final String securityCode;
  UpdateCreditCartInfoEvent(
      {required this.cardNumber,
      required this.cardType,
      required this.securityCode});
}

class UpdateNewAccountPaymentProfileEvent extends PaymentDetailsEvent {
  final AccountPaymentProfile accountPaymentProfile;
  UpdateNewAccountPaymentProfileEvent({required this.accountPaymentProfile});
}
