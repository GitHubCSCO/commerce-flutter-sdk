import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/view_quote_line_break_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteLineWidget extends StatelessWidget {
  final QuoteLineEntity quoteLineEntity;
  final String? viewQuotedPricingTitle;
  final bool? showRemoveButton;
  final bool? showViewBreakPricing;
  final bool? showQuantityAndSubtotalField;
  final Widget? moreButtonWidget;
  final bool? canEditQuantity;
  final bool hidePricingEnable;
  final bool hideInventoryEnable;
  final bool? hidePricingWidget;
  final void Function()? onShowMoreButtonClickedCallback;
  final void Function(int quantity) onCartQuantityChangedCallback;
  final void Function(CartLineEntity) onCartLineRemovedCallback;
  const QuoteLineWidget(
      {super.key,
      required this.quoteLineEntity,
      required this.onCartQuantityChangedCallback,
      required this.onCartLineRemovedCallback,
      required this.hidePricingEnable,
      required this.hideInventoryEnable,
      this.viewQuotedPricingTitle = "",
      this.onShowMoreButtonClickedCallback,
      this.showRemoveButton = true,
      this.hidePricingWidget = false,
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
          QuoteLineItemTitleWidget(
            shortDescription: quoteLineEntity.shortDescription,
            manufacturerItem: quoteLineEntity.manufacturerItem,
            productNumber:
                QuoteLineExtensions(quoteLineEntity).getProductNumber(),
            myPartNumberValueLabel: quoteLineEntity.customerName,
            quantityValueLabel: quoteLineEntity.qtyOrdered?.toInt().toString(),
          ),
          Visibility(
            visible: !hidePricingWidget!,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: LineItemPricingWidget(
                hideInventoryEnable: hideInventoryEnable,
                hidePricingEnable: hidePricingEnable,
                discountMessage: quoteLineEntity.pricing?.getDiscountValue(),
                priceValueText: quoteLineEntity.updatePriceValueText(),
                unitOfMeasureValueText:
                    quoteLineEntity.updateUnitOfMeasureValueText(),
                availabilityText: quoteLineEntity.availability?.message,
                productId: quoteLineEntity.productId,
                erpNumber:
                    QuoteLineExtensions(quoteLineEntity).getProductNumber(),
                unitOfMeasure: quoteLineEntity.baseUnitOfMeasure,
                showViewAvailabilityByWarehouse: false,
              ),
            ),
          ),
          Visibility(
            visible: showViewBreakPricing! && !hidePricingEnable,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 15),
              child: GestureDetector(
                onTap: () {
                  viewQuoteLineBreakPricingWidget(
                      context, quoteLineEntity.quoteLinePricingBreakList ?? []);
                },
                child: Text(
                  viewQuotedPricingTitle ??
                      LocalizationConstants.viewQuotedPricing.localized(),
                  style: OptiTextStyles.link,
                ),
              ),
            ),
          ),
          Visibility(
            visible: showQuantityAndSubtotalField!,
            child: LineItemQuantityGroupWidget(
              hidePricingEnable: hidePricingEnable,
              qtyOrdered: quoteLineEntity.qtyOrdered?.toInt().toString(),
              canEdit: canEditQuantity!,
              onQtyChanged: (int? qty) {
                if (qty == null) {
                  return;
                }

                onCartQuantityChangedCallback(qty);
              },
              subtotalPriceText:
                  quoteLineEntity.pricing?.extendedUnitNetPriceDisplay ?? "",
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
        padding: const EdgeInsets.all(10.0),
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

class QuoteLineItemTitleWidget extends StatelessWidget {
  final String? shortDescription;
  final String? productNumber;
  final String? manufacturerItem;
  final String? myPartNumberValueLabel;
  final String? quantityValueLabel;

  const QuoteLineItemTitleWidget({
    super.key,
    this.shortDescription,
    this.productNumber,
    this.manufacturerItem,
    this.myPartNumberValueLabel,
    this.quantityValueLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    shortDescription ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: OptiTextStyles.body,
                    textAlign: TextAlign.left,
                  ),
                ),
                if (!productNumber.isNullOrEmpty)
                  Text(
                    productNumber!,
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                if (!manufacturerItem.isNullOrEmpty)
                  Row(
                    children: [
                      Text(
                        "${LocalizationConstants.mFGNumberSign.localized()} ",
                        style: OptiTextStyles.subtitle.copyWith(fontSize: 12),
                      ),
                      Text(
                        manufacturerItem ?? '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                if (!myPartNumberValueLabel.isNullOrEmpty)
                  Row(
                    children: [
                      Text(
                        myPartNumberValueLabel ?? '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                if (!quantityValueLabel.isNullOrEmpty)
                  Row(
                    children: [
                      Text(
                        LocalizationConstants.qTY.localized(),
                        style: OptiTextStyles.subtitle.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        quantityValueLabel ?? '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
