import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:flutter/material.dart';

class CountInventoryEntity {

  final VmiBinModelEntity vmiBinEntity;
  final OrderEntity previousOrder;

  CountInventoryEntity({required this.vmiBinEntity, required this.previousOrder});

}

class CountInventoryScreen extends StatelessWidget {
  final CountInventoryEntity countInventoryEntity;

  const CountInventoryScreen({super.key, required this.countInventoryEntity});

  @override
  Widget build(BuildContext context) {
    return CountInputPage(countInventoryEntity: countInventoryEntity);
  }
}

class CountInputPage extends StatelessWidget {

  final CountInventoryEntity countInventoryEntity;

  const CountInputPage({super.key, required this.countInventoryEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundGray,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductListItemWithTitleAndNumber(
              imageUrl: countInventoryEntity.vmiBinEntity.productEntity?.smallImagePath,
              title: countInventoryEntity.vmiBinEntity.productEntity?.shortDescription,
              productNumber: countInventoryEntity.vmiBinEntity.productEntity?.erpNumber,
            ),
            _getHistoryWidget(),
            _getQtyInputWidget()
          ],
        ),
      ),
    );
  }

  Widget _getQtyInputWidget() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.qTY, style: OptiTextStyles.body),
          NumberTextField(
              initialtText: (countInventoryEntity.vmiBinEntity.lastCountQty ?? 0).toString(),
              shouldShowIncrementDecermentIcon: false,
          )
        ],
      ),
    );
  }

  Widget _getHistoryWidget() {
    return Column(
      children: [
        _getPreviousCountWidget(),
        _getPreviousOrderWidget(),
      ],
    );
  }

  Widget _getPreviousCountWidget() {
    List<Widget> list = [];

    final date = _buildRow(LocalizationConstants.dateSign, OptiTextStyles.subtitle, countInventoryEntity.vmiBinEntity.previousCountDate.formatDate(format: 'dd/MM/yyyy'), OptiTextStyles.body);
    final countQty = _buildRow(LocalizationConstants.countQTYSign, OptiTextStyles.subtitle, (countInventoryEntity.vmiBinEntity.previousCountQty ?? 0).toString(), OptiTextStyles.body);

    if (date != null) {
      list.add(date);
    }
    if (countQty != null) {
      list.add(countQty);
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.previousCount, style: OptiTextStyles.titleLarge),
          ...list
        ],
      ),
    );
  }

  Widget _getPreviousOrderWidget() {
    List<Widget> list = [];

    final date = _buildRow(
        LocalizationConstants.dateSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.previousOrder.orderDate
                .formatDate(format: 'dd/MM/yyyy'),
        OptiTextStyles.body);
    final countQty = _buildRow(
        LocalizationConstants.orderQTYSign,
        OptiTextStyles.subtitle,
        _getPreviousOrderQty(countInventoryEntity.previousOrder,
            countInventoryEntity.vmiBinEntity),
        OptiTextStyles.body);
    final order = _buildRow(
        LocalizationConstants.orderSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.previousOrder.orderNumber ?? '',
        OptiTextStyles.body);

    if (date != null) {
      list.add(date);
    }
    if (countQty != null) {
      list.add(countQty);
    }
    if (order != null) {
      list.add(order);
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocalizationConstants.previousCount, style: OptiTextStyles.titleLarge),
          ...list
        ],
      ),
    );
  }

  Widget getProductInfoWidget() {
    List<Widget> list = [];

    final part = _buildRow(
        LocalizationConstants.partNumberSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.vmiBinEntity.productEntity?.productNumber ?? '',
        OptiTextStyles.body);
    final myPart = _buildRow(
        LocalizationConstants.myPartNumberSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.vmiBinEntity.productEntity?.customerName ?? '',
        OptiTextStyles.body);
    final mfg = _buildRow(
        LocalizationConstants.mFGNumberSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.vmiBinEntity.productEntity?.manufacturerItem ?? '',
        OptiTextStyles.body);
    final bin = _buildRow(
        LocalizationConstants.binSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.vmiBinEntity.binNumber ?? '',
        OptiTextStyles.body);
    final maxCount = _buildRow(
        LocalizationConstants.maxSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.vmiBinEntity.maximumQty.toString() ?? '',
        OptiTextStyles.body);
    final minCount = _buildRow(
        LocalizationConstants.minSign,
        OptiTextStyles.subtitle,
        countInventoryEntity.vmiBinEntity.minimumQty.toString() ?? '',
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
    if (maxCount != null) {
      list.add(maxCount);
    }
    if (minCount != null) {
      list.add(minCount);
    }

    return Expanded(
      child: Column(
        children: [
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
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
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
        ),
      );
    }
  }

  String _getPreviousOrderQty(OrderEntity previousOrder, VmiBinModelEntity vmiBinEntity) {
    if (previousOrder.orderLines?.isNotEmpty ?? false) {
      for (var orderLine in previousOrder.orderLines ?? []) {
        if (orderLine.productId == (vmiBinEntity.productEntity?.id ?? '')) {
          return orderLine.qtyOrdered.toInt().toString();
        }
      }
    }
    return '';
  }

}

class ProductListItemWithTitleAndNumber extends StatelessWidget {
  final String? imageUrl, title, productNumber;

  const ProductListItemWithTitleAndNumber(
      {this.imageUrl, this.title, this.productNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl.makeImageUrl(),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
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
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: OptiTextStyles.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  LocalizationConstants.itemNumber
                      .format([productNumber ?? '']),
                  style: OptiTextStyles.bodySmall.copyWith(
                    color: OptiAppColors.textDisabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
