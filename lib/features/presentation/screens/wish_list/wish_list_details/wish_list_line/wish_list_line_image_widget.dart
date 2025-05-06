import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';

class WishListContentProductImageWidget extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const WishListContentProductImageWidget({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(26.0, 22.0, 0.0, 0.0),
      child: Container(
        width: width ?? 65,
        height: height ?? 65,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD6D6D6)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imagePath.makeImageUrl(),
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              // This function is called when the image fails to load
              return Container(
                color: OptiAppColors.backgroundGray, // Placeholder color
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image, // Icon to display
                  color: Colors.grey, // Icon color
                  size: 30, // Icon size
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
