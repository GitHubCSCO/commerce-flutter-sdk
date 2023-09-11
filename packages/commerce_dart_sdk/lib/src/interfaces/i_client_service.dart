import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

abstract class IClientService {
  String? host;
  Uri? url;
  bool? isSecure;
  String? sessionStateKey;
  String? errorMessage;

  Future<ServiceResponse<TokenResult>> generate(
      String? userName, String? password);

  Future<String?> getAccessToken();

  Future<bool> renewAuthenticationTokens();

  Future<void> storeAccessToken(TokenResult tokens);

  Future<void> removeAccessToken();

  bool isExistsAccessToken();
}
