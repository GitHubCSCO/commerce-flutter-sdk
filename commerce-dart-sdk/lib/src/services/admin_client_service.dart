import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:cookie_jar/cookie_jar.dart';

class AdminClientService extends ClientService implements IAdminClientService {
  @override
  Future<Cookie> get cmsCurrentContentModeSignartureCookie async {
    var cookies = await this.cookies;
    if (cookies.isNotEmpty) {
      for (Cookie cookie in cookies) {
        if (cookie.name == "cms_CurrentContentModeSignature") {
          return cookie;
        }
      }
    }

    return Cookie("cms_CurrentContentModeSignature", '');
  }

  AdminClientService(
      {required super.localStorageService,
      required super.secureStorageService,
      required super.loggerService,
      required super.authStreamService});

  @override
  String clientId = "isc_admin";

  @override
  String get clientSecret => "F684FC94-B3BE-4BC7-B924-636561177C8F";

  @override
  set clientSecret(clientSecret) => this.clientSecret = clientSecret;

  @override
  String get bearerTokenStorageKey => "admin_bearerToken";

  @override
  String get refreshTokenStorageKey => "admin_refreshToken";

  @override
  String get expiresInStorageKey => "admin_expiresIn";

  @override
  String get apiScopeKey => "isc_admin_api";

  @override
  String get cookiesStorageKey => "admin_cookies";

  @override
  List<String> get storedCookiesName => ["cms_CurrentContentModeSignature"];
}
