import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_title_widget.dart';
import 'package:flutter/material.dart';

class JobQuoteLineWidget extends StatelessWidget {
  final String? productId;
  final String? imagePath;
  final String? shortDescription;
  final String? manufacturerItem;
  final String? productNumber;
  final String? discountMessage;
  final String? priceValueText;
  final String? unitOfMeasureValueText;
  final String? availabilityText;
  final String? qtyOrdered;
  final void Function(int?)? onQtyChanged;
  final String? unitOfMeasure;
  final int jobQty;
  final int purchasedQty;

  const JobQuoteLineWidget({
    super.key,
    this.productId,
    this.imagePath,
    this.shortDescription,
    this.manufacturerItem,
    this.productNumber,
    this.discountMessage,
    this.priceValueText,
    this.unitOfMeasureValueText,
    this.availabilityText,
    this.qtyOrdered,
    this.onQtyChanged,
    this.unitOfMeasure,
    required this.jobQty,
    required this.purchasedQty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          _buildProductDetails(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return LineItemImageWidget(imagePath: imagePath ?? '');
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineItemTitleWidget(
            shortDescription: shortDescription,
            manufacturerItem: manufacturerItem,
            productNumber: productNumber,
          ),
          LineItemPricingWidget(
            discountMessage: discountMessage,
            priceValueText: priceValueText,
            unitOfMeasureValueText: unitOfMeasureValueText,
            availabilityText: availabilityText,
            showViewQuantityPricing: false,
            showViewAvailabilityByWarehouse: false,
            productId: productId,
            erpNumber: productNumber,
            unitOfMeasure: unitOfMeasure,
          ),
          _JobQuoteLineQuantityGroupWidget(
            qtyOrdered: qtyOrdered,
            onQtyChanged: onQtyChanged,
            jobQty: jobQty,
            purchasedQty: purchasedQty,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _JobQuoteLineQuantityGroupWidget extends StatelessWidget {
  final String? qtyOrdered;
  final void Function(int?)? onQtyChanged;
  final int jobQty;
  final int purchasedQty;

  const _JobQuoteLineQuantityGroupWidget({
    this.qtyOrdered,
    this.onQtyChanged,
    required this.jobQty,
    required this.purchasedQty,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocalizationConstants.orderQTY.localized(),
                  style: OptiTextStyles.bodySmallHighlight,
                ),
                const SizedBox(
                  height: 10,
                ),
                NumberTextField(
                  max: jobQty - purchasedQty,
                  min: 0,
                  initialtText: qtyOrdered,
                  shouldShowIncrementDecermentIcon: false,
                  onSubmitted: onQtyChanged,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          _JobQuoteLineStatisticsWidget(
            qtyOrdered: jobQty,
            purchasedQty: purchasedQty,
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}

class _JobQuoteLineStatisticsWidget extends StatelessWidget {
  final int qtyOrdered;
  final int purchasedQty;

  const _JobQuoteLineStatisticsWidget({
    required this.qtyOrdered,
    required this.purchasedQty,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${LocalizationConstants.jobQty.localized()}: $qtyOrdered',
          style: OptiTextStyles.bodySmallHighlight,
        ),
        Text(
          '${LocalizationConstants.purchasedQty.localized()}: $purchasedQty',
          style: OptiTextStyles.bodySmallHighlight,
        ),
        Text(
          '${LocalizationConstants.qtyRemaining.localized()}: ${qtyOrdered - purchasedQty}',
          style: OptiTextStyles.bodySmallHighlight,
        ),
      ],
    );
  }
}
