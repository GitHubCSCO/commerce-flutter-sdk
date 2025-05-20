import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void trackClearCartSelectedEvent(BuildContext context, String orderNumber) {
  context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
          AnalyticsConstants.eventClearCartSelected,
          AnalyticsConstants.screenNameCart)
      .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber)));
}

void trackClearCartCancelledEvent(BuildContext context, String orderNumber) {
  context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
          AnalyticsConstants.eventClearCartCancelled,
          AnalyticsConstants.screenNameCart)
      .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber)));
}

void trackClearCartSuccessfulEvent(BuildContext context, String orderNumber) {
  context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
          AnalyticsConstants.eventClearCartSuccessful,
          AnalyticsConstants.screenNameCart)
      .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber)));
}

void _onClickClearAllCart(BuildContext context, String orderNumber) {
  displayDialogWidget(
      context: context,
      title: "",
      message: LocalizationConstants.clearAllItemsInCart.localized(),
      actions: [
        DialogPlainButton(
          onPressed: () {
            trackClearCartSuccessfulEvent(context, orderNumber);
            context.read<CartContentBloc>().add(CartContentClearAllEvent());
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.remove.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            trackClearCartCancelledEvent(context, orderNumber);
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
      ]);
}

class CartContentHeaderWidget extends StatelessWidget {
  final bool? showClearCart;
  final int cartCount;
  final String? orderNumber;
  const CartContentHeaderWidget({
    super.key,
    required this.cartCount,
    required this.orderNumber,
    this.showClearCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "${LocalizationConstants.cart.localized()} ",
                  style: OptiTextStyles.titleLarge,
                ),
                TextSpan(
                  text: '($cartCount ${cartCount == 1 ? 'Item' : 'Items'})',
                  style: OptiTextStyles.subtitle,
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
          Visibility(
            visible: showClearCart ?? true,
            child: InkWell(
              onTap: () {
                trackClearCartSelectedEvent(context, orderNumber ?? "");
                _onClickClearAllCart(context, orderNumber ?? "");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: SvgAssetImage(
                      assetName: AssetConstants.cartClearIcon,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Text(
                    LocalizationConstants.clearCart.localized(),
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.body,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
