import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AdminAuthenticationService extends AuthenticationService
    implements IAdminAuthenticationService {
  AdminAuthenticationService({
    required super.clientService,
    required super.sessionService,
    required this.adminClientService,
    required super.cacheService,
    required super.networkService,
  });

  IAdminClientService adminClientService;

  /// Logs a user into the server, then returns whether or not it was successful
  ///
  /// [userName] User's username
  ///
  /// [password] User's password
  ///
  /// [Returns] Whether or not Login was successful
  @override
  Future<Result<bool, ErrorResponse>> logInAsync(
      String userName, String password) async {
    final result =
        await adminClientService.generate("admin_$userName", password);

    switch (result) {
      case Success(value: final value):
        {
          TokenResult? tokenResult = value;
          if (tokenResult == null) {
            return const Success(false);
          }

          adminClientService
              .setBearerAuthorizationHeader(tokenResult.accessToken ?? '');
          adminClientService.storeSessionState();

          return const Success(true);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  /// Logs the current user out of the server, then resets the currently stored session to a non-authenticated state
  ///
  /// [isRefreshTokenExpired] Whether or not logout was due to refresh token being expired
  @override
  Future<void> logoutAsync({bool isRefreshTokenExpired = false}) async {
    await adminClientService.getAsync(
      'identity/connect/endsession',
      timeout: ServiceBase.defaultRequestTimeout,
    );

    adminClientService.reset();
    adminClientService.removeAccessToken();
  }

  /// Checks whether or not the application is currently logged in
  ///
  /// [returns] Boolean value for whether or not user is logged in
  @override
  Future<Result<bool, ErrorResponse>> isAuthenticatedAsync() async {
    bool isAuthenticated = await adminClientService.isExistsAccessToken();
    if (isAuthenticated) {
      await adminClientService.getAsync(
        CommerceAPIConstants.adminUserProfileUrl,
        timeout: ServiceBase.defaultRequestTimeout,
      );

      return Success(isAuthenticated);
    }

    return const Success(false);
  }

  /// Sends a request to the server to start the reset password flow for the given userName
  ///
  /// [userName] User's username
  ///
  /// [returns] Whether or not request was a success

  @override
  Future<Result<bool, ErrorResponse>> forgotPassword(String userName) async {
    Map<String, String> payload = {"userName": userName};

    var response = await adminClientService.postAsync(
      CommerceAPIConstants.resetPasswordUrl,
      payload,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (response) {
      case Success():
        {
          return const Success(true);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }
}
