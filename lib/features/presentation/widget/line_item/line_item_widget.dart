import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LineItemWidget extends StatelessWidget {
  final String? productId;
  final String? imagePath;
  final String? shortDescription;
  final String? manufacturerItem;
  final String? productNumber;
  final String? discountMessage;
  final String? priceValueText;
  final String? unitOfMeasureValueText;
  final String? availabilityText;
  final String? qtyOrdered;
  final String? subtotalPriceText;
  final bool canEditQty;
  final bool showViewQuantityPricing;
  final bool showViewAvailabilityByWarehouse;
  final bool canAddToCart;
  final bool isDeleteButtonVisible;
  final void Function()? onAddToCart;
  final void Function()? onDelete;
  final String? unitOfMeasure;


  const LineItemWidget({
    super.key,
    this.productId,
    this.imagePath,
    this.shortDescription,
    this.manufacturerItem,
    this.productNumber,
    this.discountMessage,
    this.priceValueText,
    this.unitOfMeasureValueText,
    this.availabilityText,
    this.qtyOrdered,
    this.subtotalPriceText,
    this.canEditQty = true,
    this.showViewQuantityPricing = true,
    this.showViewAvailabilityByWarehouse = true,
    this.canAddToCart = false,
    this.isDeleteButtonVisible = false,
    this.onAddToCart,
    this.onDelete, this.unitOfMeasure,
  });

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
            _buildRemoveAndAddToCartButton(),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context) {
    AppRoute.productDetails.navigateBackStack(
      context,
      pathParameters: {"productId": productId.toString()},
      extra: ProductEntity(),
    );
  }

  Widget _buildProductImage() {
    return LineItemImageWidget(imagePath: imagePath ?? '');
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineItemTitleWidget(
            shortDescription: shortDescription,
            manufacturerItem: manufacturerItem,
            productNumber: productNumber,
          ),
          LineItemPricingWidget(
            discountMessage: discountMessage,
            priceValueText: priceValueText,
            unitOfMeasureValueText: unitOfMeasureValueText,
            availabilityText: availabilityText,
            showViewQuantityPricing: showViewQuantityPricing,
            showViewAvailabilityByWarehouse: showViewAvailabilityByWarehouse,
            productId: productId,
            erpNumber: productNumber,
            unitOfMeasure: unitOfMeasure,
          ),
          LineItemQuantityGroupWidget(
            qtyOrdered: qtyOrdered,
            subtotalPriceText: subtotalPriceText,
            canEdit: canEditQty,
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveAndAddToCartButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (canAddToCart)
          InkWell(
            onTap: onAddToCart,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
              child: SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  AssetConstants.wishListLineAddToCartIcon,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        if (isDeleteButtonVisible)
          InkWell(
            onTap: onDelete,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
              child: SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  AssetConstants.cartItemRemoveIcon,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        const SizedBox(width: 20),
      ],
    );
  }
}
