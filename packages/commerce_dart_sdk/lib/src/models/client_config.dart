class ClientConfig {
  ClientConfig._();

  static String? hostUrl = 'https://mobilespire.commerce.insitesandbox.com/';
  static String? clientId;
  static String? clientSecret;
  static bool isCachingEnabled = true;

  static void initClientConfig(String? hostURL, String? clientId,
      String? clientSecret, bool isCachingEnabled) {
    hostUrl = hostURL;
    clientId = clientId;
    clientSecret = clientSecret;
    isCachingEnabled = isCachingEnabled;
  }
}
