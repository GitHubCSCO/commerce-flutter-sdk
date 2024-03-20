import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class PaymentDetailsEvent {}

class LoadPaymentDetailsEvent extends PaymentDetailsEvent {
  final Cart cart;
  LoadPaymentDetailsEvent({required this.cart});
}

class UpdatePaymentMethodEvent extends PaymentDetailsEvent {
  final PaymentMethodDto paymentMethodDto;
  UpdatePaymentMethodEvent({required this.paymentMethodDto});
}
