import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/two_texts_row.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return OrderInformationWidget(
      orderNumber: orderNumber,
      orderDate: orderDate,
      orderStatus: orderStatus,
      shippingMethod: shippingMethod,
      terms: terms,
      poNumber: poNumber,
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
