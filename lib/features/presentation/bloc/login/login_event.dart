abstract class LoginEvent {
  const LoginEvent();
}

class LoginSubmitEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmitEvent({required this.username, required this.password});
}
