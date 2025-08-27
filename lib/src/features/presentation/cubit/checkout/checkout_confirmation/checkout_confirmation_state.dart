part of 'checkout_confirmation_cubit.dart';

abstract class CheckoutConfirmationState {}

class CheckoutConfirmationInitial extends CheckoutConfirmationState {}

class CheckoutConfirmationLoading extends CheckoutConfirmationState {}

class CheckoutConfirmationLoaded extends CheckoutConfirmationState {
  final bool isCancelEnabled;

  CheckoutConfirmationLoaded({this.isCancelEnabled = false});
}

class CheckoutConfirmationSuccess extends CheckoutConfirmationState {}

class CheckoutConfirmationFailure extends CheckoutConfirmationState {
  final bool isCancelEnabled;

  CheckoutConfirmationFailure({this.isCancelEnabled = false});
}
