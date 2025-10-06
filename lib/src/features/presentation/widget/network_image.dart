import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const NetworkImageWithFallback({
    super.key,
    this.imageUrl,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imageUrl!,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: OptiAppColors.backgroundGray,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 20,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: OptiAppColors.backgroundGray,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: OptiAppColors.backgroundGray,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: const Icon(
          Icons.image,
          color: Colors.grey,
          size: 20,
        ),
      );
    }
  }
}