part of 'checkout_confirmation_cubit.dart';

abstract class CheckoutConfirmationState {}

class CheckoutConfirmationInitial extends CheckoutConfirmationState {}

class CheckoutConfirmationLoading extends CheckoutConfirmationState {}

class CheckoutConfirmationSuccess extends CheckoutConfirmationState {}

class CheckoutConfirmationFailure extends CheckoutConfirmationState {}
