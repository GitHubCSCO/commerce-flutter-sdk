class UrlValidator {
  static bool isValidUrl(String url) {
    Uri uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return false;
    }

    // Check if the URL is valid and ends with .com
    return uri.hasScheme && uri.hasAuthority && url.endsWith('.com');
  }
}
