import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';

abstract class IClientService {
  String? host;
  Uri? get url;
  bool? isSecure;
  Future<String?> get sessionStateKey;
  String? errorMessage;

  Stream<AuthSDKStatus> get authStatusStream;

  Future<Result<TokenResult, ErrorResponse>> generate(
      String? userName, String? password);

  Future<String?> getAccessToken();

  Future<Result<bool, ErrorResponse>> renewAuthenticationTokens();

  Future<bool> isAccessTokenExpired();

  Future<void> storeAccessToken(TokenResult tokens);

  Future<void> storeSessionState({Session? currentSession});

  Future<void> removeAccessToken();

  Future<bool> isExistsAccessToken();

  Dio getHttpClient();

  void setBearerAuthorizationHeader(String token);

  void setBasicAuthorizationHeader();

  Future<void> reset();

  Future<Result<Response, ErrorResponse>> getAsync(String path,
      {Duration? timeout,
      CancelToken? cancelToken,
      ResponseType responseType = ResponseType.json});

  Future<Result<Response, ErrorResponse>> postAsync(
      String path, Map<String, dynamic> data,
      {Duration? timeout, CancelToken? cancelToken});

  Future<Result<Response, ErrorResponse>> deleteAsync(String path,
      {Duration? timeout, CancelToken? cancelToken});

  Future<Result<Response, ErrorResponse>> patchAsync(
      String path, Map<String, dynamic> data,
      {Duration? timeout, CancelToken? cancelToken});

  /// Removes AlternateCart cookie from CookieCollection that was set by CreateAlternateCart from ICartService
  Future<void> removeAlternateCartCookie();

  Future<void> removeOrderApprovalCookieIfAvailable();

  Future<bool> isCustomerOrderApproval();
}
