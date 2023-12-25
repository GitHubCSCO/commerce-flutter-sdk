import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LoginUsecase {
  final IAuthenticationService _authenticationService =
      sl<IAuthenticationService>();

  Future<Result<bool, ErrorResponse>> logInAsync(
      String username, String password) async {
    final result = await _authenticationService.logInAsync(username, password);
    return result;
  }

  Future<void> logoutAsync() async {
    return _authenticationService.logoutAsync();
  }
}
