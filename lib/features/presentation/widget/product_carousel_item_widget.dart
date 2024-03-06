import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class ProductCarouselItemWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductCarouselItemWidget({super.key, required this.product});

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
                product.smallImagePath ?? "",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 30,
            child: Text(product.shortDescription ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: OptiTextStyles.bodySmall),
          ),
          const SizedBox(height: 8),
          Text(
            "\$${product.basicListPrice ?? 0}",
            style: OptiTextStyles.bodySmallHighlight,
          ),
        ],
      ),
    );
  }
}
