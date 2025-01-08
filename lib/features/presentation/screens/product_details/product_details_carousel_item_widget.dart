import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/widget/web_view_360.dart';
import 'package:flutter/material.dart';

class ProductDetailsCarouselItemWidget extends StatelessWidget {
  final ProductImageEntity productImageEntity;

  const ProductDetailsCarouselItemWidget({
    Key? key,
    required this.productImageEntity,
  }) : super(key: key);

  String _image360HtmlContent(String imagePath) {
    if (imagePath.isEmpty) {
      return '';
    }

    return '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
      <script src="https://scripts.sirv.com/sirv.js"></script>
    </head>
    <body>
      <div class="Sirv"
          data-src="$imagePath?fullscreen=false&spinOnAnyDrag=false"
          data-mobile-options="spinOnAnyDrag:false;">
      </div>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    if ((productImageEntity.imageType ?? '').toLowerCase() == '360') {
      final htmlString = _image360HtmlContent(
        productImageEntity.mediumImagePath ?? '',
      );
      return WebView360Widget(htmlString: htmlString);
    } else {
      return Image.network(
        productImageEntity.mediumImagePath.makeImageUrl(),
        fit: BoxFit.fitWidth,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return Container(
            color: OptiAppColors.backgroundGray,
            alignment: Alignment.center,
            child: const Icon(
              Icons.image,
              color: Colors.grey,
              size: 90,
            ),
          );
        },
      );
    }
  }
}
