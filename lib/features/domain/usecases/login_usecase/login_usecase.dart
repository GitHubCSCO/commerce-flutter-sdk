import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginUsecase {

  LoginUsecase(this._authenticationService);

  final IAuthenticationService _authenticationService;

  Future<Result<bool, ErrorResponse>> logInAsync(
      String username, String password) async {
        
    final result = await _authenticationService.logInAsync(username, password);
    return result;
  }

  Future<void> logoutAsync() async {
    return _authenticationService.logoutAsync();
  }
}
