import 'package:commerce_flutter_sdk/src/core/utils/color_utils.dart';
import 'dart:async';

import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/carousel_bacground_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

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
            if (carouselSlideWidgetEntity.background ==
                CarouselBacgroundType.color.name)
              Container(
                color: ColorUtils.rgbaToColor(
                  carouselSlideWidgetEntity.backgroundColor ?? '',
                ),
              )
            else
              Image.network(
                carouselSlideWidgetEntity.imagePath.makeImageUrl(),
                fit: BoxFit.fitWidth,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // This function is called when the image fails to load
                  return Container(
                    color: context.colors.backgroundGray, // Placeholder color
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image, // Icon to display
                      color: Colors.grey, // Icon color
                      size: 90, // Icon size
                    ),
                  );
                },
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
                      style: context.text.titleLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        color: ColorUtils.colorFromHexString(
                          carouselSlideWidgetEntity.primaryTextColorHex ?? '',
                        ),
                      ),
                    ),
                  if (!carouselSlideWidgetEntity
                      .secondaryText.isNullOrEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      carouselSlideWidgetEntity.secondaryText ?? '',
                      style: context.text.body.copyWith(
                        color: ColorUtils.colorFromHexString(
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
