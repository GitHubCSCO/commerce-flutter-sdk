import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../sdk/services/mock_services.dart';
import '../../../../sdk/usecases/mock_usecases.dart';

void main() async {
  late LoginUsecase mockLoginUsecase;
  late LoginCubit sut;
  setUp(() async {
    GetIt.I.registerSingleton<ILocalizationService>(MockLocalizationService());
    await GetIt.I.allReady();

    mockLoginUsecase = MockLoginUsecase();
    sut = LoginCubit(loginUsecase: mockLoginUsecase);
  });
  tearDown(() {
    // Reset GetIt after each test
    GetIt.I.reset();
    sut.close();
  });
  group('LoginCubit', () {
    blocTest(
      'emits [LoginLoadingState, LoginSuccessState] when onLoginSubmit is called successfully with biometric option',
      build: () {
        when(() => mockLoginUsecase.attemptSignIn(any(), any())).thenAnswer(
            (_) async => LoginResponse(LoginStatus.loginSuccessBiometric));
        return sut;
      },
      act: (cubit) async {
        await cubit.onLoginSubmit('validUsername', 'validPassword');
      },
      expect: () => [
        LoginLoadingState(),
        const LoginSuccessState(loginStatus: LoginStatus.loginSuccessBiometric),
      ],
    );

    blocTest(
      'emits [LoginLoadingState, LoginFailureState] when onLoginSubmit encounters an error',
      build: () {
        when(() => mockLoginUsecase.attemptSignIn(any(), any())).thenAnswer(
            (_) async => LoginResponse(LoginStatus.loginErrorUnsuccessful));
        return sut;
      },
      act: (cubit) async {
        await cubit.onLoginSubmit('invalidUsername', 'invalidPassword');
      },
      expect: () => [
        LoginLoadingState(),
        LoginFailureState(
          title: LocalizationConstants.incorrectLoginOrPassword.localized(),
          buttonText: LocalizationConstants.dismiss.localized(),
        ),
      ],
    );
  });
}
