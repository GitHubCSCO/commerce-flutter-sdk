import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:cookie_jar/cookie_jar.dart';

abstract class IAdminClientService extends IClientService {
  Future<Cookie> get cmsCurrentContentModeSignartureCookie;
}
