part of 'biometric_controller_cubit.dart';

sealed class BiometricControllerState extends Equatable {
  const BiometricControllerState();

  @override
  List<Object> get props => [];
}

final class BiometricControllerInitial extends BiometricControllerState {}

final class BiometricControllerLoading extends BiometricControllerState {}

final class BiometricControllerSuccess extends BiometricControllerState {}

final class BiometricControllerFailure extends BiometricControllerState {}
