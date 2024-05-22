import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/order_widgets/order_product_image_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountInventoryItemWidget extends StatelessWidget {

  final QuickOrderItemEntity quickOrderItemEntity;

  const CountInventoryItemWidget({super.key, required this.quickOrderItemEntity});

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
            _buildVmiBinDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return OrderProductImageWidget(
        imagePath: quickOrderItemEntity.productEntity.smallImagePath ?? "");
  }

  Widget _buildVmiBinDetails() {
    List<Widget> list = [];

    final part = _buildRow(LocalizationConstants.partNumberSign, OptiTextStyles.subtitle, quickOrderItemEntity.productEntity.productNumber ?? '', OptiTextStyles.body);
    final myPart = _buildRow(LocalizationConstants.myPartNumberSign, OptiTextStyles.subtitle, quickOrderItemEntity.productEntity.customerName ?? '', OptiTextStyles.body);
    final mfg = _buildRow(LocalizationConstants.mFGNumberSign, OptiTextStyles.subtitle, quickOrderItemEntity.productEntity.manufacturerItem ?? '', OptiTextStyles.body);
    final bin = _buildRow(LocalizationConstants.binSign, OptiTextStyles.subtitle, quickOrderItemEntity.vmiBinEntity?.binNumber ?? '', OptiTextStyles.body);
    final maxCount = _buildRow(LocalizationConstants.maxSign, OptiTextStyles.subtitle, quickOrderItemEntity.vmiBinEntity?.maximumQty.toString() ?? '', OptiTextStyles.body);
    final minCount = _buildRow(LocalizationConstants.minSign, OptiTextStyles.subtitle, quickOrderItemEntity.vmiBinEntity?.minimumQty.toString() ?? '', OptiTextStyles.body);

    if (part != null) {
      list.add(part);
    }
    if (myPart != null) {
      list.add(myPart);
    }
    if (mfg != null) {
      list.add(mfg);
    }
    if (bin != null) {
      list.add(bin);
    }
    if (maxCount != null) {
      list.add(maxCount);
    }
    if (minCount != null) {
      list.add(minCount);
    }

    return Expanded(
      child: Column(
        children: [
          OrderVmiProductTitleWidget(orderItemEntity: quickOrderItemEntity),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: list,
            ),
          )
        ],
      ),
    );
  }

  Widget? _buildRow(String title, TextStyle titleTextStyle, String body, TextStyle bodyTextStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: titleTextStyle,
              ),
            ),
          ),
          Text(
            body,
            textAlign: TextAlign.start,
            style: bodyTextStyle,
          )
        ],
      );
    }
  }

}

class OrderVmiProductTitleWidget extends StatelessWidget {

  // final Function(BuildContext context, QuickOrderItemEntity,
  //     OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity orderItemEntity;

  const OrderVmiProductTitleWidget({Key? key, required this.orderItemEntity})
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
        // callback(context, orderItemEntity, OrderCallBackType.itemDelete);
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

