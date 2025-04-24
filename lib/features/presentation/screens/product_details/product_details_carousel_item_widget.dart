import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/web_view_360.dart';
import 'package:flutter/material.dart';

class ProductDetailsCarouselItemWidget extends StatelessWidget {
  final ProductImageEntity productImageEntity;
  final VoidCallback onNormalImageTap;
  final VoidCallback onOpen360Fullscreen;

  const ProductDetailsCarouselItemWidget({
    Key? key,
    required this.productImageEntity,
    required this.onNormalImageTap,
    required this.onOpen360Fullscreen,
  }) : super(key: key);

  String _image360HtmlContent(String imagePath) {
    return '''
  <!DOCTYPE html>
  <html>
    <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
      <script src="https://scripts.sirv.com/sirv.js"></script>
    </head>
    <body>
      <div class="Sirv"
        data-src="$imagePath?fullscreen=false&spinOnAnyDrag=true"
        data-mobile-options="spinOnAnyDrag:true;">
      </div>
    </body>
  </html>
  ''';
  }

  @override
  Widget build(BuildContext context) {
    final bool is360 =
        (productImageEntity.imageType ?? '').toLowerCase() == '360';

    if (is360) {
      // 360 View
      final htmlString = _image360HtmlContent(
        productImageEntity.mediumImagePath ?? '',
      );

      return Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.8, // Set appropriate size for the WebView
              child: WebView360Widget(
                htmlString: htmlString,
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            right: 25,
            child: InkWell(
              onTap: onOpen360Fullscreen,
              child: SizedBox(
                width: 35.0,
                height: 35.0,
                child: SvgAssetImage(
                  assetName: AssetConstants.exapandIcon,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // Normal Image
      return GestureDetector(
        onTap: onNormalImageTap,
        child: Image.network(
          productImageEntity.mediumImagePath.makeImageUrl(),
          fit: BoxFit.fitWidth,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return Container(
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(
                Icons.image,
                color: Colors.grey,
                size: 90,
              ),
            );
          },
        ),
      );
    }
  }
}
