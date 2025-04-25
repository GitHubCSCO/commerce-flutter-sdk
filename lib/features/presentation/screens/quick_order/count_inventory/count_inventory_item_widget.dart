import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/quick_order/order_widgets/order_product_image_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';

class CountInventoryItemWidget extends StatelessWidget {
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity quickOrderItemEntity;

  const CountInventoryItemWidget(
      {super.key, required this.callback, required this.quickOrderItemEntity});

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

    final part = _buildRow(
        LocalizationConstants.partNumberSign.localized(),
        OptiTextStyles.subtitle,
        quickOrderItemEntity.productEntity.getProductNumber(),
        OptiTextStyles.body);
    final myPart = _buildRow(
        LocalizationConstants.myPartNumberSign.localized(),
        OptiTextStyles.subtitle,
        quickOrderItemEntity.productEntity.customerName ?? '',
        OptiTextStyles.body);
    final mfg = _buildRow(
        LocalizationConstants.mFGNumberSign.localized(),
        OptiTextStyles.subtitle,
        quickOrderItemEntity.productEntity.manufacturerItem ?? '',
        OptiTextStyles.body);
    final bin = _buildRow(
        LocalizationConstants.binSign.localized(),
        OptiTextStyles.subtitle,
        quickOrderItemEntity.vmiBinEntity?.binNumber ?? '',
        OptiTextStyles.body);
    final count = _buildRow(
        LocalizationConstants.count.localized(),
        OptiTextStyles.subtitle,
        quickOrderItemEntity.quantityOrdered.toInt().toString(),
        OptiTextStyles.body);
    final maxCount = _buildRow(
        LocalizationConstants.maxSign.localized(),
        OptiTextStyles.subtitle,
        quickOrderItemEntity.vmiBinEntity?.maximumQty?.toInt().toString() ?? '',
        OptiTextStyles.body);
    final minCount = _buildRow(
        LocalizationConstants.minSign.localized(),
        OptiTextStyles.subtitle,
        quickOrderItemEntity.vmiBinEntity?.minimumQty?.toInt().toString() ?? '',
        OptiTextStyles.body);

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
    if (count != null) {
      list.add(count);
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
          OrderVmiProductTitleWidget(
              callback: callback, orderItemEntity: quickOrderItemEntity),
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

  Widget? _buildRow(String title, TextStyle titleTextStyle, String body,
      TextStyle bodyTextStyle) {
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
  final Function(BuildContext context, QuickOrderItemEntity,
      OrderCallBackType orderCallBackType) callback;
  final QuickOrderItemEntity orderItemEntity;

  const OrderVmiProductTitleWidget(
      {super.key, required this.callback, required this.orderItemEntity});

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
                  visible:
                      orderItemEntity.productEntity.brand?.name?.isNotEmpty ??
                          false,
                  child: Text(
                    orderItemEntity.productEntity.brand?.name ?? '',
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Visibility(
                  visible: orderItemEntity
                          .productEntity.shortDescription?.isNotEmpty ??
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
          _buildMenuButton(context)
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: BottomMenuWidget(
            isViewOnWebsiteEnable: false,
            toolMenuList: _buildToolMenu(context)),
      ),
    );
  }

  List<ToolMenu> _buildToolMenu(BuildContext context) {
    List<ToolMenu> list = [];
    list.add(ToolMenu(
        title: LocalizationConstants.newCount.localized(),
        action: () {
          callback(context, orderItemEntity, OrderCallBackType.newCount);
        }));
    list.add(ToolMenu(
        title: LocalizationConstants.remove.localized(),
        action: () {
          callback(context, orderItemEntity, OrderCallBackType.itemDelete);
        }));
    return list;
  }
}
