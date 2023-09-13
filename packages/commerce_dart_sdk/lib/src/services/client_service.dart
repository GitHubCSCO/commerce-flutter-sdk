import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class RequestMessage {
  final String method;
  final String path;
  final Map<dynamic, dynamic>? data;
  final Options? options;

  RequestMessage({
    required this.method,
    required this.path,
    this.data,
    this.options,
  });

  RequestMessage copyWith(
      {String? method,
      String? path,
      Map<dynamic, dynamic>? data,
      Options? options}) {
    return RequestMessage(
      method: method ?? this.method,
      path: path ?? this.path,
      data: data ?? this.data,
      options: options ?? this.options,
    );
  }
}

class ClientService implements IClientService {
  ILocalStorageService localStorageService;
  ISecureStorageService secureStorageService;

  ClientService({
    required this.localStorageService,
    required this.secureStorageService,
  }) {
    _createClient();
  }

  void _createClient() {
    client = Dio();
    cookieJar = CookieJar();
    client.interceptors.add(CookieManager(cookieJar));
    host = ClientConfig.hostUrl;
  }

  late Dio client;
  late CookieJar cookieJar;
  // Map<String, String> headers = {};

  String? get clientId => ClientConfig.clientId;
  set clientID(clientId) => ClientConfig.clientId = clientId;

  String? get clientSecret => ClientConfig.clientSecret;
  set clientSecret(clientSecret) => ClientConfig.clientSecret = clientSecret;

  String get bearerTokenStorageKey => "bearerToken";
  String get refreshTokenStorageKey => "refreshToken";
  String get expiresInStorageKey => "expiresIn";
  String get apiScopeKey => "iscapi";
  String get cookiesStorageKey => "cookies";

  List<Cookie> cookies = [];
  final List<String> storedCookiesName = [
    "CurrentPickUpWarehouseId",
    "CurrentFulfillmentMethod",
    "CurrentBillToId",
    "CurrentShipToId",
    "BillToIdShipToId",
    "CurrentLanguageId",
    "SetContextLanguageCode",
    "SetContextPersonaIds",
  ];

  @override
  String? errorMessage;

  String? _host;

  @override
  set host(String? value) {
    if (value == null) {
      _host = value;
      return;
    }

    void f(String val) {
      _host = val;
      client.options.baseUrl = host!;
      ClientConfig.hostUrl = host!;
      loadSessionState();
    }

    if (_host.isNullOrEmpty) {
      f(value);
    } else if (_host != value) {
      f(value);
    }
  }

  @override
  String? get host => _host;

  @override
  bool? isSecure;

  @override
  String? get sessionStateKey {
    String result = '+cookies:';
    if (cookies.isEmpty) return result;

    for (String storedCookieName in storedCookiesName) {
      for (Cookie cookie in cookies) {
        if (cookie.name == storedCookieName) {
          result += '${cookie.name}=${cookie.value}|';
          break;
        }
      }
    }

    return result;
  }

  @override
  Uri? get url => Uri.parse(host!);

  @override
  Future<void> storeSessionState({Session? currentSession}) async {
    await _storeCookies(currentSession: currentSession);
  }

  Future<void> _storeCookies({Session? currentSession}) async {
    if (cookies.isEmpty) return;

    String cookieValues = '';
    for (Cookie cookie in cookies) {
      if (storedCookiesName.contains(cookie.name)) {
        if (currentSession != null &&
            cookie.name == 'CurrentShipToId' &&
            currentSession.shipTo != null) {
          cookie.value = currentSession.shipTo!.id!;
        }

        cookieValues += '${cookie.name}=${cookie.value}|';
      }
    }

    await localStorageService.save(cookiesStorageKey, cookieValues);
  }

  void setCookie(Cookie cookie) {
    cookies.add(cookie);
    cookieJar.saveFromResponse(url!, cookies);
  }

  void _loadCookies() {
    String cookieValues = (localStorageService.load(cookiesStorageKey)) ?? '';
    if (cookieValues.isEmpty) return;

    for (String cookieValue in cookieValues.split('|')) {
      if (cookieValue.contains('=')) {
        String name = cookieValue.split('=')[0];
        String value = cookieValue.split('=')[1];

        cookies.add(Cookie(name, value));
      }
    }

    cookieJar.saveFromResponse(url!, cookies);
  }

  void loadSessionState() {
    String accessToken = secureStorageService.load(bearerTokenStorageKey) ?? '';
    if (accessToken.isNotEmpty) _setBearerAuthorizationHeader(accessToken);

    _loadCookies();
  }

  void _setBasicAuthorizationHeader() {
    final authorizationHeaderSuffix = '$clientId:$clientSecret';

    client.options.headers[HttpHeaders.authorizationHeader] =
        'Basic ${base64Encode(authorizationHeaderSuffix)}';
  }

