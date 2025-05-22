class StatusCodeExtension {
  static bool isSuccessStatusCode(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }
}
