import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IAuthenticationService {
  Future<Result<bool, ErrorResponse>> logInAsync(
      String userName, String password);

  Future<void> logoutAsync({bool isRefreshTokenExpired = false});

  Future<Result<bool, ErrorResponse>> isAuthenticatedAsync();
}
