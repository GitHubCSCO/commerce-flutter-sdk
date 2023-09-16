import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

class AuthenticationService extends ServiceBase
    implements IAuthenticationService {
  AuthenticationService({
    required IClientService clientService,
    required ISessionService sessionService,
  }) : super(clientService: clientService);

  @override
  Future<ServiceResponse<bool>> isAuthenticatedAsync() {
    // TODO: implement isAuthenticatedAsync
    throw UnimplementedError();
  }

  @override
  Future<ServiceResponse<bool>> logInAsync(
      String userName, String password) async {
    var result = await clientService.generate(userName, password);
    TokenResult? tokenResult = result.model;

    if (tokenResult == null) {
      return ServiceResponse<bool>(
        model: false,
        error: result.error ?? ErrorResponse.empty(),
        statusCode: result.statusCode,
      );
    }

    /// TODO - add SessionService implementation

    return ServiceResponse<bool>(
      model: true,
      statusCode: result.statusCode,
    );
  }

  @override
  Future<void> logoutAsync({bool isRefreshTokenExpired = false}) {
    // TODO: implement logoutAsync
    throw UnimplementedError();
  }
}
