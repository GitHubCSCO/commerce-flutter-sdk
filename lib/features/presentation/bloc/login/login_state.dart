abstract class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}

class LoginFailureState extends LoginState {
  final String error;

  const LoginFailureState(this.error);
}
