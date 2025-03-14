import 'dart:async';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension on TextJustification? {
  CrossAxisAlignment get crossAxisAlignment {
    switch (this) {
      case TextJustification.left:
        return CrossAxisAlignment.start;
      case TextJustification.center:
        return CrossAxisAlignment.center;
      case TextJustification.right:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }
}

class CarouselItemWidget extends StatelessWidget {
  final CarouselSlideWidgetEntity carouselSlideWidgetEntity;

  const CarouselItemWidget(
      {super.key, required this.carouselSlideWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var link = carouselSlideWidgetEntity.link.makeAbsoluteUrl();

        var trimmedLink = link.trim();

        if (trimmedLink.isNotEmpty) {
          unawaited(launchUrlString(trimmedLink));
        }
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            if (carouselSlideWidgetEntity.background == "image")
              Image.network(
                carouselSlideWidgetEntity.imagePath.makeImageUrl(),
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
              )
            else
              Container(
                color: OptiAppColors.rgbaToColor(
                  carouselSlideWidgetEntity.backgroundColor ?? '',
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: carouselSlideWidgetEntity
                    .textJustification.crossAxisAlignment,
                children: [
                  if (!carouselSlideWidgetEntity.primaryText.isNullOrEmpty)
                    Text(
                      carouselSlideWidgetEntity.primaryText ?? '',
                      style: OptiTextStyles.titleLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        color: OptiAppColors.colorFromHexString(
                          carouselSlideWidgetEntity.primaryTextColorHex ?? '',
                        ),
                      ),
                    ),
                  if (!carouselSlideWidgetEntity
                      .secondaryText.isNullOrEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      carouselSlideWidgetEntity.secondaryText ?? '',
                      style: OptiTextStyles.body.copyWith(
                        color: OptiAppColors.colorFromHexString(
                          carouselSlideWidgetEntity.secondaryTextColorHex ?? '',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
