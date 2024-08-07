import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _onClickClearAllCart(BuildContext context) {
  displayDialogWidget(
      context: context,
      title: "",
      message: LocalizationConstants.clearAllItemsInCart.localized(),
      actions: [
        DialogPlainButton(
          onPressed: () {
            context.read<CartContentBloc>().add(CartContentClearAllEvent());
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.remove.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
      ]);
}

class CartContentHeaderWidget extends StatelessWidget {
  final bool? showClearCart;
  final int cartCount;
  const CartContentHeaderWidget({
    super.key,
    required this.cartCount,
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
                _onClickClearAllCart(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
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
