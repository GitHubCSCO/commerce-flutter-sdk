import 'dart:async';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CarouselItemWidget extends StatelessWidget {
  final CarouselSlideWidgetEntity carouselSlideWidgetEntity;

  const CarouselItemWidget(
      {super.key, required this.carouselSlideWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var link = carouselSlideWidgetEntity.link.makeAbsoluteUrl();
        if (link.isNotEmpty) {
          unawaited(launchUrlString(link));
        }
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Image.network(
          carouselSlideWidgetEntity.imagePath.makeImageUrl(),
          fit: BoxFit.fitWidth,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
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
        ),
      ),
    );
  }
}
