import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:dio/dio.dart';

abstract class IClientService {
  String? host;
  Uri? get url;
  bool? isSecure;
  String? get sessionStateKey;
  String? errorMessage;

  Future<ServiceResponse<TokenResult>> generate(
      String? userName, String? password);

  Future<String?> getAccessToken();

  Future<bool> renewAuthenticationTokens();

  Future<void> storeAccessToken(TokenResult tokens);

  Future<void> removeAccessToken();

  bool isExistsAccessToken();

  Dio getHttpClient();

  Future<Response> getAsync(String path,
      {Duration? timeout, CancelToken? cancelToken});

  Future<Response> postAsync(String path, Map<String, dynamic> data,
      {Duration? timeout, CancelToken? cancelToken});

  Future<Response> deleteAsync(String path,
      {Duration? timeout, CancelToken? cancelToken});
}
