import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/avalability_color_converter.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/view_warehouse_availability_widget.dart';
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
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final int? availabilityMessageType;

  const LineItemPricingWidget(
      {super.key,
      this.discountMessage,
      this.priceValueText,
      this.unitOfMeasureValueText,
      this.availabilityText,
      this.showViewQuantityPricing = true,
      this.showViewAvailabilityByWarehouse = false,
      this.productId,
      this.erpNumber,
      this.unitOfMeasure,
      this.hidePricingEnable,
      this.hideInventoryEnable,
      this.availabilityMessageType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!(hidePricingEnable ?? false)) ...{
              _buildDiscountMessageSection(
                context,
                discountMessage: discountMessage,
              ),
              _buildPricingSection(
                context,
                priceValueText: priceValueText,
                unitOfMeasureValueText: unitOfMeasureValueText,
              ),
            },
            if (!(hideInventoryEnable ?? false)) ...{
              availabilityText != null
                  ? _buildInventorySection(
                      context,
                      availabilityText: availabilityText,
                      availabilityMessageType: availabilityMessageType,
                    )
                  : Container(),
              // _buildInventorySection(context),
              // For "View Availability by Warehouse"
              if (showViewAvailabilityByWarehouse)
                InkWell(
                  onTap: () {
                    viewWarehouseWidget(context, productId, erpNumber ?? "",
                        unitOfMeasure ?? "");
                  },
                  child: Text(
                    LocalizationConstants.viewAvailabilityWarehouse.localized(),
                    style: OptiTextStyles.link,
                  ),
                ),
            }
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
  if ((priceValueText != null && priceValueText.isNotEmpty) ||
      (unitOfMeasureValueText != null && unitOfMeasureValueText.isNotEmpty)) {
    return Row(
      children: [
        Text(priceValueText ?? '', style: OptiTextStyles.bodySmallHighlight),
        Text(unitOfMeasureValueText ?? '', style: OptiTextStyles.bodySmall),
      ],
    );
  }
  return const SizedBox.shrink();
}

Widget _buildInventorySection(BuildContext context,
    {String? availabilityText, int? availabilityMessageType}) {
  if (availabilityText != null && availabilityText.isNotEmpty) {
    return Text(
      availabilityText ?? '',
      style: OptiTextStyles.body.copyWith(
          color: AvailabilityColorConverter.convert(availabilityMessageType)),
    );
  }
  return const SizedBox.shrink();
}
