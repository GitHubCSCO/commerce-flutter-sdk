import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/quick_order/order_item_pricing_inventory_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderItemWidget extends StatelessWidget {
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity quickOrderItemEntity;
  final ProductSettings setting;

  QuickOrderItemWidget(
      {required this.callback, required this.quickOrderItemEntity, required this.setting});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(),
            _buildProductDetails(),
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
          OrderProductTitleWidget(callback: callback, orderItemEntity: quickOrderItemEntity),
          BlocConsumer<OrderItemPricingInventoryCubit,
              OrderItemPricingInventoryState>(
            listener: (context, state) {
              if (state is OrderItemSubTotalChange) {
                callback(context, quickOrderItemEntity, OrderCallBackType.calculateSubtotal);
              }
            },
            buildWhen: (previous, current) =>
                current is OrderItemPricingInventoryInitial ||
                current is OrderItemPricingInventoryLoading ||
                current is OrderItemPricingInventoryLoaded ||
                current is OrderItemPricingInventoryFailed,
            builder: (context, state) {
              switch (state.runtimeType) {
                case OrderItemPricingInventoryInitial:
                case OrderItemPricingInventoryLoading:
                  return Container(
                    padding: const EdgeInsets.only(left: 20, top: 12),
                    alignment: Alignment.bottomLeft,
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: OptiAppColors.iconPrimary,
                      size: 30,
                    ),
                  );
                case OrderItemPricingInventoryLoaded:
                  return OrderProductPricingWidget(
                      orderItemEntity: quickOrderItemEntity);
                case OrderItemPricingInventoryFailed:
                default:
                  return Container();
              }
            },
          ),
          OrderProductQuantityGroupWidget(callback, quickOrderItemEntity, setting)
        ],
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

  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity orderItemEntity;

  const OrderProductTitleWidget({Key? key, required this.callback, required this.orderItemEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: orderItemEntity.productEntity.brand?.name?.isNotEmpty ??
                      false,
                  child: Text(
                    orderItemEntity.productEntity.brand?.name ?? '',
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible:
                  orderItemEntity.productEntity.shortDescription?.isNotEmpty ??
                      false,
                  child: Text(
                    orderItemEntity.productEntity.shortDescription ?? '',
                    style: OptiTextStyles.body,
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible:
                  orderItemEntity.productEntity
                      .getProductNumber()
                      .isNotEmpty,
                  child: Text(
                    orderItemEntity.productEntity.getProductNumber() ?? '',
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: orderItemEntity.productEntity.customerName?.isNotEmpty ??
                      false,
                  child: Row(children: [
                    Text(
                      LocalizationConstants.myPartNumberSign,
                      style: OptiTextStyles.bodySmallHighlight,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        orderItemEntity.productEntity.customerName ?? '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ]),
                ),
                Visibility(
                  visible:
                  orderItemEntity.productEntity.manufacturerItem?.isNotEmpty ??
                      false,
                  child: Row(children: [
                    Text(
                      LocalizationConstants.mFGNumberSign,
                      style: OptiTextStyles.bodySmallHighlight,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        orderItemEntity.productEntity.manufacturerItem ?? '',
                        style: OptiTextStyles.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          _buildRemoveButton(context)
        ],
      ),
    );
  }

  Widget _buildRemoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        callback(context, orderItemEntity, OrderCallBackType.itemDelete);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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

class OrderProductPricingWidget extends StatelessWidget {
  final QuickOrderItemEntity orderItemEntity;

  const OrderProductPricingWidget({
    required this.orderItemEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            //add showhide pricing logic
            visible: orderItemEntity.discountValueText?.isNotEmpty ?? false,
            child: Text(
              orderItemEntity.discountValueText ?? '',
              style: OptiTextStyles.bodySmall,
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderItemEntity.priceValueText ?? '',
                style: OptiTextStyles.bodySmallHighlight,
                textAlign: TextAlign.left,
              ),
              Text(
                orderItemEntity.selectedUnitOfMeasureTitle != null
                    ? (' / ${orderItemEntity.selectedUnitOfMeasureTitle}')
                    : '',
                style: OptiTextStyles.bodySmall,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Visibility(
            //need to apply different availblity color
            visible: orderItemEntity.showInventoryAvailability != null,
            child: Text(
              orderItemEntity.availability?.message ?? '',
              style: OptiTextStyles.bodySmall,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderProductQuantityGroupWidget extends StatelessWidget {
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity quickOrderItemEntity;
  final ProductSettings setting;

  OrderProductQuantityGroupWidget(this.callback, this.quickOrderItemEntity, this.setting);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NumberTextField(
                initialtText: quickOrderItemEntity.quantityOrdered.toString(),
                shouldShowIncrementDecermentIcon: false,
                onChanged: (int? quantity) {
                  if ((quantity ?? 0) == 0) {
                    quickOrderItemEntity.previousQty = quickOrderItemEntity.quantityOrdered;
                  }
                  quickOrderItemEntity.quantityOrdered = quantity ?? 0;
                  context.read<OrderItemPricingInventoryCubit>().getPricingAndInventory(quickOrderItemEntity, setting);
                }),
          ),
          // CartContentTitleSubTitleColumn('U/M', 'E/A'),
          BlocBuilder<OrderItemPricingInventoryCubit,
              OrderItemPricingInventoryState>(
            buildWhen: (previous, current) =>
            current is OrderItemPricingInventoryInitial ||
                current is OrderItemPricingInventoryLoading ||
                current is OrderItemPricingInventoryLoaded ||
                current is OrderItemPricingInventoryFailed,
            builder: (context, state) {
              switch (state.runtimeType) {
                case OrderItemPricingInventoryInitial:
                case OrderItemPricingInventoryLoading:
                  return Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, top: 12),
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: OptiAppColors.iconPrimary,
                        size: 30,
                      ),
                    ),
                  );
                case OrderItemPricingInventoryLoaded:
                  return OrderProductSubTitleColumn(
                      LocalizationConstants.subtotal,
                      quickOrderItemEntity.extendedPriceValueText ?? '');
                case OrderItemPricingInventoryFailed:
                default:
                  return Container();
              }
            },
          ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            Text(
              title,
              style: OptiTextStyles.bodySmall,
            ),
            Text(
              value,
              style: OptiTextStyles.titleSmall,
            )
          ],
        ),
      ),
    );
  }
}
