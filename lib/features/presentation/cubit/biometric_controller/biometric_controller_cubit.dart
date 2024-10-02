import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/usecases/biometric_usecase/biometric_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'biometric_controller_state.dart';

class BiometricControllerCubit extends Cubit<BiometricControllerState> {
  final BiometricUsecase _biometricUsecase;

  BiometricControllerCubit({required BiometricUsecase biometricUsecase})
      : _biometricUsecase = biometricUsecase,
        super(BiometricControllerInitial());

  String biometricTypeName = '';

  void initialize({required String biometricTypeName}) {
    this.biometricTypeName = biometricTypeName;
  }

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

    if (enabled) {
      _biometricUsecase.trackEvent(AnalyticsEvent(
          AnalyticsConstants.eventEnableBiometric,
          AnalyticsConstants.screenNameSettings));
    }
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
    _biometricUsecase.trackEvent(AnalyticsEvent(
        AnalyticsConstants.eventDisableBiometric,
        AnalyticsConstants.screenNameSettings));

    emit(BiometricControllerChangeLoading());
    final result = await _biometricUsecase.disableBiometricAuthentication();
    result
        ? emit(BiometricControllerChangeSuccessDisabled())
        : emit(BiometricControllerChangeFailure());
  }

  void trackBiometricSetupEvent(String result) {
    final biometricSetupEvent = AnalyticsEvent(
      AnalyticsConstants.eventBiometricSetup,
      AnalyticsConstants.screenNameSignIn,
    )
        .withProperty(
          name: AnalyticsConstants.eventPropertyResult,
          strValue: result,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertyLoginType,
          strValue: biometricTypeName,
        );
    _biometricUsecase.trackEvent(biometricSetupEvent);
  }
}
