import 'dart:convert';

import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/carousel_slider/carousel_slider.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/product_details/product_details_carousel_item_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/full_screen_iamge_carousel_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullScreenImageCarouselPage extends StatefulWidget {
  final List<ProductImageEntity> images;
  final int initialIndex;

  const FullScreenImageCarouselPage({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<FullScreenImageCarouselPage> createState() =>
      _FullScreenImageCarouselPageState();
}

class _FullScreenImageCarouselPageState
    extends State<FullScreenImageCarouselPage> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    return Scaffold(
      backgroundColor: Colors.white, // Ensure white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close,
              color: Colors.black), // Updated icon color
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Full-screen Carousel
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              final productImageEntity = images[index];
              return _buildCarouselItem(productImageEntity);
            },
            options: CarouselOptions(
              initialPage: widget.initialIndex,
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              height: double.infinity,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),

          // Dot indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                final index = entry.key;
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.black
                        : Colors.black.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(ProductImageEntity productImageEntity) {
    final is360 =
        (productImageEntity.imageType ?? '').trim().toLowerCase() == '360';
    if (is360) {
      // Build 360° Image WebView with restricted gesture area
      return Container(
        color: Colors.white, // Match the container background to the Scaffold
        child: Center(child: _build360Image(productImageEntity)),
      );
    } else {
      // Build a normal Image
      return Center(
        child: Image.network(
          productImageEntity.mediumImagePath?.makeImageUrl() ?? '',
          fit: BoxFit.fitWidth,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white, // Match the background color
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, color: Colors.grey),
            );
          },
        ),
      );
    }
  }

  Widget _build360Image(ProductImageEntity productImageEntity) {
    final htmlString = _sirv360HtmlContent(
      productImageEntity.mediumImagePath ?? '',
    );

    // Minimal WebView usage
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.dataFromString(
          htmlString,
          mimeType: 'text/html',
          encoding: utf8,
        ),
      );

    return FractionallySizedBox(
      widthFactor: 0.8, // Restrict the WebView size to allow carousel swipe
      child: WebViewWidget(
        controller: controller,
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(
            () =>
                EagerGestureRecognizer(), // WebView captures gestures inside its bounds
          ),
        },
      ),
    );
  }

  String _sirv360HtmlContent(String imagePath) {
    if (imagePath.isEmpty) return '';
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <script src="https://scripts.sirv.com/sirv.js"></script>
</head>
<body style="margin:0; padding:0; background-color:#fff;"> <!-- Match background -->
  <div class="Sirv"
       style="width:100%; height:100%;"
       data-src="$imagePath?fullscreen=false&spinOnAnyDrag=true"
       data-mobile-options="spinOnAnyDrag:true;">
  </div>
</body>
</html>
''';
  }
}
