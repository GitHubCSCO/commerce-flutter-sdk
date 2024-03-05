import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

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
              '${updatePriceValueText()} ${updateUnitOfMeasure()}',
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          },
        ],
      ),
    );
  }

  String updateUnitOfMeasure() {
    if (!(productCarousel.productPricingEnabled ?? false)) {
      return '';
    }

    String uomText = productCarousel.product?.getUnitOfMeasure() ?? '';

    if (productCarousel.product?.pricing != null && !(productCarousel.product?.pricing?.isOnSale ?? false)) {
      uomText = productCarousel.product?.pricing?.getUnitOfMeasure(uomText) ?? '';
    }

    return uomText.isNullOrEmpty ? '' : " / $uomText";
  }

  String updatePriceValueText() {
    if (productCarousel.product != null && (productCarousel.product!.quoteRequired ?? false)) {
      return LocalizationConstants.requiresQuote;
    }

    final priceDisplay = (productCarousel.product?.pricing != null && (productCarousel.product!.pricing!.isOnSale ?? false))
        ? productCarousel.product!.pricing!.unitNetPriceDisplay
        : productCarousel.product?.pricing?.getPriceValue() ?? '';

    return (productCarousel.productPricingEnabled ?? false) ? priceDisplay! : SiteMessageConstants.valuePricingSignInForPrice;
  }

}
