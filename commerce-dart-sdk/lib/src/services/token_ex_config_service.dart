import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class TokenExConfigService extends ServiceBase
    implements ITokenExConfigService {
  TokenExConfigService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfig(
      {TokenExConfigQueryParameters? parameters}) async {
    var url = Uri.parse(CommerceAPIConstants.tokenExConfigUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache<TokenExDto>(
      url.toString(),
      TokenExDto.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );
  }
}
