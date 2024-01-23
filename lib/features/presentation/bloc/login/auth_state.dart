import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class LoginInitialState extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginLoadingState extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginSuccessState extends AuthenticationState {
  const LoginSuccessState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginFailureState extends AuthenticationState {
  final String error;

  const LoginFailureState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LogoutLoadingState extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationAuthState extends AuthenticationState {
  final AuthStatus status;

  const AuthenticationAuthState({this.status = AuthStatus.unknowm});
  const AuthenticationAuthState.authenticated()
      : this(status: AuthStatus.authenticated);
  const AuthenticationAuthState.unauthenticated()
      : this(status: AuthStatus.unauthenticated);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
