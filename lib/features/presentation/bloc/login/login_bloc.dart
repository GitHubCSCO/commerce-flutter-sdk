import 'package:bloc/bloc.dart';
import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/login/login_state.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login_screen.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthenticationService _authenticationService =
      sl<IAuthenticationService>();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginSubmitEvent>(_onLoginSubmit);
  }

  Future<void> _onLoginSubmit(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final result =
        await _authenticationService.logInAsync(event.username, event.password);

    switch (result) {
      case Success():
        emit(const LoginSuccessState());
      case Failure(errorResponse: final errorResponse):
        emit(LoginFailureState(errorResponse.errorDescription ?? ''));
    }
  }
}
