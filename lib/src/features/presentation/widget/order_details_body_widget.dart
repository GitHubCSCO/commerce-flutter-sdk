import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/order_line_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/two_texts_row.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderDetailsBodyWidget extends StatelessWidget {
  final String? orderNumber;
  final String? webOrderNumber;
  final String? orderDate;
  final String? orderStatus;
  final String? poNumber;
  final String? shippingMethod;
  final String? terms;
  final String? requestedDeliveryDateTitle;
  final String? requestedDeliveryDate;

  final bool isShippingAddressVisible;
  final String? shippingCompanyName;
  final String? shippingFullAddress;
  final String? shippingCountryName;

  final String? billingCompanyName;
  final String? billingFullAddress;

  final bool isPickupLocationVisible;
  final String? pickupLocationAddress;

  final String? subtotal;
  final String? discount;
  final String? shippingHandling;
  final String? otherCharges;
  final String? tax;
  final String? total;
  final String? subtotalTitle;
  final String? discountTitle;
  final String? shippingHandlingTitle;
  final String? otherChargesTitle;
  final String? taxTitle;
  final String? totalTitle;
  final List<PromotionItem>? promotions;
  final int? itemCount;

  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;

  const OrderDetailsBodyWidget({
    super.key,
    this.orderNumber,
    this.webOrderNumber,
    this.orderDate,
    this.orderStatus,
    this.poNumber,
    this.shippingMethod,
    this.terms,
    this.requestedDeliveryDateTitle,
    this.requestedDeliveryDate,
    this.isShippingAddressVisible = false,
    this.shippingCompanyName,
    this.shippingFullAddress,
    this.shippingCountryName,
    this.billingCompanyName,
    this.billingFullAddress,
    this.pickupLocationAddress,
    this.isPickupLocationVisible = false,
    this.subtotal,
    this.discount,
    this.shippingHandling,
    this.otherCharges,
    this.tax,
    this.total,
    this.subtotalTitle,
    this.discountTitle,
    this.shippingHandlingTitle,
    this.otherChargesTitle,
    this.taxTitle,
    this.totalTitle,
    this.promotions,
    this.itemCount,
    this.hidePricingEnable,
    this.hideInventoryEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OrderInformationWidget(
          orderNumber: orderNumber,
          orderDate: orderDate,
          orderStatus: orderStatus,
          shippingMethod: shippingMethod,
          terms: terms,
          poNumber: poNumber,
          requestedDeliveryDate: requestedDeliveryDate,
          requestedDeliveryDateTitle: requestedDeliveryDateTitle,
          webOrderNumber: webOrderNumber,
        ),
        OrderBillingAddressWidget(
          companyName: billingCompanyName,
          fullAddress: billingFullAddress,
        ),
        if (isShippingAddressVisible)
          OrderShippingAddressWidget(
            visible: isShippingAddressVisible,
            companyName: shippingCompanyName,
            fullAddress: shippingFullAddress,
            countryName: shippingCountryName,
          ),
        if (!(hidePricingEnable ?? false))
          OrderPaymentSectionWidget(
            discount: discount,
            discountTitle: discountTitle,
            otherCharges: otherCharges,
            otherChargesTitle: otherChargesTitle,
            promotions: promotions,
            shippingHandling: shippingHandling,
            shippingHandlingTitle: shippingHandlingTitle,
            subtotal: subtotal,
            subtotalTitle: subtotalTitle,
            tax: tax,
            taxTitle: taxTitle,
            total: total,
            totalTitle: totalTitle,
            itemCount: itemCount,
          ),
        if (isPickupLocationVisible)
          OrderPickupLocationWidget(
            address: pickupLocationAddress,
          ),
      ],
    );
  }
}

class OrderInformationWidget extends StatelessWidget {
  final String? orderNumber;
  final String? webOrderNumber;
  final String? orderDate;
  final String? orderStatus;
  final String? poNumber;
  final String? shippingMethod;
  final String? terms;
  final String? requestedDeliveryDateTitle;
  final String? requestedDeliveryDate;

