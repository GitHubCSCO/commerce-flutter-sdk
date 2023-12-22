abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class LoginSubmitEvent extends AuthenticationEvent {
  final String username;
  final String password;

  const LoginSubmitEvent({required this.username, required this.password});
}

class LogoutSubmitEvent extends AuthenticationEvent {
  const LogoutSubmitEvent();
}
