class ImageUtils {
  static String createImageUrl(String mainUrl, String imagePath) {
    final Uri mainUri = Uri.parse(mainUrl);
    final String imageUrl = mainUri.resolve(imagePath).toString();
    return imageUrl;
  }
}
