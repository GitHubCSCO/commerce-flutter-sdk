import 'package:commerce_flutter_app/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'biometric_controller_state.dart';

class BiometricControllerCubit extends Cubit<BiometricControllerState> {
  final BiometricUsecase _biometricUsecase;

  BiometricControllerCubit({required BiometricUsecase biometricUsecase})
      : _biometricUsecase = biometricUsecase,
        super(BiometricControllerInitial());

  Future<void> enableBiometric(String password) async {
    emit(BiometricControllerChangeLoading());
    final enabled =
        await _biometricUsecase.enableBiometricsWithPassword(password);
    enabled
        ? emit(BiometricControllerChangeSuccessEnabled())
        : emit(BiometricControllerChangeFailure());
  }

  Future<void> enableBiometricWhileLoggedIn(String password) async {
    emit(BiometricControllerChangeLoading());
    final enabled =
        await _biometricUsecase.enableBiometricsWhileLoggedIn(password);
    enabled
        ? emit(BiometricControllerChangeSuccessEnabled())
        : emit(BiometricControllerChangeFailure());
  }

  Future<void> checkBiometricEnabledForCurrentUser() async {
    emit(BiometricControllerLoading());
    final enabled =
        await _biometricUsecase.isBiometricAuthenticationEnableForCurrentUser();

    enabled
        ? emit(BiometricControllerEnabled())
        : emit(BiometricControllerDisabled());
  }

  Future<void> disableBiometricAuthentication() async {
    emit(BiometricControllerChangeLoading());
    final result = await _biometricUsecase.disableBiometricAuthentication();
    result
        ? emit(BiometricControllerChangeSuccessDisabled())
        : emit(BiometricControllerChangeFailure());
  }
}
