import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';

abstract class PaymentDetailsState {}

class PaymentDetailsInitial extends PaymentDetailsState {}

class PaymentDetailsLoading extends PaymentDetailsState {}

class PaymentDetailsLoaded extends PaymentDetailsState {
  final String paymentMethodValue;
  final TokenExEntity? tokenExEntity;

  PaymentDetailsLoaded({required this.paymentMethodValue, this.tokenExEntity});
}
