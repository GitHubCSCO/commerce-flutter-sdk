import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class LoginInitialState extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {
  const LoginSuccessState();
}

class LoginFailureState extends AuthenticationState {
  final String error;

  const LoginFailureState(this.error);
}

class LogoutLoadingState extends AuthenticationState {}

class AuthenticationAuthState extends AuthenticationState {
  final AuthStatus status;

  const AuthenticationAuthState({this.status = AuthStatus.unknowm});
  const AuthenticationAuthState.authenticated()
      : this(status: AuthStatus.authenticated);
  const AuthenticationAuthState.unauthenticated()
      : this(status: AuthStatus.unauthenticated);
}
