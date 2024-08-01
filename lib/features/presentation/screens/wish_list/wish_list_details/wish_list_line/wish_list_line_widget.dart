import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/wish_list_line_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_details/wish_list_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_details/wish_list_line/wish_list_line_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_details/wish_list_line/wish_list_line_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_quantity_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_title_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListLineWidget extends StatelessWidget {
  final WishListLineEntity wishListLineEntity;
  final bool realTimeLoading;
  final bool isDeleteButtonVisible;
  final bool canEditQuantity;

  const WishListLineWidget({
    super.key,
    required this.wishListLineEntity,
    this.isDeleteButtonVisible = true,
    this.realTimeLoading = false,
    this.canEditQuantity = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String? errorMessage;
        if (wishListLineEntity.isDiscontinued == true ||
            wishListLineEntity.isActive != true) {
          errorMessage = SiteMessageConstants
              .defaultValueWishListItemsDiscontinuedAndRemoved;
        }

        if (wishListLineEntity.isVisible != true) {
          errorMessage = SiteMessageConstants
              .defaultValueWishListItemsNotDisplayedDueRestrictions;
        }

        if (!errorMessage.isNullOrEmpty) {
          displayDialogWidget(
            context: context,
            message:
                '${errorMessage ?? ''} ${LocalizationConstants.removeItemFromTheList.localized()}',
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(LocalizationConstants.cancel.localized()),
              ),
              TextButton(
                onPressed: () {
                  context.read<WishListDetailsCubit>().deleteWishListLine(
                        wishListLineEntity,
                      );
                  Navigator.of(context).pop();
                },
                child: Text(LocalizationConstants.oK.localized()),
              ),
            ],
          );

          return;
        }

        _navigateToProductDetails(context);
      },
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(
              realTimeLoading: realTimeLoading,
              canEditQuantity: canEditQuantity,
              context: context,
            ),
            _buildRemoveAndAddToCartButton(
              context,
              canAddToCart: wishListLineEntity.canAddToCart == true,
              isDeleteButtonVisible: isDeleteButtonVisible,
              wishListLineEntity: wishListLineEntity,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context) {
    var productId = wishListLineEntity.productId;
    AppRoute.productDetails.navigateBackStack(context,
        pathParameters: {"productId": productId.toString()},
        extra: ProductEntity());
  }

  Widget _buildProductImage() {
    return WishListContentProductImageWidget(
        imagePath: wishListLineEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails({
    required bool realTimeLoading,
    required bool canEditQuantity,
    required BuildContext context,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineItemTitleWidget(
            shortDescription: wishListLineEntity.shortDescription,
            manufacturerItem: wishListLineEntity.manufacturerItem,
            productNumber: wishListLineEntity.erpNumber,
          ),
          WishListContentPricingWidget(
            wishListLineEntity: wishListLineEntity,
            realTimeLoading: realTimeLoading,
          ),
          LineItemQuantityGroupWidget(
            qtyOrdered: wishListLineEntity.qtyOrdered?.toInt().toString(),
            subtotalPriceText: wishListLineEntity.updateSubtotalPriceValueText,
            canEdit: canEditQuantity,
            realTimeLoading: realTimeLoading,
            onQtyChanged: canEditQuantity
                ? (int? quantity) async {
                    final newWishListLineEntity =
                        wishListLineEntity.copyWith(qtyOrdered: quantity);
                    await context
                        .read<WishListDetailsCubit>()
                        .updateWishListLineQuantity(
                          newWishListLineEntity,
                          quantity ??
                              (wishListLineEntity.qtyOrdered as int?) ??
                              1,
                        );
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveAndAddToCartButton(
    BuildContext context, {
    bool canAddToCart = false,
    bool isDeleteButtonVisible = true,
    required WishListLineEntity wishListLineEntity,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (canAddToCart)
          InkWell(
            onTap: () async {
              await context.read<WishListDetailsCubit>().addWishListLineToCart(
                    wishListLineEntity,
                  );
            },
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
            onTap: () async {
              await context.read<WishListDetailsCubit>().deleteWishListLine(
                    wishListLineEntity,
                  );
            },
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
