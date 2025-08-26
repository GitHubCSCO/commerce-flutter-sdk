import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:optimizely_commerce_api/src/constants/header_constants.dart';
import 'package:optimizely_commerce_api/src/interfaces/auth_stream_service_interface.dart';
import 'package:optimizely_commerce_api/src/utils/commerce_cookie_jar.dart';

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
  ILoggerService loggerService;
  IAuthStreamService authStreamService;

  ClientService({
    required this.localStorageService,
    required this.secureStorageService,
    required this.loggerService,
    required this.authStreamService,
  }) {
    _createClient();
  }

  Future<void>? _sessionLoadingCompletedState;

  void _createClient() {
    var baseOptions = BaseOptions(
      headers: {
        Headers.contentTypeHeader: Headers.jsonContentType,
        HeaderConstants.userAgentHeader: HeaderConstants.userAgentType,
      },
    );
    client = Dio(baseOptions);
    cookieJar = CommerceCookieJar();
    client.interceptors.add(CookieManager(cookieJar));
    if (loggerService.isApiLogEnabled) {
      client.interceptors.add(LoggerInterceptor());
    }

    client.interceptors
        .add(InterceptorsWrapper(onError: (DioException e, handler) async {
      String refreshToken =
          (await secureStorageService.load('refreshToken')) ?? "";
      var accessTokenIsExpired = await isAccessTokenExpired();
      if (e.response?.statusCode == 401 &&
          !isRefreshingToken &&
          !refreshToken.isNullOrEmpty &&
          accessTokenIsExpired) {
        isRefreshingToken = true;

        var response = await client.postUri(
            Uri.parse('/${CommerceAPIConstants.tokenUrl}'),
            data: {
              'grant_type': 'refresh_token',
              'refresh_token': refreshToken,
              'client_id': clientId ?? '',
              'client_secret': clientSecret ?? '',
            },
            options: Options(contentType: Headers.formUrlEncodedContentType));

        if (!StatusCodeExtension.isSuccessStatusCode(response.statusCode!)) {
          await removeAccessToken();
          isRefreshingToken = false;
          return;
        }

        var responseStr = response.data;
        TokenResult token = TokenResult.fromJson(responseStr);

        await storeAccessToken(token);
        setBearerAuthorizationHeader(token.accessToken!);
        await storeSessionState();

        isRefreshingToken = false;

        final opts = Options(
            method: e.requestOptions.method, headers: e.requestOptions.headers);
        final cloneReq = await client.request(e.requestOptions.path,
            options: opts,
            data: e.requestOptions.data,
            queryParameters: e.requestOptions.queryParameters);

        return handler.resolve(cloneReq);
      }
      return handler.next(e);
    }));
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

  bool isRefreshingToken = false;
  Completer<void>? _refreshCompleter;

  Future<List<Cookie>> get cookies async {
    var cookiesFuture = cookieJar.loadForRequest(url!);
    return await cookiesFuture;
  }

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
      _sessionLoadingCompletedState = loadSessionState();
    }

    if (_host.isNullOrEmpty) {
      f(value);
    } else if (_host != value) {
      f(value);
    }
    client.options.baseUrl = 'https://$value';
  }

  @override
  String? get host => _host;

  @override
  bool? isSecure;

  @override
  Future<String?> get sessionStateKey async {
    String result = '+cookies:';
    var cookies = await this.cookies;
    if (cookies.isEmpty) {
      return result;
    }

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
  Uri? get url => Uri.parse("${client.options.baseUrl}/");

  @override
  Future<void> storeSessionState({Session? currentSession}) async {
    await _storeCookies(currentSession: currentSession);
  }

  Future<void> _storeCookies({Session? currentSession}) async {
    var cookies = await this.cookies;
    if (cookies.isEmpty) {
      return;
    }

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

  Future<void> _loadCookies() async {
    var cookies = await this.cookies;
    String cookieValues =
        (await localStorageService.load(cookiesStorageKey)) ?? '';
    if (cookieValues.isEmpty) {
      return;
    }

    for (String cookieValue in cookieValues.split('|')) {
      if (cookieValue.contains('=')) {
        String name = cookieValue.split('=')[0];
        String value = cookieValue.split('=')[1];

        cookies.add(Cookie(name, value));
      }
    }

    await cookieJar.saveFromResponse(url!, cookies);
  }

  Future<void> loadSessionState() async {
    String accessToken =
        await secureStorageService.load(bearerTokenStorageKey) ?? '';
    if (accessToken.isNotEmpty) {
      setBearerAuthorizationHeader(accessToken);
    }

    await _loadCookies();
  }

  @override
  void setBasicAuthorizationHeader() {
    final authorizationHeaderSuffix = '$clientId:$clientSecret';

    client.options.headers[HttpHeaders.authorizationHeader] =
        'Basic ${base64Encode(authorizationHeaderSuffix)}';
  }

  @override
  void setBearerAuthorizationHeader(String token) {
    client.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  Future<Result<Response, ErrorResponse>> _requestSwitcher(
    RequestMessage request, {
    CancelToken? cancelToken,
  }) async {
    try {
      var accessTokenIsExpired = await isAccessTokenExpired();
      if (accessTokenIsExpired) {
        String refreshToken =
            (await secureStorageService.load('refreshToken')) ?? "";
        if (!refreshToken.isNullOrEmpty && !isRefreshingToken) {
          await renewAuthenticationTokens();
        }
      }

      var methods = {
        'GET': () => client.get(
              request.path,
              cancelToken: cancelToken,
              options: request.options,
            ),
        'POST': () => client.post(
              request.path,
              cancelToken: cancelToken,
              data: request.data,
              options: request.options,
            ),
        'PATCH': () => client.patch(
              request.path,
              cancelToken: cancelToken,
              data: request.data,
              options: request.options,
            ),
        'DELETE': () => client.delete(
              request.path,
              cancelToken: cancelToken,
              options: request.options,
            ),
      };

      var method = methods[request.method];

      if (method != null) {
        var response = await method();

        if (StatusCodeExtension.isSuccessStatusCode(response.statusCode!)) {
          return Success(response);
        } else {
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(response as Map<String, dynamic>);
          return Failure(errorResponse);
        }
      } else {
        return Failure(ErrorResponse(message: 'Invalid method'));
      }
    } on DioException catch (e) {
      final errorResponse = getErrorResponse(e);
      return Failure(
        errorResponse,
      );
    }
  }

  Future<Result<Response, ErrorResponse>> _sendRequestUpToTwiceIfNeededAsync(
      RequestMessage request,
      {CancelToken? cancelToken}) async {
    if (_sessionLoadingCompletedState != null) {
      await _sessionLoadingCompletedState;
    } else {
      Failure(ErrorResponse(message: 'Host is not initialized'));
    }

    var response = await _requestSwitcher(request, cancelToken: cancelToken);

    switch (response) {
      case Success(value: final value):
        {
          if (value?.statusCode == HttpStatus.forbidden ||
              value?.statusCode == HttpStatus.unauthorized) {
            String? token =
                await secureStorageService.load(bearerTokenStorageKey);
            if (token.isNullOrEmpty) {
              return Success(value);
            }

            if (cancelToken!.isCancelled) {
              Failure(ErrorResponse(
                  message:
                      cancelToken.cancelError?.message ?? 'Token is expired'));
            }

            var newRequest = request.copyWith();
            var secondResponse =
                await _requestSwitcher(newRequest, cancelToken: cancelToken);

            switch (secondResponse) {
              case Success(value: final value):
                {
                  return Success(value);
                }

              case Failure(errorResponse: final errorResponse):
                {
                  return Failure(errorResponse);
                }
            }
          }
          return Success(value);
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<TokenResult, ErrorResponse>> generate(
    String? userName,
    String? password,
  ) async {
    if (_sessionLoadingCompletedState != null) {
      await _sessionLoadingCompletedState;
    } else {
      return Failure(ErrorResponse(message: 'Host is not initialized'));
    }

    final authorizationHeaderSuffix = '$clientId:$clientSecret';
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic ${base64Encode(authorizationHeaderSuffix)}',
    };

    try {
      var response = await client.postUri(
        Uri.parse('/${CommerceAPIConstants.tokenUrl}'),
        data: {
          'grant_type': 'password',
          'username': userName!,
          'password': password!,
          'scope': 'iscapi offline_access',
        },
        options: Options(headers: headers),
      );

      var responseData = response.data;

      if (!StatusCodeExtension.isSuccessStatusCode(response.statusCode!)) {
        ErrorResponse error = ErrorResponse.fromJson(responseData);
        return Failure(error);
      }

      TokenResult token = TokenResult.fromJson(responseData);

      await storeAccessToken(token);

      return Success(token, statusCode: response.statusCode);
    } on DioException catch (e) {
      final errorResponse = getErrorResponse(e);
      return Failure(
        errorResponse,
      );
    }
  }

  ErrorResponse getErrorResponse(DioException e) {
    late ErrorResponse errorResponse;
    if (e.response?.data is Map) {
      errorResponse = ErrorResponse.fromJson(e.response?.data);
    } else if (e.response?.data is String) {
      errorResponse = ErrorResponse(message: e.response?.data);
    } else {
      errorResponse = ErrorResponse(message: e.message);
    }
    errorResponse.exception = ServerException(e);
    return errorResponse;
  }

  @override
  Future<bool> isAccessTokenExpired() async {
    String? timestampStr = await secureStorageService.load('expiresIn');
    if (!timestampStr.isNullOrEmpty) {
      DateTime expiryTime = DateTime.parse(timestampStr!);
      DateTime currentTime = DateTime.now();

      if (currentTime.isAfter(expiryTime)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    String? timestampStr = await secureStorageService.load('expiresIn');
    if (!timestampStr.isNullOrEmpty) {
      DateTime expiryTime = DateTime.parse(timestampStr!);
      DateTime currentTime = DateTime.now();
      if (currentTime.isAfter(expiryTime)) {
        var result = await renewAuthenticationTokens();
        switch (result) {
          case Success(value: final value):
            {
              var success = value!;
              if (!success) {
                return '';
              }
            }
          case Failure():
            {
              return '';
            }
        }
      }
    }
    return await secureStorageService.load('bearerToken');
  }

  bool isRenewingAccessTokenProcessing() {
    return isRefreshingToken;
  }

  @override
  Future<bool> isExistsAccessToken() async {
    var bearerToken = await secureStorageService.load('bearerToken');
    return !bearerToken.isNullOrEmpty;
  }

  @override
  Future<void> removeAccessToken() async {
    await secureStorageService.remove('bearerToken');
    await secureStorageService.remove('refreshToken');
    await secureStorageService.remove('expiresIn');

    authStreamService.logout();
  }

  @override
  Future<void> storeAccessToken(TokenResult token) async {
    await secureStorageService.save('bearerToken', token.accessToken!);
    await secureStorageService.save('refreshToken', token.refreshToken!);

    var expiryTime = DateTime.now().add(Duration(seconds: token.expiresIn!));
    await secureStorageService.save('expiresIn', expiryTime.toIso8601String());
  }

  String? base64Encode(String? plainText) {
    final bytes = utf8.encode(plainText!);
    final base64str = base64.encode(bytes);

    return base64str;
  }

  @override
  Future<Result<bool, ErrorResponse>> renewAuthenticationTokens() async {
    if (_refreshCompleter != null) {
      // If a refresh is already in progress, wait for it to complete.
      await _refreshCompleter!.future;
      // After waiting, return the result of the previous refresh attempt.
      return const Success(true);
    }

    _refreshCompleter = Completer();
    isRefreshingToken = true;

    try {
      // Check if session loading is completed
      if (_sessionLoadingCompletedState != null) {
        await _sessionLoadingCompletedState;
      } else {
        return Failure(ErrorResponse(message: 'Host is not initialized'));
      }

      String refreshToken =
          (await secureStorageService.load('refreshToken')) ?? "";

      if (refreshToken.isEmpty) {
        return const Success(false);
      }

      var response = await client.postUri(
        Uri.parse('/${CommerceAPIConstants.tokenUrl}'),
        data: {
          'grant_type': 'refresh_token',
          'refresh_token': refreshToken,
          'client_id': clientId ?? '',
          'client_secret': clientSecret ?? '',
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (!StatusCodeExtension.isSuccessStatusCode(response.statusCode!)) {
        await removeAccessToken();
        return const Success(false);
      }

      var responseStr = response.data;
      TokenResult token = TokenResult.fromJson(responseStr);

      await storeAccessToken(token);
      setBearerAuthorizationHeader(token.accessToken!);
      await storeSessionState();
      _refreshCompleter!.complete();
      return const Success(true);
    } catch (e) {
      isRefreshingToken = false;
      _refreshCompleter!.completeError(e);
      await removeAccessToken();
      return const Success(false);
    } finally {
      isRefreshingToken = false;
      _refreshCompleter = null;
    }
  }

  @override
  Future<Result<Response, ErrorResponse>> getAsync(String path,
      {Duration? timeout,
      CancelToken? cancelToken,
      ResponseType responseType = ResponseType.json}) async {
    // var request = RequestOptions(
    //     path: path, cancelToken: cancelToken, receiveTimeout: timeout);

    var request = RequestMessage(
      method: 'GET',
      path: path,
      options: Options(receiveTimeout: timeout, responseType: responseType),
    );

    var response = await _sendRequestUpToTwiceIfNeededAsync(request,
        cancelToken: cancelToken);

    return response;
  }

  @override
  Future<Result<Response, ErrorResponse>> postAsync(
      String path, Map<String, dynamic> data,
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
  Future<Result<Response, ErrorResponse>> deleteAsync(String path,
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
  Future<Result<Response, ErrorResponse>> patchAsync(
      String path, Map<String, dynamic> data,
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

  @override
  Future<void> reset() async {
    await _storeCookies();
    _resetClientState();
  }

  void _resetClientState() async {
    // Clear authorization headers
    client.options.headers.remove(HttpHeaders.authorizationHeader);

    // Reset refresh token state
    isRefreshingToken = false;
    _refreshCompleter = null;

    await removeAccessToken();

    // Set basic authorization header for post-logout state
    setBasicAuthorizationHeader();
  }

  @override
  Future<void> removeAlternateCartCookie() async {
    var cookies = await this.cookies;

    await Future(() {
      for (Cookie cookie in cookies) {
        if (cookie.name.contains('AlternateCart')) {
          cookie.expires = DateTime.now().subtract(const Duration(days: 1));
          break;
        }
      }
    });

    await cookieJar.saveFromResponse(url!, cookies);
  }

  @override
  Future<bool> isCustomerOrderApproval() async {
    var cookies = await this.cookies;

    for (Cookie cookie in cookies) {
      if (cookie.name.contains('CustomerOrderForApproval')) {
        return true;
      }
    }

    return false;
  }

  @override
  Future<void> removeOrderApprovalCookieIfAvailable() async {
    var cookies = await this.cookies;
    await Future(() {
      for (Cookie cookie in cookies) {
        if (cookie.name.contains('CustomerOrderForApproval')) {
          cookie.expires = DateTime.now().subtract(const Duration(days: 1));
          break;
        }
      }
    });

    await cookieJar.saveFromResponse(url!, cookies);
  }

  @override
  Stream<AuthSDKStatus> get authStatusStream {
    return authStreamService.authStatusStream;
  }
}
