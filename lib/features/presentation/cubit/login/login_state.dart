part of 'login_cubit.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginStatus loginStatus;

  const LoginSuccessState({required this.loginStatus});
}

class LoginFailureState extends LoginState {
  final String? title;
  final String? message;
  final String? buttonText;

  const LoginFailureState({
    this.title,
    this.message,
    this.buttonText,
  });
}