  const OrderInformationWidget({
    super.key,
    this.orderNumber,
    this.webOrderNumber,
    this.orderDate,
    this.orderStatus,
    this.poNumber,
    this.shippingMethod,
    this.terms,
    this.requestedDeliveryDateTitle,
    this.requestedDeliveryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OptiAppColors.backgroundWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (orderNumber != null)
              TwoTextsRow(
                label: LocalizationConstants.orderNumberSign.localized(),
                value: orderNumber!,
                textStyle: OptiTextStyles.subtitle,
              ),
            if (webOrderNumber != null)
              TwoTextsRow(
                label: LocalizationConstants.webOrderNumberSign.localized(),
                value: webOrderNumber!,
                textStyle: OptiTextStyles.body,
              ),
            if (orderDate != null)
              TwoTextsRow(
                label: LocalizationConstants.orderDate.localized(),
                value: orderDate!,
                textStyle: OptiTextStyles.body,
              ),
            if (orderStatus != null)
              TwoTextsRow(
                label: LocalizationConstants.orderStatus.localized(),
                value: orderStatus!,
                textStyle: OptiTextStyles.body,
              ),
            if (poNumber != null)
              TwoTextsRow(
                label: LocalizationConstants.pONumberSign.localized(),
                value: poNumber!,
                textStyle: OptiTextStyles.body,
              ),
            if (shippingMethod != null)
              TwoTextsRow(
                label: LocalizationConstants.shippingMethod.localized(),
                value: shippingMethod!,
                textStyle: OptiTextStyles.body,
              ),
            if (terms != null)
              TwoTextsRow(
                label: LocalizationConstants.terms.localized(),
                value: terms!,
                textStyle: OptiTextStyles.body,
              ),
            if (requestedDeliveryDateTitle != null)
              TwoTextsRow(
                label: requestedDeliveryDateTitle!,
                value: requestedDeliveryDate!,
                textStyle: OptiTextStyles.body,
              ),
          ],
        ),
      ),
    );
  }
}

class OrderShippingAddressWidget extends StatelessWidget {
  final bool visible;
  final String? companyName;
  final String? fullAddress;
  final String? countryName;
  const OrderShippingAddressWidget({
    super.key,
    required this.visible,
    this.companyName,
    this.fullAddress,
    this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: OptiAppColors.backgroundWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ShippingAddressWidget(
          companyName: companyName,
          countryName: countryName,
          fullAddress: fullAddress,
          visible: visible,
        ),
      ),
    );
  }
}

class OrderBillingAddressWidget extends StatelessWidget {
  final String? companyName;
  final String? fullAddress;
  const OrderBillingAddressWidget({
    super.key,
    this.companyName,
    this.fullAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: OptiAppColors.backgroundWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: BillingAddressWidget(
          companyName: companyName,
          fullAddress: fullAddress,
        ),
      ),
    );
  }
}

class OrderPickupLocationWidget extends StatelessWidget {
  final String? address;
  const OrderPickupLocationWidget({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: OptiAppColors.backgroundWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: PickupLocationWidget(
          address: address,
        ),
      ),
    );
  }
}

class OrderProductsSectionWidget extends StatelessWidget {
  final List<OrderLineEntity> orderLines;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;

  const OrderProductsSectionWidget({
    super.key,
    required this.orderLines,
    this.hidePricingEnable,
    this.hideInventoryEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
              .copyWith(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocalizationConstants.products.localized(),
                style: OptiTextStyles.titleLarge,
              ),
              const SizedBox(width: 8),
              Text(
                '(${orderLines.length} item)',
                style: OptiTextStyles.body,
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final orderLine = orderLines[index];
            return LineItemWidget(
              productId: orderLine.productId,
              imagePath: orderLine.mediumImagePath,
              shortDescription: orderLine.shortDescription,
              manufacturerItem: orderLine.manufacturerItem,
              productNumber: orderLine.getProductNumber(),
              // <XNG-Change>: XSD-21774 always show zero price message
              discountMessage: orderLine.getDiscountMessage(),
              priceValueText: orderLine.getPriceValueText(),
              unitOfMeasureValueText: orderLine.getUnitOfMeasureText(),
              // </XNG-Change>
              qtyOrdered: orderLine.qtyOrdered?.round().toString(),
              subtotalPriceText: orderLine.extendedUnitNetPriceDisplay,
              canEditQty: false,
              showViewAvailabilityByWarehouse: false,
              showViewQuantityPricing: false,
              hidePricingEnable: hidePricingEnable,
              hideInventoryEnable: hideInventoryEnable,
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: orderLines.length,
        )
      ],
    );
  }
}

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

