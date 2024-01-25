import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LogoutUsecase {
  final IAuthenticationService _authenticationService;

  LogoutUsecase({required IAuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<void> logout() async {
    await _authenticationService.logoutAsync();
  }
}