  void _setBearerAuthorizationHeader(String token) {
    client.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  Future<Response> _sendRequestUpToTwiceIfNeededAsync(RequestMessage request,
      {CancelToken? cancelToken}) async {
    Future<Response> requestSwitcher(RequestMessage request) async {
      if (request.method == 'GET') {
        return await client.get(
          request.path,
          cancelToken: cancelToken,
          options: request.options,
        );
      } else if (request.method == 'POST') {
        return await client.post(
          request.path,
          cancelToken: cancelToken,
          data: request.data,
          options: request.options,
        );
      } else if (request.method == 'PATCH') {
        return await client.patch(
          request.path,
          cancelToken: cancelToken,
          data: request.data,
          options: request.options,
        );
      } else if (request.method == 'DELETE') {
        return await client.delete(
          request.path,
          cancelToken: cancelToken,
          options: request.options,
        );
      } else {
        return Response(requestOptions: RequestOptions());
      }
    }

    var response = await requestSwitcher(request);

    if (response.statusCode == HttpStatus.forbidden ||
        response.statusCode == HttpStatus.unauthorized) {
      String? token = secureStorageService.load(bearerTokenStorageKey);
      if (token.isNullOrEmpty) return response;

      if (cancelToken!.isCancelled) {
        throw cancelToken.cancelError!;
      }

      var newRequest = request.copyWith();
      response = await requestSwitcher(newRequest);
    }

    return response;
  }

  @override
  Future<ServiceResponse<TokenResult>> generate(
      String? userName, String? password) async {
    final authorizationHeaderSuffix =
        '${ClientConfig.clientId}:${ClientConfig.clientSecret}';
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic ${base64Encode(authorizationHeaderSuffix)}',
    };

    var response = await client.postUri(
      Uri.parse('$host/${CommerceAPIConstants.tokenUrl}'),
      data: {
        'grant_type': 'password',
        'username': userName!,
        'password': password!,
        'scope': 'iscapi offline_access',
      },
      options: Options(headers: headers),
    );

    String responseStr = response.data;

    if (!StatusCodeExtension.isSuccessStatusCode(response.statusCode!)) {
      ErrorResponse error = ErrorResponse.fromJson(json.decode(responseStr));
      return ServiceResponse<TokenResult>(
          error: error, statusCode: response.statusCode);
    }

    TokenResult token = TokenResult.fromJson(json.decode(responseStr));

    storeAccessToken(token);
    return ServiceResponse<TokenResult>(
      model: token,
      statusCode: response.statusCode,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    String? timestampStr = secureStorageService.load('expiresIn');
    if (!timestampStr.isNullOrEmpty) {
      double timestamp = double.parse(timestampStr!);
      if (timestamp < DateTime.now().toUtc().millisecond) {
        bool result = await renewAuthenticationTokens();
        if (!result) return '';
      }
    }

    return secureStorageService.load('bearerToken');
  }

  @override
  bool isExistsAccessToken() {
    var bearerToken = secureStorageService.load('bearerToken');
    return !bearerToken.isNullOrEmpty;
  }

  @override
  Future<void> removeAccessToken() async {
    secureStorageService.remove('bearerToken');
    secureStorageService.remove('refreshToken');
    secureStorageService.remove('expiresIn');
  }

  @override
  Future<void> storeAccessToken(TokenResult token) async {
    secureStorageService.save('bearerToken', token.accessToken!);
    secureStorageService.save('refreshToken', token.refreshToken!);

    var timeSpan =
        DateTime.now().toUtc().add(Duration(seconds: token.expiresIn!));

    secureStorageService.save('expiresIn', timeSpan.millisecond.toString());
  }

  String? base64Encode(String? plainText) {
    final bytes = utf8.encode(plainText!);
    final base64str = base64.encode(bytes);

    return base64str;
  }

  @override
  Future<bool> renewAuthenticationTokens() async {
    // client.options.headers.remove(HttpHeaders.authorizationHeader);
    String refreshToken = secureStorageService.load('refreshToken')!;

    var response = await client.postUri(
        Uri.parse('$host/${CommerceAPIConstants.tokenUrl}'),
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': ClientConfig.clientId ?? '',
          'client_secret': ClientConfig.clientSecret ?? '',
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));

    if (!StatusCodeExtension.isSuccessStatusCode(response.statusCode!)) {
      return false;
    }

    var responseStr = response.data;
    TokenResult token = TokenResult.fromJson(jsonDecode(responseStr));

    storeAccessToken(token);
    _setBearerAuthorizationHeader(token.accessToken!);
    storeSessionState();

    return true;
  }

  @override
  Future<Response> getAsync(String path,
      {Duration? timeout, CancelToken? cancelToken}) async {
    // var request = RequestOptions(
    //     path: path, cancelToken: cancelToken, receiveTimeout: timeout);

    var request = RequestMessage(
      method: 'GET',
      path: path,
      options: Options(receiveTimeout: timeout),
    );

    var response = await _sendRequestUpToTwiceIfNeededAsync(request,
        cancelToken: cancelToken);

    return response;
  }

  @override
  Future<Response> postAsync(String path, Map<String, dynamic> data,
      {Duration? timeout, CancelToken? cancelToken}) async {
    var request = RequestMessage(
      method: 'POST',
      path: path,
      options: Options(receiveTimeout: timeout),
      data: data,
    );

    return await _sendRequestUpToTwiceIfNeededAsync(request,
        cancelToken: cancelToken);
  }

  @override
  Future<Response> deleteAsync(String path,
      {Duration? timeout, CancelToken? cancelToken}) async {
    var request = RequestMessage(
      method: 'DELETE',
      path: path,
      options: Options(receiveTimeout: timeout),
    );

    return await _sendRequestUpToTwiceIfNeededAsync(request,
        cancelToken: cancelToken);
  }

  @override
  Future<Response> patchAsync(String path, Map<String, dynamic> data,
      {Duration? timeout, CancelToken? cancelToken}) async {
    var request = RequestMessage(
      method: 'PATCH',
      path: path,
      options: Options(receiveTimeout: timeout),
      data: data,
    );

    return await _sendRequestUpToTwiceIfNeededAsync(request,
        cancelToken: cancelToken);
  }

  @override
  Dio getHttpClient() {
    return client;
  }
}
