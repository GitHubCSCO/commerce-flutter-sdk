import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AuthUsecase {
  final IAuthenticationService _authenticationService;

  AuthUsecase({required IAuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<bool> isAuthenticated() async {
    final authResult = await _authenticationService.isAuthenticatedAsync();
    switch (authResult) {
      case Success(value: final value):
        return value!;
      case Failure():
        return false;
    }
  }
}
