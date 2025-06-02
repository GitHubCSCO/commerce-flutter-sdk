import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AuthenticationService extends ServiceBase
    implements IAuthenticationService {
  AuthenticationService({
    required this.sessionService,
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  ISessionService sessionService;

  @override
  Future<Result<bool, ErrorResponse>> isAuthenticatedAsync() async {
    if (await clientService.isExistsAccessToken()) {
      var response = await sessionService.getCurrentSession();

      switch (response) {
        case Success(value: final value):
          {
            var currentSession = value;
            if (currentSession != null) {
              if (currentSession.isAuthenticated!) {
                return const Success(true);
              } else {
                var renewResponse =
                    await clientService.renewAuthenticationTokens();
                switch (renewResponse) {
                  case Success(value: final value):
                    {
                      var renewed = value;
                      if (renewed == true) {
                        return const Success(true);
                      } else {
                        return const Success(false);
                      }
                    }
                  case Failure(errorResponse: final errorResponse):
                    {
                      return Failure(errorResponse);
                    }
                }
              }
            }
          }

        case Failure(errorResponse: final errorResponse):
          {
            return Failure(errorResponse);
          }
      }
    }

    return const Success(false);
  }

  @override
  Future<Result<bool, ErrorResponse>> logInAsync(
      String userName, String password) async {
    var result = await clientService.generate(userName, password);

    switch (result) {
      case Success(value: final value):
        {
          var tokenResult = value;
          if (tokenResult == null) {
            return const Success(false);
          }

          clientService.setBearerAuthorizationHeader(tokenResult.accessToken!);
          await clientService.storeSessionState();

          var session = Session(userName: userName, password: password);
          var sessionCreatedResult = await sessionService.postSession(session);

          switch (sessionCreatedResult) {
            case Success(value: final value):
              {
                var createdSession = value;
                if (createdSession == null) {
                  clientService.setBasicAuthorizationHeader();
                  return Failure(ErrorResponse.empty());
                }

                var response =
                    await sessionService.patchSession(createdSession);

                switch (response) {
                  case Success(value: final value):
                    {
                      var sessionPatchResult = value;
                      if (sessionPatchResult == null) {
                        clientService.setBasicAuthorizationHeader();
                        return Failure(ErrorResponse.empty());
                      }

                      return const Success(true);
                    }

                  case Failure(errorResponse: final errorResponse):
                    {
                      return Failure(errorResponse);
                    }
                }
              }

            case Failure(errorResponse: final errorResponse):
              {
                clientService.setBasicAuthorizationHeader();
                return Failure(errorResponse);
              }
          }
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<void> logoutAsync({bool isRefreshTokenExpired = false}) async {
    await sessionService.deleteCurrentSession();
    await clientService.reset();

    await clientService.removeAccessToken();
  }
}
