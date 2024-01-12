import 'package:flutter/material.dart';

class ProductCarouselItemWidget extends StatelessWidget {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://www.deere.com/assets/images/region-3/products/tractors/heavy-tractors/tractor-8270r-estudio.png",
              width: 108,
              height: 80,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 30,
            child: Text(
              'Cafe Valet® Barista Single-Serve Coffee Maker',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$449.99',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}