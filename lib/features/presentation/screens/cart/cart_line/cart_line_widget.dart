import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartLineWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  CartLineWidget({required this.cartLineEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToProductDetails(context),
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(),
            _buildRemoveButton(context),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context) {
    var productId = cartLineEntity.productId;
    AppRoute.productDetails.navigateBackStack(context,
        pathParameters: {"productId": productId.toString()},
        extra: ProductEntity());
  }

  Widget _buildProductImage() {
    return CartContentProductImageWidget(
        imagePath: cartLineEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CartContentProductTitleWidget(cartLineEntity: cartLineEntity),
          CartContentPricingWidget(cartLineEntity: cartLineEntity),
          CartContentQuantityGroupWidget(cartLineEntity)
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CartContentBloc>().add(CartContentRemoveEvent(
            CartLineEntityMapper().toModel(cartLineEntity)));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 30,
          height: 30,
          child: SvgPicture.asset(
            AssetConstants.cartItemRemoveIcon,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
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

class CartContentHeaderWidget extends StatelessWidget {
  final int cartCount;
  const CartContentHeaderWidget({
    super.key,
    required this.cartCount,
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
          InkWell(
            onTap: () {
              _onClickClearAllCart(context);
            },
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      AssetConstants.cartClearIcon,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Text('Clear Cart',
                      textAlign: TextAlign.center, style: OptiTextStyles.body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
