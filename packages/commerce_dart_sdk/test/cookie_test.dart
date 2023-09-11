import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

void main() async {
  final dio = Dio();
  final cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  // First request, and save cookies (CookieManager do it).
  await dio.get("https://mobilespire.commerce.insitesandbox.com");
  // Print cookies
  print(await cookieJar.loadForRequest(
      Uri.parse("https://mobilespire.commerce.insitesandbox.com")));
  // Second request with the cookies
  await dio.get('https://mobilespire.commerce.insitesandbox.com');
}
