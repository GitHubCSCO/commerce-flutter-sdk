import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class ITokenExConfigService {
  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfig(
      {TokenExConfigQueryParameters? parameters});
}
