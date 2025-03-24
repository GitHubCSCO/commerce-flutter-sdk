import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/promotion_type.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin PaymentSummaryMixin {
  List<Widget> buildSummaryItems(PaymentSummaryEntity paymentSummaryEntity) {
    List<Widget> list = [];
    final shouldShowTaxAndShipping =
        paymentSummaryEntity.cartSettings?.showTaxAndShipping ?? false;
    var orderPromotions = paymentSummaryEntity.promotions?.promotions
        ?.where((x) =>
            (x.promotionResultType?.toLowerCase() ==
                    PromotionType.amountofforder.name ||
                x.promotionResultType?.toLowerCase() ==
                    PromotionType.percentofforder.name) &&
            x.amount != 0)
        .toList();

    var shippingPromotions = paymentSummaryEntity.promotions?.promotions
        ?.where((x) =>
            (x.promotionResultType?.toLowerCase() ==
                    PromotionType.amountoffshipping.name ||
                x.promotionResultType?.toLowerCase() ==
                    PromotionType.percentoffshipping.name) &&
            x.amount != 0)
        .toList();

    var orderApprove = _buildOrderApprove(paymentSummaryEntity);
    var subTotal = _buildSubTotal(paymentSummaryEntity);
    var promotions = _buildPromotions(orderPromotions, shippingPromotions);
    var shipping =
        _buildShipping(shouldShowTaxAndShipping, paymentSummaryEntity);
    var estimatedShipping =
        _buildShippingHandling(shouldShowTaxAndShipping, paymentSummaryEntity);
    var handling =
        _buildHandling(shouldShowTaxAndShipping, paymentSummaryEntity);
    var miscCharge =
        _buildMiscCharge(shouldShowTaxAndShipping, paymentSummaryEntity);
    var tax =
        _buildEstimatedTax(shouldShowTaxAndShipping, paymentSummaryEntity);
    var total =
        _buildEstimatedTotal(shouldShowTaxAndShipping, paymentSummaryEntity);
    var savedAmount = _buildYouSaved(orderPromotions, shippingPromotions);

    if (orderApprove != null) {
      list.add(orderApprove);
    }
    if (subTotal != null) {
      list.add(subTotal);
    }
    if (shipping != null) {
      list.add(shipping);
    }
    if (estimatedShipping != null) {
      list.add(estimatedShipping);
    }
    if (handling != null) {
      list.add(handling);
    }
    if (miscCharge != null) {
      list.add(miscCharge);
    }
    if (tax != null) {
      list.add(tax);
    }
    if (total != null) {
      list.add(total);
    }
    if (promotions != null) {
      list.add(promotions);
    }
    if (savedAmount != null) {
      list.add(savedAmount);
    }

    return list;
  }

  Widget? _buildOrderApprove(PaymentSummaryEntity paymentSummaryEntity) {
    String title = paymentSummaryEntity.cart == null
        ? LocalizationConstants.approvingCart.localized()
        : LocalizationConstants.approvingCartInfos.localized().format([
            paymentSummaryEntity.cart!.orderNumber,
            paymentSummaryEntity.cart!.initiatedByUserName
          ]);

    TextStyle textStyle = OptiTextStyles.body;
    return paymentSummaryEntity.isCustomerOrderApproval
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.amber[400],
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          )
        : null;
  }

  Widget? _buildSubTotal(PaymentSummaryEntity paymentSummaryEntity) {
    final cart = paymentSummaryEntity.cart;

    var title = (cart == null)
        ? LocalizationConstants.subtotal.localized()
        : (cart.totalCountDisplay == 1
                ? LocalizationConstants.subtotalItem
                : LocalizationConstants.subtotalItems)
            .localized()
            .format([cart.totalCountDisplay ?? '']);

    return _buildRow(
        title, cart?.orderSubTotalDisplay ?? '', OptiTextStyles.subtitle);
  }

  Widget? _buildEstimatedTotal(bool shouldShowTaxAndShipping,
      PaymentSummaryEntity paymentSummaryEntity) {
    String title = LocalizationConstants.total.localized();
    String body =
        ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null)
                ? paymentSummaryEntity.cart?.orderGrandTotalDisplay
                : '') ??
            '';
    TextStyle textStyle = OptiTextStyles.subtitleHighlight;

    var widget = _buildRow(title, body, textStyle);
    if (widget != null) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 12),
        widget,
      ]);
    } else {
      return null;
    }
  }

  Widget? _buildEstimatedTax(bool shouldShowTaxAndShipping,
      PaymentSummaryEntity paymentSummaryEntity) {
    String title = LocalizationConstants.tax.localized();
    String body =
        ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null)
                ? paymentSummaryEntity.cart?.totalTaxDisplay
                : '') ??
            '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildShipping(bool shouldShowTaxAndShipping,
      PaymentSummaryEntity paymentSummaryEntity) {
    String title = LocalizationConstants.shipping.localized();
    String body =
        ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null)
                ? paymentSummaryEntity.cart?.shippingChargesDisplay
                : '') ??
            '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildShippingHandling(bool shouldShowTaxAndShipping,
      PaymentSummaryEntity paymentSummaryEntity) {
    String title = LocalizationConstants.shippingHandling.localized();
    String body =
        ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null)
                ? paymentSummaryEntity.cart?.shippingAndHandlingDisplay
                : '') ??
            '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildHandling(bool shouldShowTaxAndShipping,
      PaymentSummaryEntity paymentSummaryEntity) {
    String title = LocalizationConstants.handling.localized();
    String body =
        ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null)
                ? paymentSummaryEntity.cart?.handlingChargesDisplay
                : '') ??
            '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildMiscCharge(bool shouldShowTaxAndShipping,
      PaymentSummaryEntity paymentSummaryEntity) {
    String title = LocalizationConstants.miscCharge.localized();
    String body =
        ((shouldShowTaxAndShipping && paymentSummaryEntity.cart != null)
                ? paymentSummaryEntity.cart?.otherChargesDisplay
                : '') ??
            '';
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildYouSaved(
      List<Promotion>? orderPromotions, List<Promotion>? shippingPromotions) {
    double sumAmounts(List<Promotion>? promotions) {
      return promotions?.fold(
              0.0, (sum, item) => (sum ?? 0) + (item.amount ?? 0)) ??
          0.0;
    }

    var discountTotal =
        sumAmounts(orderPromotions) + sumAmounts(shippingPromotions);
    String formattedDiscountTotal = discountTotal > 0
        ? '${CoreConstants.currencySymbol}${discountTotal.toStringAsFixed(2)}'
        : '';

    String title = LocalizationConstants.discounts.localized();
    String body = formattedDiscountTotal;
    TextStyle textStyle = OptiTextStyles.body;
    return _buildRow(title, body, textStyle);
  }

  Widget? _buildPromotions(
      List<Promotion>? orderPromotions, List<Promotion>? shippingPromotions) {
    var orderPromotion = _buildOrderPromotion(orderPromotions);
    var shippingPromotion = _buildShippingPromotion(shippingPromotions);

    final list = [];
    if (orderPromotion != null) {
      list.add(orderPromotion);
    }
    if (shippingPromotion != null) {
      list.add(shippingPromotion);
    }

    if (list.isEmpty) {
      return null;
    } else {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 12),
        ...list,
        const SizedBox(height: 12),
      ]);
    }
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
      return Column(mainAxisSize: MainAxisSize.min, children: list);
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
      return Column(mainAxisSize: MainAxisSize.min, children: list);
    }
  }

  Widget? _buildPromotion(Promotion promotion) {
    String title =
        '${LocalizationConstants.promotion.localized()} : ${promotion.name!}';
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: textStyle,
              ),
            ),
          ),
          Text(
            body,
            textAlign: TextAlign.start,
            style: textStyle,
          )
        ],
      );
    }
  }
}
