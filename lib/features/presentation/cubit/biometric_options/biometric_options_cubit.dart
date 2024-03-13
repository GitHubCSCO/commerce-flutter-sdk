import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';
import 'package:commerce_flutter_app/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'biometric_options_state.dart';

class BiometricOptionsCubit extends Cubit<BiometricOptionsState> {
  final BiometricUsecase _biometricUsecase;

  BiometricOptionsCubit({required BiometricUsecase biometricUsecase})
      : _biometricUsecase = biometricUsecase,
        super(BiometricOptionsUnknown());

  Future<void> loadBiometricOptions() async {
    emit(BiometricOptionsLoading());
    final result = await _biometricUsecase.getBiometricOptions();

    emit(BiometricOptionsLoaded(result));
  }
}
