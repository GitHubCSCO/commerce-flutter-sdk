import 'package:commerce_flutter_sdk/src/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'biometric_auth_state.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  final BiometricUsecase _biometricUsecase;

  BiometricAuthCubit({required BiometricUsecase biometricUsecase})
      : _biometricUsecase = biometricUsecase,
        super(BiometricAuthInitial());

  Future<void> authenticateWithBiometrics() async {
    emit(BiometricAuthLoading());
    final authenticated = await _biometricUsecase.authenticateWithBiometrics();
    if (authenticated) {
      emit(BiometricAuthSuccess());
    } else {
      emit(BiometricAuthFailure());
    }
  }
}
