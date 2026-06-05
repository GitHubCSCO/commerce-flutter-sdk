import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/wish_list_line_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/view_warehouse_availability_widget.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class WishListContentPricingWidget extends StatelessWidget {
  final WishListLineEntity wishListLineEntity;
  final bool realTimeLoading;
  final bool showSavingsAmount;
  final bool showSavingsPercent;

  const WishListContentPricingWidget({
    required this.wishListLineEntity,
    this.realTimeLoading = false,
    this.showSavingsAmount = true,
    this.showSavingsPercent = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDiscountMessageSection(
                context,
                wishListLineEntity,
                showSavingsAmount: showSavingsAmount,
                showSavingsPercent: showSavingsPercent,
              ),
              realTimeLoading
                  ? Container(
                      alignment: Alignment.bottomLeft,
                      child: LoadingAnimationWidget.progressiveDots(
                        color: context.colors.iconPrimary,
                        size: 30,
                      ),
                    )
                  : _buildPricingSection(context, wishListLineEntity),

              wishListLineEntity.availability?.message != null
                  ? _buildInventorySection(context, wishListLineEntity)
                  : Container(),
              // _buildInventorySection(context),
              Visibility(
                visible: wishListLineEntity.availability?.message != null &&
                    wishListLineEntity.availability?.message != "",
                child: GestureDetector(
                  onTap: () {
                    viewWarehouseWidget(
                        context,
                        wishListLineEntity.productId,
                        wishListLineEntity.getProductNumber(),
                        wishListLineEntity.unitOfMeasure ?? "");
                  },
                  child: Text(
                    "View Availability by Warehouse",
                    style: context.text.link,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDiscountMessageSection(
  BuildContext context,
  WishListLineEntity wishListLineEntity, {
  bool showSavingsAmount = true,
  bool showSavingsPercent = true,
}) {
  var discountMessage = wishListLineEntity.pricing?.getDiscountValue(
    showSavingsAmount: showSavingsAmount,
    showSavingsPercent: showSavingsPercent,
  );
  if (discountMessage != null &&
      discountMessage.isNotEmpty &&
      discountMessage != "null") {
    return Text(
      discountMessage,
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          color: context.colors.textSecondary),
    );
  }
  return Container();
}

Widget _buildPricingSection(
    BuildContext context, WishListLineEntity wishListLineEntity) {
  return Row(
    children: [
      Text(wishListLineEntity.updatePriceValueText,
          style: context.text.bodySmallHighlight),
      Text(
        wishListLineEntity.updateUnitOfMeasureValueText,
        style: context.text.bodySmall,
      ),
    ],
  );
}

Widget _buildInventorySection(
    BuildContext context, WishListLineEntity wishListLineEntity) {
  return Text(
    wishListLineEntity.availability?.message ?? '',
    style: context.text.body,
  );
}
