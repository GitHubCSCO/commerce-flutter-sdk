part of 'checkout_bloc.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutDataLoaded extends CheckoutState {
  final Cart cart;

  CheckoutDataLoaded({required this.cart});
}

class CheckoutDataFetchFailed extends CheckoutState {
  final String error;

  CheckoutDataFetchFailed({required this.error});
}
