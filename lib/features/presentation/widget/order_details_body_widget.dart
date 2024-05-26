import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/two_texts_row.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:flutter/material.dart';

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
                label: LocalizationConstants.orderNumberSign,
                value: orderNumber!,
                textStyle: OptiTextStyles.subtitle,
              ),
            if (webOrderNumber != null)
              TwoTextsRow(
                label: LocalizationConstants.webOrderNumberSign,
                value: webOrderNumber!,
                textStyle: OptiTextStyles.body,
              ),
            if (orderDate != null)
              TwoTextsRow(
                label: LocalizationConstants.orderDate,
                value: orderDate!,
                textStyle: OptiTextStyles.body,
              ),
            if (orderStatus != null)
              TwoTextsRow(
                label: LocalizationConstants.orderStatus,
                value: orderStatus!,
                textStyle: OptiTextStyles.body,
              ),
            if (poNumber != null)
              TwoTextsRow(
                label: LocalizationConstants.pONumberSign,
                value: poNumber!,
                textStyle: OptiTextStyles.body,
              ),
            if (shippingMethod != null)
              TwoTextsRow(
                label: LocalizationConstants.shippingMethod,
                value: shippingMethod!,
                textStyle: OptiTextStyles.body,
              ),
            if (terms != null)
              TwoTextsRow(
                label: LocalizationConstants.terms,
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

  const OrderProductsSectionWidget({
    super.key,
    required this.orderLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocalizationConstants.products,
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
              productNumber: orderLine.productErpNumber,
              discountMessage: (orderLine.unitNetPrice == 0)
                  ? ''
                  : (DiscountValueConverter().convert(orderLine) ?? '')
                      .toString(),
              priceValueText: orderLine.unitNetPriceDisplay,
              unitOfMeasureValueText: orderLine.unitOfMeasureDisplay != null
                  ? ' / ${orderLine.unitOfMeasureDisplay}'
                  : null,
              qtyOrdered: orderLine.qtyOrdered?.round().toString(),
              subtotalPriceText: orderLine.extendedUnitNetPriceDisplay,
              canEditQty: false,
              showViewAvailabilityByWarehouse: false,
              showViewQuantityPricing: false,
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: orderLines.length,
        )
      ],
    );
  }
}
