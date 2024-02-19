import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProductDetailsPricingWidget extends StatelessWidget {
  final ProductDetailsPriceEntity productDetailsPricingEntity;

  const ProductDetailsPricingWidget(
      {required this.productDetailsPricingEntity});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the UI for the ProductDetailsPricingWidget
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Regular Price: \$199.00, you save \$29.00 (15%),",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    color: AppColors.lightGrayTextColor),
              ),
              Container(
                child: Row(
                  children: [
                    Text("\$199.00",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("/ Pallet"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                },
                child: Text("View Quantity Pricing",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
              Container(
                child: Text("1,000 In Stock"),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                },
                child: Text("View Availability by Warehouse",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
