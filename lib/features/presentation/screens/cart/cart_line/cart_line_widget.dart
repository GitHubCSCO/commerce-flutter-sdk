import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartLineWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  const CartLineWidget({super.key, required this.cartLineEntity});

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
            _buildProductDetails(context),
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
    return LineItemImageWidget(imagePath: cartLineEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineItemTitleWidget(
            shortDescription: cartLineEntity.shortDescription,
            manufacturerItem: cartLineEntity.manufacturerItem,
            productNumber: cartLineEntity.getProductNumber(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
            child: LineItemPricingWidget(
                discountMessage: cartLineEntity.pricing?.getDiscountValue(),
                priceValueText: cartLineEntity.updatePriceValueText(),
                unitOfMeasureValueText:
                    cartLineEntity.updateUnitOfMeasureValueText(),
                availabilityText: cartLineEntity.availability?.message,
                productId: cartLineEntity.productId,
                erpNumber: cartLineEntity.erpNumber,
                unitOfMeasure: cartLineEntity.baseUnitOfMeasure,
                showViewAvailabilityByWarehouse:
                    cartLineEntity.showInventoryAvailability ?? false),
          ),
          LineItemQuantityGroupWidget(
            qtyOrdered: cartLineEntity.qtyOrdered?.toInt().toString(),
            onQtyChanged: (int? qty) {
              if (qty == null) {
                return;
              }

              context.read<CartContentBloc>().add(
                    CartContentQuantityChangedEvent(
                      cartLineEntity: cartLineEntity.copyWith(qtyOrdered: qty),
                    ),
                  );
            },
            subtotalPriceText: cartLineEntity.updateSubtotalPriceValueText(),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CartContentBloc>().add(CartContentRemoveEvent(
            cartLine: CartLineEntityMapper().toModel(cartLineEntity)));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
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
    required this.cartCount, this.showClearCart,
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
}
