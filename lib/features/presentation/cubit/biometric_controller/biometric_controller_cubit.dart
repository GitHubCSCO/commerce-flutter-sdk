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
    emit(BiometricControllerLoading());
    final enabled =
        await _biometricUsecase.enableBiometricsWithPassword(password);
    enabled
        ? emit(BiometricControllerSuccess())
        : emit(BiometricControllerFailure());
  }
}
