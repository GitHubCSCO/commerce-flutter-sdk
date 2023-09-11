import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

class ClientService implements IClientService {
  ILocalStorageService localStorageService;

  ClientService({required this.localStorageService}) {
    createClient();
  }

  void createClient() {
    client = http.Client();
  }

  late http.Client client;
  Map<String, String> headers = {};

  String? get clientId => ClientConfig.clientId;
  set clientID(clientId) => ClientConfig.clientId = clientId;

  String? get clientSecret => ClientConfig.clientSecret;
  set clientSecret(clientSecret) => ClientConfig.clientSecret = clientSecret;

  String get bearerTokenStorageKey => "bearerToken";
  String get refreshTokenStorageKey => "refreshToken";
  String get expiresInStorageKey => "expiresIn";
  String get apiScopeKey => "iscapi";
  String get cookiesStorageKey => "cookies";

  @override
  String? errorMessage;

  @override
  String? host;

  @override
  bool? isSecure;

  @override
  String? sessionStateKey;

  @override
  Uri? url;
  
  void setBasicAuthorizationHeader() {
    final authorizationHeaderSuffix = '$clientId:$clientSecret';

    headers['Authorization'] =
        'Basic ${base64Encode(authorizationHeaderSuffix)}';
  }

  void setBearerAuthorizationHeader(String token) {
    headers['Authorization'] = 'Bearer $token';
  }

  Future<http.Response> sendRequestUpToTwiceIfNeededAsync(
      http.Request request) async {

    request.headers.addAll(headers);    
    var response = await client.send(request);

    if (response.statusCode == HttpStatus.forbidden ||
        response.statusCode == HttpStatus.unauthorized) {
      String? token = localStorageService.load(bearerTokenStorageKey);
      if (token.isNullOrEmpty) return await http.Response.fromStream(response);

      request.headers.addAll(headers);
      response = await client.send(request);
    }

    return await http.Response.fromStream(response);
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

    var request = http.Request(
        'POST', Uri.parse('${ClientConfig.hostUrl}/identity/connect/token'));

    request.bodyFields = {
      'grant_type': 'password',
      'username': userName!,
      'password': password!,
      'scope': 'iscapi offline_access'
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    String responseStr = await response.stream.bytesToString();

    if (response.statusCode != 200) {
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
    String? timestampStr = localStorageService.load('expiresIn');
    if (!timestampStr.isNullOrEmpty) {
      double timestamp = double.parse(timestampStr!);
      if (timestamp < DateTime.now().toUtc().millisecond) {
        bool result = await renewAuthenticationTokens();
        if (!result) return '';
      }
    }

    return localStorageService.load('bearerToken');
  }

  @override
  bool isExistsAccessToken() {
    var bearerToken = localStorageService.load('bearerToken');
    return !bearerToken.isNullOrEmpty;
  }

  @override
  Future<void> removeAccessToken() async {
    localStorageService.remove('bearerToken');
    localStorageService.remove('refreshToken');
    localStorageService.remove('expiresIn');
  }

  @override
  Future<void> storeAccessToken(TokenResult token) async {
    localStorageService.save('bearerToken', token.accessToken!);
    localStorageService.save('refreshToken', token.refreshToken!);

    var timeSpan =
        DateTime.now().toUtc().add(Duration(seconds: token.expiresIn!));

    localStorageService.save('expiresIn', timeSpan.millisecond.toString());
  }

  String? base64Encode(String? plainText) {
    final bytes = utf8.encode(plainText!);
    final base64str = base64.encode(bytes);

    return base64str;
  }

  @override
  Future<bool> renewAuthenticationTokens() async {
    String refreshToken = localStorageService.load('refreshToken')!;

    headers = {};

    var request = http.Request(
        'POST', Uri.parse('${ClientConfig.hostUrl}/identity/connect/token'));

    request.bodyFields = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': ClientConfig.clientId ?? '',
      'client_secret': ClientConfig.clientSecret ?? '',
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      return false;
    }

    var responseStr = await response.stream.bytesToString();

    TokenResult token = TokenResult.fromJson(json.decode(responseStr));

    storeAccessToken(token);
    setBearerAuthorizationHeader(token.accessToken!);

    /// TODO - storeSessionState

    return true;
  }

  Future<http.Response> getAsync(String path, {Duration? timeout}) async {
    var request = http.Request('GET', Uri.parse(path));
    var response = await sendRequestUpToTwiceIfNeededAsync(request);

    return response;
  }
}
