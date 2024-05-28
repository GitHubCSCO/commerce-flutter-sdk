import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:flutter/material.dart';

class LineItemPricingWidget extends StatelessWidget {
  final String? discountMessage;
  final String? priceValueText;
  final String? unitOfMeasureValueText;
  final String? availabilityText;
  final bool showViewQuantityPricing;
  final bool showViewAvailabilityByWarehouse;

  const LineItemPricingWidget({
    super.key,
    this.discountMessage,
    this.priceValueText,
    this.unitOfMeasureValueText,
    this.availabilityText,
    this.showViewQuantityPricing = true,
    this.showViewAvailabilityByWarehouse = true,
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
              _buildDiscountMessageSection(
                context,
                discountMessage: discountMessage,
              ),
              _buildPricingSection(
                context,
                priceValueText: priceValueText,
                unitOfMeasureValueText: unitOfMeasureValueText,
              ),
              if (showViewQuantityPricing)
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
              availabilityText != null
                  ? _buildInventorySection(
                      context,
                      availabilityText: availabilityText,
                    )
                  : Container(),
              // _buildInventorySection(context),
              // For "View Availability by Warehouse"
              if (showViewAvailabilityByWarehouse)
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
  BuildContext context, {
  String? discountMessage,
}) {
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
  return const SizedBox.shrink();
}

Widget _buildPricingSection(
  BuildContext context, {
  String? priceValueText,
  String? unitOfMeasureValueText,
}) {
  return Row(
    children: [
      Text(priceValueText ?? '', style: OptiTextStyles.bodySmallHighlight),
      Text(unitOfMeasureValueText ?? '', style: OptiTextStyles.bodySmall),
    ],
  );
}

Widget _buildInventorySection(
  BuildContext context, {
  String? availabilityText,
}) {
  return Text(
    availabilityText ?? '',
    style: OptiTextStyles.body,
  );
}
