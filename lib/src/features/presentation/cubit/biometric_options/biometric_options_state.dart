part of 'biometric_options_cubit.dart';

sealed class BiometricOptionsState extends Equatable {
  const BiometricOptionsState();

  @override
  List<Object> get props => [];
}

final class BiometricOptionsUnknown extends BiometricOptionsState {}

final class BiometricOptionsLoading extends BiometricOptionsState {}

final class BiometricOptionsLoaded extends BiometricOptionsState {
  final DeviceAuthenticationOption option;

  const BiometricOptionsLoaded(this.option);

  @override
  List<Object> get props => [option];
}
