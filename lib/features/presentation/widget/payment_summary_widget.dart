import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/two_texts_row.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PromotionItem {
  final String promotionLabel;
  final String promotionValue;

  PromotionItem({
    required this.promotionLabel,
    required this.promotionValue,
  });

  PromotionItem copyWith({
    String? promotionLabel,
    String? promotionValue,
  }) {
    return PromotionItem(
      promotionLabel: promotionLabel ?? this.promotionLabel,
      promotionValue: promotionValue ?? this.promotionValue,
    );
  }
}

class PaymentSummaryWidget extends StatelessWidget {
  final String title;

  final String subtotalLabel;
  final String subtotalValue;

  final String? shippingLabel;
  final String? shippingValue;

  final String? taxLabel;
  final String? taxValue;

  final String totalLabel;
  final String totalValue;

  final List<PromotionItem>? promotionLabels;

  const PaymentSummaryWidget({
    super.key,
    required this.title,
    required this.subtotalLabel,
    required this.subtotalValue,
    this.shippingLabel,
    this.shippingValue,
    this.taxLabel,
    this.taxValue,
    required this.totalLabel,
    required this.totalValue,
    this.promotionLabels,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          _buildTitle(),
          _buildSubtotal(),
          _buildShipping(),
          _buildTax(),
          _buildTotal(),
          _buildPromotions(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubtotal() {
    return TwoTextsRow(
      label: subtotalLabel,
      value: subtotalValue,
      textStyle: OptiTextStyles.subtitle,
    );
  }

  Widget _buildShipping() {
    if (!shippingLabel.isNullOrEmpty && !shippingValue.isNullOrEmpty) {
      return TwoTextsRow(
        label: shippingLabel!,
        value: shippingValue!,
        textStyle: OptiTextStyles.body,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTax() {
    if (!taxLabel.isNullOrEmpty && !taxValue.isNullOrEmpty) {
      return TwoTextsRow(
        label: taxLabel!,
        value: taxValue!,
        textStyle: OptiTextStyles.body,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTotal() {
    return TwoTextsRow(
      label: totalLabel,
      value: totalValue,
      textStyle: OptiTextStyles.subtitle,
    );
  }

  Widget _buildPromotions() {
    return Column(
      children: promotionLabels?.map((promotionItem) {
            return TwoTextsRow(
              label: promotionItem.promotionLabel,
              value: promotionItem.promotionValue,
              textStyle: OptiTextStyles.body.copyWith(
                color: OptiAppColors.textSecondary,
              ),
            );
          }).toList() ??
          [],
    );
  }
}
