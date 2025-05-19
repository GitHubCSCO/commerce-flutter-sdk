import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('ImageUtils', () {
    test('createImageUrl', () {
      final mainUrl = 'https://example.com/';
      final imagePath = 'images/image.jpg';
      final expectedUrl = 'https://example.com/images/image.jpg';

      final imageUrl = ImageUtils.createImageUrl(mainUrl, imagePath);

      expect(imageUrl, expectedUrl);
    });
  });
}
