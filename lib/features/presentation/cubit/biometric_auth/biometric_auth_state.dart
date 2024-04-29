part of 'biometric_auth_cubit.dart';

sealed class BiometricAuthState extends Equatable {
  const BiometricAuthState();

  @override
  List<Object> get props => [];
}

final class BiometricAuthInitial extends BiometricAuthState {}

final class BiometricAuthLoading extends BiometricAuthState {}

final class BiometricAuthSuccess extends BiometricAuthState {}

final class BiometricAuthFailure extends BiometricAuthState {}
