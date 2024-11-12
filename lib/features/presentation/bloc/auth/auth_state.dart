part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState({this.status = AuthStatus.unknown});
  const AuthState.authenticated() : this(status: AuthStatus.authenticated);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);
  const AuthState.autoLogout() : this(status: AuthStatus.autoLogout);

  @override
  List<Object> get props => [status];
}
