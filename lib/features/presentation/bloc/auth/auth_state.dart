part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState({this.status = AuthStatus.unknowm});
  const AuthState.authenticated() : this(status: AuthStatus.authenticated);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  @override
  List<Object> get props => [status];
}
