part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginInfoLoadingState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginStatus loginStatus;

  const LoginSuccessState({required this.loginStatus});

  @override
  List<Object> get props => [loginStatus];
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

  @override
  List<Object> get props => [
        title ?? '',
        message ?? '',
        buttonText ?? '',
      ];
}
