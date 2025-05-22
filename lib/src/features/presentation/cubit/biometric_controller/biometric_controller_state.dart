part of 'biometric_controller_cubit.dart';

sealed class BiometricControllerState extends Equatable {
  const BiometricControllerState();

  @override
  List<Object> get props => [];
}

final class BiometricControllerInitial extends BiometricControllerState {}

final class BiometricControllerLoading extends BiometricControllerState {}

final class BiometricControllerEnabled extends BiometricControllerState {}

final class BiometricControllerDisabled extends BiometricControllerState {}

final class BiometricControllerChangeLoading extends BiometricControllerState {}

final class BiometricControllerChangeSuccessEnabled
    extends BiometricControllerState {}

final class BiometricControllerChangeSuccessDisabled
    extends BiometricControllerState {}

final class BiometricControllerChangeFailure extends BiometricControllerState {}
