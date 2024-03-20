import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckkoutDataLoaded extends CheckoutState {
  final Cart cart;

  CheckkoutDataLoaded({required this.cart});
}

class CheckkoutDataFetchFailed extends CheckoutState {
  final String error;

  CheckkoutDataFetchFailed({required this.error});
}
