import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../sdk/usecases/mock_usecases.dart';

void main() {
  group('LoginCubit', () {
    late LoginUsecase loginUsecase;
    late LoginCubit loginCubit;

    setUp(() {
      loginUsecase = MockLoginUsecase();
      loginCubit = LoginCubit(loginUsecase: loginUsecase);
    });

    tearDown(() {
      loginCubit.close();
    });

    blocTest(
      'emits [LoginLoadingState, LoginSuccessState] when onLoginSubmit is called successfully',
      build: () {
        when(() => loginUsecase.attemptSignIn(any(), any()))
            .thenAnswer((_) async => LoginStatus.loginSuccessBillToShipTo);
        return loginCubit;
      },
      act: (cubit) async {
        cubit.onLoginSubmit('validUsername', 'validPassword');
      },
      expect: () => [
        LoginLoadingState(),
        const LoginSuccessState(showBiometricOptionView: false),
      ],
    );

    blocTest(
      'emits [LoginLoadingState, LoginSuccessState] when onLoginSubmit is called successfully with biometric option',
      build: () {
        when(() => loginUsecase.attemptSignIn(any(), any()))
            .thenAnswer((_) async => LoginStatus.loginSuccessBiometric);
        return loginCubit;
      },
      act: (cubit) async {
        cubit.onLoginSubmit('validUsername', 'validPassword');
      },
      expect: () => [
        LoginLoadingState(),
        const LoginSuccessState(showBiometricOptionView: true),
      ],
    );

    blocTest(
      'emits [LoginLoadingState, LoginFailureState] when onLoginSubmit encounters an error',
      build: () {
        when(() => loginUsecase.attemptSignIn(any(), any()))
            .thenAnswer((_) async => LoginStatus.loginErrorUnsuccessful);
        return loginCubit;
      },
      act: (cubit) async {
        cubit.onLoginSubmit('invalidUsername', 'invalidPassword');
      },
      expect: () => [
        LoginLoadingState(),
        const LoginFailureState(
          message: LocalizationConstants.incorrectLoginOrPassword,
          buttonText: LocalizationConstants.dismiss,
        ),
      ],
    );

  });
}