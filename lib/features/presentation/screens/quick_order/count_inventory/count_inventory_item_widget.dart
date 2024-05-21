import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/order_widgets/order_product_image_widget.dart';
import 'package:flutter/material.dart';

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

    final part = _buildRow(LocalizationConstants.partNumberSign, OptiTextStyles.subtitle, '', OptiTextStyles.body);
    final bin = _buildRow(LocalizationConstants.binSign, OptiTextStyles.subtitle, '', OptiTextStyles.body);
    final maxCount = _buildRow(LocalizationConstants.maxSign, OptiTextStyles.subtitle, '', OptiTextStyles.body);
    final minCount = _buildRow(LocalizationConstants.minSign, OptiTextStyles.subtitle, '', OptiTextStyles.body);

    if (part != null) {
      list.add(part);
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

    return Column(
      children: list,
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

