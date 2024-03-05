import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:flutter/widgets.dart';

class ProductDetailsCarouselItemWidget extends StatelessWidget {
  final ProductImageEntity productImageEntity;

  const ProductDetailsCarouselItemWidget(
      {super.key, required this.productImageEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(productImageEntity.mediumImagePath ?? ''),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
