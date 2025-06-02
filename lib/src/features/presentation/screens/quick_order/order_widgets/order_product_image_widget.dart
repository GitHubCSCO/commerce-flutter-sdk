import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';

class OrderProductImageWidget extends StatelessWidget {
  final String imagePath;

  const OrderProductImageWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26.0, 22.0, 0.0, 0.0),
      child: Container(
        width: 65,
        height: 65,
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
