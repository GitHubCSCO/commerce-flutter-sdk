import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:flutter/material.dart';

class CartOrderProductsSectionWidget extends StatelessWidget {
  final List<CartLineEntity> cartLines;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final void Function({required CartLineEntity cartLineEntity})? onAddToList;
  final void Function({required CartLineEntity cartLineEntity})? onAddToCart;

  const CartOrderProductsSectionWidget({
    super.key,
    required this.cartLines,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    this.onAddToCart,
    this.onAddToList,
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
                '(${cartLines.length} item)',
                style: OptiTextStyles.body,
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final cartLineEntity = cartLines[index];
            return LineItemWidget(
              productId: cartLineEntity.productId,
              imagePath: cartLineEntity.smallImagePath,
              shortDescription: cartLineEntity.shortDescription,
              manufacturerItem: cartLineEntity.manufacturerItem,
              productNumber: cartLineEntity.getProductNumber(),
              discountMessage: cartLineEntity.pricing?.getDiscountValue(),
              priceValueText: cartLineEntity.updatePriceValueText(),
              unitOfMeasureValueText:
                  cartLineEntity.updateUnitOfMeasureValueText(),
              qtyOrdered: cartLineEntity.qtyOrdered?.toInt().toString(),
              subtotalPriceText: cartLineEntity.updateSubtotalPriceValueText(),
              canEditQty: false,
              showViewAvailabilityByWarehouse:
                  cartLineEntity.showInventoryAvailability ?? false,
              showViewQuantityPricing: false,
              unitOfMeasure: cartLineEntity.pricing?.getUnitOfMeasure(
                cartLineEntity.baseUnitOfMeasure ?? '',
              ),
              hidePricingEnable: hidePricingEnable,
              hideInventoryEnable: hideInventoryEnable,
              canAddToCart: onAddToCart != null,
              canAddToList: onAddToList != null,
              onAddToCart: () {
                if (onAddToCart != null) {
                  onAddToCart!(cartLineEntity: cartLineEntity);
                }
              },
              onAddToList: () {
                if (onAddToList != null) {
                  onAddToList!(cartLineEntity: cartLineEntity);
                }
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: cartLines.length,
        )
      ],
    );
  }
}
