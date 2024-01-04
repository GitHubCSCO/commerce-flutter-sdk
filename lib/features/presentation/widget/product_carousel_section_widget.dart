import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_item_widget.dart';
import 'package:flutter/material.dart';

class ProductCarouselSectionWidget extends StatelessWidget {
  final String title;

  const ProductCarouselSectionWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 236,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 0.10,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return ProductCarouselItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }
}
