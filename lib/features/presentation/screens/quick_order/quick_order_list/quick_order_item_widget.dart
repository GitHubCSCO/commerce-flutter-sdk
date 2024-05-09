import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickOrderItemWidget extends StatelessWidget {

  final Function(BuildContext context, QuickOrderItemEntity, OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity quickOrderItemEntity;

  QuickOrderItemWidget({required this.callback, required this.quickOrderItemEntity});

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
    var productId = quickOrderItemEntity.productEntity.id;
    AppRoute.productDetails.navigateBackStack(context,
        pathParameters: {"productId": productId.toString()},
        extra: ProductEntity());
  }

  Widget _buildProductImage() {
    return OrderProductImageWidget(
        imagePath: quickOrderItemEntity.productEntity.smallImagePath ?? "");
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderProductTitleWidget(cartLineEntity: quickOrderItemEntity),
          OrderProductPricingWidget(cartLineEntity: quickOrderItemEntity),
          OrderProductQuantityGroupWidget(callback, quickOrderItemEntity)
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        callback(context, quickOrderItemEntity, OrderCallBackType.itemDelete);
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

class OrderProductImageWidget extends StatelessWidget {
  final String imagePath;
  const OrderProductImageWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26.0, 22.0, 0.0, 0.0),
      child: Container(
        width: 65,
        height: 65,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD6D6D6)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imagePath.makeImageUrl(),
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              // This function is called when the image fails to load
              return Container(
                color: OptiAppColors.backgroundGray, // Placeholder color
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image, // Icon to display
                  color: Colors.grey, // Icon color
                  size: 30, // Icon size
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class OrderProductTitleWidget extends StatelessWidget {
  final QuickOrderItemEntity cartLineEntity;

  const OrderProductTitleWidget({Key? key, required this.cartLineEntity})
      : super(key: key);

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
                Text(
                  cartLineEntity.productEntity.shortDescription ?? '',
                  style: OptiTextStyles.body,
                  textAlign: TextAlign.left,
                ),
                if (cartLineEntity.productEntity.getProductNumber() != '')
                  Text(
                    cartLineEntity.productEntity.getProductNumber(),
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                if (cartLineEntity.productEntity.manufacturerItem != null &&
                    cartLineEntity.productEntity.manufacturerItem!.isNotEmpty)
                  Row(children: [
                    Text(
                      cartLineEntity.productEntity.manufacturerItem ?? '',
                      style: OptiTextStyles.bodySmall,
                      textAlign: TextAlign.left,
                    ),
                  ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderProductPricingWidget extends StatelessWidget {
  final QuickOrderItemEntity cartLineEntity;

  const OrderProductPricingWidget({
    required this.cartLineEntity,
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
              _buildDiscountMessageSection(context, cartLineEntity),
              _buildPricingSection(context, cartLineEntity),
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Quantity Pricing",
                  style: OptiTextStyles.link,
                ),
              ),
              cartLineEntity.productEntity.availability?.message != null
                  ? _buildInventorySection(context, cartLineEntity)
                  : Container(),
              // _buildInventorySection(context),
              // For "View Availability by Warehouse"
              GestureDetector(
                onTap: () {
                  // TODO: Implement the logic for "View Quantity Pricing"
                  CustomSnackBar.showComingSoonSnackBar(context);
                },
                child: Text(
                  "View Availability by Warehouse",
                  style: OptiTextStyles.link,
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
    BuildContext context, QuickOrderItemEntity cartLineEntity) {
  var discountMessage = cartLineEntity.productEntity.pricing?.getDiscountValue();
  if (discountMessage != null &&
      discountMessage.isNotEmpty &&
      discountMessage != "null") {
    return Text(
      discountMessage,
      style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
          color: OptiAppColors.textSecondary),
    );
  }
  return Container();
}

Widget _buildPricingSection(
    BuildContext context, QuickOrderItemEntity cartLineEntity) {
  return Container(
    child: Row(
      children: [
        Text(cartLineEntity.productEntity.updatePriceValueText(false),
            style: OptiTextStyles.bodySmallHighlight),
        Text(
          cartLineEntity.productEntity.updateUnitOfMeasure(true),
          style: OptiTextStyles.bodySmall,
        ),
      ],
    ),
  );
}

Widget _buildInventorySection(
    BuildContext context, QuickOrderItemEntity cartLineEntity) {
  return Container(
    child: Text(
      cartLineEntity.productEntity.availability?.message ?? '',
      style: OptiTextStyles.body,
    ),
  );
}


class OrderProductQuantityGroupWidget extends StatelessWidget {

  final Function(BuildContext context, QuickOrderItemEntity, OrderCallBackType orderCallBackType) callback;
  QuickOrderItemEntity cartLineEntity;

  OrderProductQuantityGroupWidget(this.callback, this.cartLineEntity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NumberTextField(
                initialtText: '1',
                shouldShowIncrementDecermentIcon: false,
                onChanged: (int? quantity) {
                  cartLineEntity =
                      cartLineEntity.copyWith(quantityOrdered: quantity);
                  callback(context, cartLineEntity, OrderCallBackType.quantityChange);
                }),
          ),
          // CartContentTitleSubTitleColumn('U/M', 'E/A'),
          OrderProductSubTitleColumn(
              'Subtotal', cartLineEntity.productEntity.updateSubtotalPriceValueText()),
        ],
      ),
    );
  }
}

class OrderProductSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;

  OrderProductSubTitleColumn(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            title,
            style: OptiTextStyles.bodySmall,
          ),
          Text(
            value,
            style: OptiTextStyles.titleLarge,
          )
        ],
      ),
    );
  }
}


