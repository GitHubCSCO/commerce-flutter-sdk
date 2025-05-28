import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IAdminAuthenticationService extends IAuthenticationService {
  Future<Result<bool, ErrorResponse>> forgotPassword(String userName);
}
