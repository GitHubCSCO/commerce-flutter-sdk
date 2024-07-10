import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
                  text: 'Cart ',
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
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      AssetConstants.cartClearIcon,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Text(
                    'Clear Cart',
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

  void _onClickClearAllCart(BuildContext context) {
    displayDialogWidget(
        context: context,
        title: "",
        message: LocalizationConstants.clearAllItemsInCart,
        actions: [
          DialogPlainButton(
            onPressed: () {
              context.read<CartContentBloc>().add(CartContentClearAllEvent());
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.remove),
          ),
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.cancel),
          ),
        ]);
  }
}
