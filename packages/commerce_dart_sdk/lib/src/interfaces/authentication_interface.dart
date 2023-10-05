import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

abstract class IAuthenticationService {
  Future<ServiceResponse<bool>> logInAsync(String userName, String password);

  Future<void> logoutAsync({bool isRefreshTokenExpired = false});

  Future<ServiceResponse<bool>> isAuthenticatedAsync();
}
