import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension UrlStringExtensions on String {
  String makeValidUrl() {
    String urlString = this;
    if (urlString.isNotEmpty) {
      if (!urlString.startsWith("http")) {
        urlString = "https://$urlString";
      }

      // handle urls with whitespace
      urlString = Uri.encodeFull(urlString);
    }

    if (Uri.parse(urlString).isAbsolute) {
      return urlString;
    }

    return '';
  }

  String makeSimpleUrl() {
    String urlString = this;
    if (urlString.isNotEmpty) {
      if (urlString.contains("https://")) {
        urlString = urlString.replaceAll("https://", '');
      } else if (urlString.contains("http://")) {
        urlString = urlString.replaceAll("http://", '');
      }

      if (urlString.startsWith("www.")) {
        urlString = urlString.replaceFirst("www.", '');
      }

      // handle urls with whitespace
      urlString = Uri.encodeFull(urlString);
    }

    return urlString;
  }

  String makeImageUrl({bool useNotImageImage = true}) {
    String imagePath = this;
    if (imagePath.isEmpty) {
      if (useNotImageImage) {
        return '';
      } else {
        return '';
      }
    }

    if (imagePath.startsWith("http")) {
      return imagePath;
    }

    if (imagePath.startsWith("/")) {
      imagePath = imagePath.substring(1);
    }

    var clientService = sl<IClientService>();
    return "${clientService.url.toString()}$imagePath";
  }

  String makeAbsoluteUrl() {
    String path = this;
    if (path.isEmpty) {
      return '';
    }

    if (path.startsWith("http") || path.startsWith("www.")) {
      return path;
    }

    if (path.startsWith("/")) {
      path = path.substring(1);
    }

    var clientService = sl<IClientService>();
    return "${clientService.url.toString()}$path";
  }
}
