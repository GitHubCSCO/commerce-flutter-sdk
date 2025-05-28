enum AuthSDKStatus { unknown, loggedIn, loggedOut }

abstract class IAuthStreamService {
  Stream<AuthSDKStatus> get authStatusStream;
  AuthSDKStatus get status;

  void logout();
  void dispose();
}
