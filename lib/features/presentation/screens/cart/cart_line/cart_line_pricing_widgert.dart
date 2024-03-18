import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:flutter/material.dart';

class CartContentPricingWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  const CartContentPricingWidget({
    required this.cartLineEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDiscountMessageSection(context, cartLineEntity),
              _buildPricingSection(context, cartLineEntity),
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Quantity Pricing",
                  style: OptiTextStyles.link,
                ),
              ),
              cartLineEntity.availability?.message != null
                  ? _buildInventorySection(context, cartLineEntity)
                  : Container(),
              // _buildInventorySection(context),
              // For "View Availability by Warehouse"
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Availability by Warehouse",
                  style: OptiTextStyles.link,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDiscountMessageSection(
    BuildContext context, CartLineEntity cartLineEntity) {
  var discountMessage = cartLineEntity.pricing?.getDiscountValue();
  if (discountMessage != null &&
      discountMessage.isNotEmpty &&
      discountMessage != "null") {
    return Text(
      discountMessage,
      style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          color: OptiAppColors.textSecondary),
    );
  }
  return Container();
}

Widget _buildPricingSection(
    BuildContext context, CartLineEntity cartLineEntity) {
  return Container(
    child: Row(
      children: [
        Text(cartLineEntity.updatePriceValueText(),
            style: OptiTextStyles.bodySmallHighlight),
        Text(
          cartLineEntity.updateUnitOfMeasureValueText(),
          style: OptiTextStyles.bodySmall,
        ),
      ],
    ),
  );
}

Widget _buildInventorySection(
    BuildContext context, CartLineEntity cartLineEntity) {
  return Container(
    child: Text(
      cartLineEntity.availability?.message ?? '',
      style: OptiTextStyles.body,
    ),
  );
}
