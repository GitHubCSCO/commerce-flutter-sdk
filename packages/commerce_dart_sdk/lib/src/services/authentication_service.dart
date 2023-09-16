import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

class AuthenticationService extends ServiceBase
    implements IAuthenticationService {
  AuthenticationService({
    required IClientService clientService,
    required this.sessionService,
  }) : super(clientService: clientService);

  ISessionService sessionService;

  @override
  Future<ServiceResponse<bool>> isAuthenticatedAsync() async {
    if (clientService.isExistsAccessToken()) {
      var response = await sessionService.getCurrentSession();
      var currentSession = response.model;

      if (currentSession != null) {
        if (currentSession.isAuthenticated!) {
          return ServiceResponse<bool>(
            model: true,
            error: response.error,
            exception: response.exception,
            statusCode: response.statusCode,
            isCached: response.isCached,
          );
        }
      }

      await clientService.removeAccessToken();
    }

    return ServiceResponse<bool>(model: false);
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
