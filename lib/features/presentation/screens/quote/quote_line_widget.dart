import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_title_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/view_quote_line_break_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuoteLineWidget extends StatelessWidget {
  final QuoteLineEntity quoteLineEntity;
  final bool? showRemoveButton;
  final bool? showViewBreakPricing;
  final bool? showQuantityAndSubtotalField;
  final Widget? moreButtonWidget;
  final bool? canEditQuantity;
  final void Function()? onShowMoreButtonClickedCallback;
  final void Function(int quantity) onCartQuantityChangedCallback;
  final void Function(CartLineEntity) onCartLineRemovedCallback;
  const QuoteLineWidget(
      {super.key,
      required this.quoteLineEntity,
      required this.onCartQuantityChangedCallback,
      required this.onCartLineRemovedCallback,
      this.onShowMoreButtonClickedCallback,
      this.showRemoveButton = true,
      this.showViewBreakPricing = false,
      this.showQuantityAndSubtotalField = true,
      this.canEditQuantity = true,
      this.moreButtonWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          _buildProductDetails(context),
          Visibility(
              visible: showRemoveButton!, child: _buildRemoveButton(context)),
          Visibility(
              visible: moreButtonWidget != null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: moreButtonWidget ?? Container(),
              ))
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return LineItemImageWidget(imagePath: quoteLineEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineItemTitleWidget(
            shortDescription: quoteLineEntity.shortDescription,
            manufacturerItem: quoteLineEntity.manufacturerItem,
            productNumber: quoteLineEntity.getProductNumber(),
          ),
          LineItemPricingWidget(
              discountMessage: quoteLineEntity.pricing?.getDiscountValue(),
              priceValueText: quoteLineEntity.updatePriceValueText(),
              unitOfMeasureValueText:
                  quoteLineEntity.updateUnitOfMeasureValueText(),
              availabilityText: quoteLineEntity.availability?.message,
              productId: quoteLineEntity.productId,
              erpNumber: quoteLineEntity.erpNumber,
              unitOfMeasure: quoteLineEntity.baseUnitOfMeasure,
              showViewAvailabilityByWarehouse: false),
          Visibility(
            visible: showViewBreakPricing!,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 15),
              child: GestureDetector(
                onTap: () {
                  viewQuoteLineBreakPricingWidget(
                      context, quoteLineEntity.quoteLinePricingBreakList ?? []);
                },
                child: Text(
                  LocalizationConstants.viewQuotedPricing,
                  style: OptiTextStyles.link,
                ),
              ),
            ),
          ),
          Visibility(
            visible: showQuantityAndSubtotalField!,
            child: LineItemQuantityGroupWidget(
              qtyOrdered: quoteLineEntity.qtyOrdered?.toInt().toString(),
              canEdit: canEditQuantity!,
              onQtyChanged: (int? qty) {
                if (qty == null) {
                  return;
                }

                onCartQuantityChangedCallback(qty);
              },
              subtotalPriceText: quoteLineEntity.updateSubtotalPriceValueText(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        onCartLineRemovedCallback(quoteLineEntity);
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
