import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartPaymentSummaryWidget extends StatelessWidget {

  final PaymentSummaryEntity paymentSummaryEntity;

  const CartPaymentSummaryWidget({super.key, required this.paymentSummaryEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            'Payment Summary',
            style: OptiTextStyles.titleLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildSummaryItems(),
          ),
        )
      ],
    );
  }

  List<Widget> _buildSummaryItems() {
    List<Widget> list = [];
    final shouldShowTaxAndShipping = paymentSummaryEntity.cartSettings?.showTaxAndShipping ?? false;
    var orderPromotions = paymentSummaryEntity.promotions?.promotions?.where((x) =>
    (x.promotionResultType?.toLowerCase() == "amountofforder" ||
        x.promotionResultType?.toLowerCase() == "percentofforder") &&
        x.amount != 0).toList();

    var shippingPromotions = paymentSummaryEntity.promotions?.promotions?.where((x) =>
    (x.promotionResultType?.toLowerCase() == "amountoffshipping" ||
        x.promotionResultType?.toLowerCase() == "percentoffshipping") &&
        x.amount != 0).toList();

    var orderApprove = _buildOrderApprove();
    var subTotal = _buildSubTotal();
    var orderPromotion = _buildOrderPromotion(orderPromotions);
    var shipping = _buildShipping(shouldShowTaxAndShipping);
    var estimatedShipping = _buildShippingHandling(shouldShowTaxAndShipping);
    var shippingPromotion = _buildShippingPromotion(shippingPromotions);
    var handling = _buildHandling(shouldShowTaxAndShipping);
    var miscCharge = _buildMiscCharge(shouldShowTaxAndShipping);
    var tax = _buildEstimatedTax(shouldShowTaxAndShipping);
    var total = _buildEstimatedTotal(shouldShowTaxAndShipping);
    var savedAmount = _buildYouSaved(orderPromotions, shippingPromotions);


    if(orderApprove != null) {
      list.add(orderApprove);
    }
    if(subTotal != null) {
      list.add(subTotal);
    }
    if(orderPromotion != null) {
      list.add(orderPromotion);
    }
    if(shipping != null) {
      list.add(shipping);
    }
    if(estimatedShipping != null) {
      list.add(estimatedShipping);
    }
    if(shippingPromotion != null) {
      list.add(shippingPromotion);
    }
    if(handling != null) {
      list.add(handling);
    }
    if(miscCharge != null) {
      list.add(miscCharge);
    }
    if(tax != null) {
      list.add(tax);
    }
    if(total != null) {
      list.add(total);
    }
    if(savedAmount != null) {
      list.add(savedAmount);
    }

    return list;
  }

  Widget? _buildOrderApprove() {
    String title = paymentSummaryEntity.cart == null
        ? LocalizationConstants.approvingCart
        : LocalizationConstants.approvingCartInfos.format([paymentSummaryEntity.cart!.orderNumber, paymentSummaryEntity.cart!.initiatedByUserName]);

    String body = '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildSubTotal() {
    String title = paymentSummaryEntity.cart == null
        ? LocalizationConstants.subtotal
        : LocalizationConstants.subtotalItems.format([paymentSummaryEntity.cart?.totalCountDisplay ?? '']);
    String body = paymentSummaryEntity.cart?.orderSubTotalDisplay ?? '';
    TextStyle textStyle = OptiTextStyles.subtitle;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildEstimatedTotal(bool shouldShowTaxAndShipping) {
    String title = LocalizationConstants.total;
    String body = ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null) ? paymentSummaryEntity.cart?.orderGrandTotalDisplay : '') ?? '';
    TextStyle textStyle = OptiTextStyles.subtitle;

    var widget = _buildRow(title, body, textStyle);
    if (widget != null) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            widget,
            const SizedBox(height: 12),
          ]
      );
    } else {
      return null;
    }
  }

  Widget? _buildEstimatedTax(bool shouldShowTaxAndShipping) {
    String title = LocalizationConstants.tax;
    String body = ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null) ? paymentSummaryEntity.cart?.totalTaxDisplay : '') ?? '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildShipping(bool shouldShowTaxAndShipping) {
    String title = LocalizationConstants.shipping;
    String body = ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null) ? paymentSummaryEntity.cart?.shippingChargesDisplay : '') ?? '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildShippingHandling(bool shouldShowTaxAndShipping) {
    String title = LocalizationConstants.shippingHandling;
    String body = ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null) ? paymentSummaryEntity.cart?.shippingAndHandlingDisplay : '') ?? '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildHandling(bool shouldShowTaxAndShipping) {
    String title = LocalizationConstants.handling;
    String body = ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null) ? paymentSummaryEntity.cart?.handlingChargesDisplay : '') ?? '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildMiscCharge(bool shouldShowTaxAndShipping) {
    String title = LocalizationConstants.miscCharge;
    String body = ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null) ? paymentSummaryEntity.cart?.otherChargesDisplay : '') ?? '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildYouSaved(List<Promotion>? orderPromotions, List<Promotion>? shippingPromotions) {
    var discountTotal = (orderPromotions?.fold(0, (previousValue, element) => (previousValue.toInt()) + element.amount!.toInt()) ?? 0) +
        (shippingPromotions?.fold(0, (previousValue, element) => previousValue!.toInt() + element.amount!) ?? 0);
    String formattedDiscountTotal = discountTotal > 0
        ? '${CoreConstants.currencySymbol}${discountTotal.toStringAsFixed(2)}'
        : '';

    String title = LocalizationConstants.discounts;
    String body = formattedDiscountTotal;
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildOrderPromotion(List<Promotion>? orderPromotions) {
    List<Widget> list = [];

    orderPromotions?.forEach((promotion) {
      final widget = _buildPromotion(promotion);
      if (widget != null) {
        list.add(widget);
      }
    });

    if (list.isEmpty) {
      return null;
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            ...list,
            const SizedBox(height: 12),
          ]
      );
    }
  }

  Widget? _buildShippingPromotion(List<Promotion>? shippingPromotions) {
    List<Widget> list = [];

    shippingPromotions?.forEach((promotion) {
      final widget = _buildPromotion(promotion);
      if (widget != null) {
        list.add(widget);
      }
    });

    if (list.isEmpty) {
      return null;
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            ...list,
            const SizedBox(height: 12),
          ]
      );
    }
  }

  Widget? _buildPromotion(Promotion promotion) {
    String title = '${LocalizationConstants.promotion} : ${promotion.name!}';
    String body = '-${promotion.amountDisplay!}';
    TextStyle textStyle = OptiTextStyles.bodyFade;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildRow(String title, String body, TextStyle textStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          Text(
            body,
            textAlign: TextAlign.center,
            style: textStyle,
          )
        ],
      );
    }
  }
  
}