class OrderPaymentSectionWidget extends StatelessWidget {
  final String? subtotal;
  final String? discount;
  final String? shippingHandling;
  final String? otherCharges;
  final String? tax;
  final String? total;
  final String? subtotalTitle;
  final String? discountTitle;
  final String? shippingHandlingTitle;
  final String? otherChargesTitle;
  final String? taxTitle;
  final String? totalTitle;
  final int? itemCount;
  final List<PromotionItem>? promotions;

  const OrderPaymentSectionWidget({
    super.key,
    this.subtotal,
    this.discount,
    this.shippingHandling,
    this.otherCharges,
    this.tax,
    this.total,
    this.subtotalTitle,
    this.discountTitle,
    this.shippingHandlingTitle,
    this.otherChargesTitle,
    this.taxTitle,
    this.totalTitle,
    this.promotions,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
              .copyWith(bottom: 8),
          child: Text(
            LocalizationConstants.orderSummary.localized(),
            style: OptiTextStyles.titleLarge,
          ),
        ),
        Container(
          width: double.infinity,
          color: OptiAppColors.backgroundWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TwoTextsRow(
                  label: subtotalTitle?.format([itemCount]) ?? '',
                  value: subtotal ?? '',
                  textStyle: OptiTextStyles.subtitle,
                ),
                if (!shippingHandling.isNullOrEmpty)
                  TwoTextsRow(
                    label: shippingHandlingTitle ?? '',
                    value: shippingHandling ?? '',
                    textStyle: OptiTextStyles.body,
                  ),
                if (!otherCharges.isNullOrEmpty)
                  TwoTextsRow(
                    label: otherChargesTitle ?? '',
                    value: otherCharges ?? '',
                    textStyle: OptiTextStyles.body,
                  ),
                if (!tax.isNullOrEmpty)
                  TwoTextsRow(
                    label: taxTitle ?? '',
                    value: tax ?? '',
                    textStyle: OptiTextStyles.body,
                  ),
                if (!total.isNullOrEmpty) ...[
                  const SizedBox(height: 10),
                  TwoTextsRow(
                    label: totalTitle ?? '',
                    value: total ?? '',
                    textStyle: OptiTextStyles.subtitle,
                  ),
                ],
                if (!discount.isNullOrEmpty) const SizedBox(height: 10),
                if (promotions != null && promotions!.isNotEmpty)
                  ...promotions!.map((promotion) {
                    if (promotion.promotionLabel.isNullOrEmpty ||
                        promotion.promotionValue.isNullOrEmpty) {
                      return const SizedBox.shrink();
                    }

                    return TwoTextsRow(
                      maxLines: 3,
                      label: promotion.promotionLabel,
                      value: promotion.promotionValue,
                      textStyle: OptiTextStyles.body.copyWith(
                        color: OptiAppColors.textSecondary,
                      ),
                    );
                  }),
                if (!discount.isNullOrEmpty)
                  TwoTextsRow(
                    label: discountTitle ?? '',
                    value: discount ?? '',
                    textStyle: OptiTextStyles.body,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class OrderBottomSectionWidget extends StatelessWidget {
  final List<Widget> actions;

  const OrderBottomSectionWidget({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: OptiAppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 5,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 13.5,
        horizontal: 31.5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions
            .map(
              (widget) => widget,
            )
            .expand((element) => [element, const SizedBox(height: 5)])
            .take(actions.length * 2 - 1)
            .toList(),
      ),
    );
  }
}
