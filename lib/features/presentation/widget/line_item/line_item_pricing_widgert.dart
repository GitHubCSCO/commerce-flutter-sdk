import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/widget/view_warehouse_availability_widget.dart';
import 'package:flutter/material.dart';

class LineItemPricingWidget extends StatelessWidget {
  final String? discountMessage;
  final String? priceValueText;
  final String? unitOfMeasureValueText;
  final String? availabilityText;
  final bool showViewQuantityPricing;
  final bool showViewAvailabilityByWarehouse;
  final String? productId;
  final String? erpNumber;
  final String? unitOfMeasure;

  const LineItemPricingWidget({
    super.key,
    this.discountMessage,
    this.priceValueText,
    this.unitOfMeasureValueText,
    this.availabilityText,
    this.showViewQuantityPricing = true,
    this.showViewAvailabilityByWarehouse = false,
    this.productId,
    this.erpNumber,
    this.unitOfMeasure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.white,
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
                  viewWarehouseWidget(context, productId, erpNumber ?? "",
                      unitOfMeasure ?? "");
                },
                child: Text(
                  "View Availability by Warehouse",
                  style: OptiTextStyles.link,
                ),
              ),
          ],
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
