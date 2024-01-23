import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

void main() {
  group('LoginBloc', () {
    late LoginUsecase mockLoginUsecase;
    late LoginBloc loginBloc;

    setUp(() {
      mockLoginUsecase = MockLoginUsecase();
      loginBloc = LoginBloc(mockLoginUsecase);
    });

    const username = 'testUser';
    const password = 'testPassword';

    blocTest<LoginBloc, AuthenticationState>(
      'emits [LoginLoadingState, LoginSuccessState] when LoginSubmitEvent is added successfully',
      build: () {
        when(() => mockLoginUsecase.logInAsync(username, password))
            .thenAnswer((_) async => Future.value(const Success(true)));

        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginSubmitEvent(username: username, password: password)),
      expect: () => [
        LoginLoadingState(),
        LoginSuccessState(),
      ],
      verify: (_) {
        verify(() => mockLoginUsecase.logInAsync(username, password)).called(1);
        verifyNoMoreInteractions(mockLoginUsecase);
      },
    );

    blocTest<LoginBloc, AuthenticationState>(
      'emits [LoginLoadingState, LoginFailureState] when login fails',
      build: () {
        when(() => mockLoginUsecase.logInAsync(username, password))
            .thenAnswer((_) async => Failure(ErrorResponse(message: 'Error message')));

        return loginBloc;
      },
      act: (bloc) => bloc.add(const LoginSubmitEvent(username: username, password: password)),
      expect: () => [
        LoginLoadingState(),
        LoginFailureState('Error message'),
      ],
      verify: (_) {
        verify(() => mockLoginUsecase.logInAsync(username, password)).called(1);
        verifyNoMoreInteractions(mockLoginUsecase);
      },
    );

    blocTest<LoginBloc, AuthenticationState>(
      'emits [LogoutLoadingState, AuthenticationAuthState.unauthenticated()] when LogoutSubmitEvent is added successfully',
      build: () {
        when(() => mockLoginUsecase.logoutAsync()).thenAnswer((_) async {});

        return loginBloc;
      },
      act: (bloc) => bloc.add(const LogoutSubmitEvent()),
      expect: () => [
        LogoutLoadingState(),
        const AuthenticationAuthState.unauthenticated(),
      ],
      verify: (_) {
        verify(() => mockLoginUsecase.logoutAsync()).called(1);
        verifyNoMoreInteractions(mockLoginUsecase);
      },
    );
  });
}