part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final bool showBiometricOptionView;

  const LoginSuccessState({this.showBiometricOptionView = false});
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
