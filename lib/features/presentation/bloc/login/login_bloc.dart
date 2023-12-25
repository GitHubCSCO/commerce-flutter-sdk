import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/auth_state.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUsecase _loginUsecase;
  LoginBloc(this._loginUsecase) : super(LoginInitialState()) {
    on<LoginSubmitEvent>(_onLoginSubmit);
    on<LogoutSubmitEvent>(_onLogoutSubmit);
  }

  Future<void> _onLoginSubmit(
      LoginSubmitEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoadingState());
    final result =
        await _loginUsecase.logInAsync(event.username, event.password);

    switch (result) {
      case Success():
        emit(const LoginSuccessState());

      case Failure(errorResponse: final errorResponse):
        emit(LoginFailureState(errorResponse.errorDescription ?? ''));
    }
  }

  Future<void> _onLogoutSubmit(
      LogoutSubmitEvent event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationAuthState());

    // emit(LogoutLoadingState());
    // await _loginUsecase.logoutAsync();
    // emit(const AuthenticationAuthState());
  }
}
