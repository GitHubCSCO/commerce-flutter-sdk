import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/mixins/payment_summary_mixin.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/add_promotion_widget.dart';
import 'package:flutter/material.dart';

class CartPaymentSummaryWidget extends StatelessWidget
    with PaymentSummaryMixin {
  final PaymentSummaryEntity paymentSummaryEntity;

  CartPaymentSummaryWidget({super.key, required this.paymentSummaryEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            LocalizationConstants.paymentSummary.localized(),
            style: OptiTextStyles.titleLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...buildSummaryItems(paymentSummaryEntity),
              _buildAddPromoWidget(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAddPromoWidget() {
    return AddPromotionWidget(
      shouldShowPromotionList: false,
      fromCartPage: true,
      isAddDiscountEnable: paymentSummaryEntity.isAddDiscountEnable,
    );
  }
}
