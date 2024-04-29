import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';

class ProductDetailsCarouselItemWidget extends StatelessWidget {
  final ProductImageEntity productImageEntity;

  const ProductDetailsCarouselItemWidget(
      {super.key, required this.productImageEntity});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      productImageEntity.mediumImagePath.makeImageUrl(),
      fit: BoxFit.fitWidth,
      errorBuilder: (BuildContext context, Object error,
          StackTrace? stackTrace) {
        // This function is called when the image fails to load
        return Container(
          color: OptiAppColors.backgroundGray, // Placeholder color
          alignment: Alignment.center,
          child: const Icon(
            Icons.image, // Icon to display
            color: Colors.grey, // Icon color
            size: 90, // Icon size
          ),
        );
      },
    );
  }
}
