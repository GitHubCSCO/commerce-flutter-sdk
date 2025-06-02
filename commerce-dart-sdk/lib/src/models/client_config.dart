class ClientConfig {
  ClientConfig._();

  static String? hostUrl;
  static String? clientId;
  static String? clientSecret;

  static void initClientConfig(
    String? hostUrl,
    String? clientId,
    String? clientSecret,
  ) {
    ClientConfig.hostUrl = hostUrl;
    ClientConfig.clientId = clientId;
    ClientConfig.clientSecret = clientSecret;
  }

  static final instance = ClientConfig._();
}
