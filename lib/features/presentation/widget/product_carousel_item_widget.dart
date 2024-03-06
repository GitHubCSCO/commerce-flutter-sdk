import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductCarouselItemWidget extends StatelessWidget {
  final ProductCarouselEntity productCarousel;
  final bool isLoading;

  const ProductCarouselItemWidget({super.key, required this.productCarousel, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 108,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                productCarousel.product!.smallImagePath ?? "",
                fit: BoxFit.fitHeight,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  // This function is called when the image fails to load
                  return Container(
                    color: AppColors.grayBackgroundColor, // Placeholder color
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
          const SizedBox(height: 8),
          SizedBox(
            height: 30,
            child: Text(
              productCarousel.product!.shortDescription ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
              ),
            ),
          ),
          if (isLoading) ... {
            Container(
              alignment: Alignment.bottomLeft,
              child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.black87,
                size: 30,
              ),
            ),
          } else ... {
            const SizedBox(height: 8),
            Text(
              '${productCarousel.product.updatePriceValueText(productCarousel.productPricingEnabled)} ${productCarousel.product.updateUnitOfMeasure(productCarousel.productPricingEnabled)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          },
        ],
      ),
    );
  }

}
