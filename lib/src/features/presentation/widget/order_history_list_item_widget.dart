import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/core/utils/date_provider_utils.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:flutter/material.dart';

class OrderHistoryListItem extends StatelessWidget {
  final OrderEntity orderEntity;
  final bool? hidePricingEnable;
  final void Function()? onTap;

  const OrderHistoryListItem({
    super.key,
    required this.orderEntity,
    this.onTap,
    this.hidePricingEnable,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        color: OptiAppColors.backgroundWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderEntity.orderNumberLabel ?? orderEntity.orderNumber ?? '',
                  style: OptiTextStyles.body
                      .copyWith(color: OptiAppColors.primaryColor),
                ),
                Text(
                  orderEntity.orderDate != null
                      ? formatDateByLocale(
                          orderEntity.orderDate!,
                        )
                      : '',
                  style: OptiTextStyles.body,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Visibility(
              visible: orderEntity.showPoNumber ?? false,
              child: Text(
                (orderEntity.poNumberLabel ?? 'PO #') +
                    (orderEntity.customerPO ?? ''),
                style: OptiTextStyles.bodySmall,
              ),
            ),
            ...(orderEntity.stCompanyName != null
                ? [
                    const SizedBox(height: 4),
                    Text(
                      orderEntity.stCompanyName ?? '',
                      style: OptiTextStyles.bodySmall,
                    ),
                  ]
                : []),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: !(hidePricingEnable ?? false),
                  child: Text(
                    orderEntity.orderGrandTotalDisplay ?? '',
                    style: OptiTextStyles.bodySmallHighlight,
                  ),
                ),
                Text(
                  orderEntity.statusDisplay ?? '',
                  style: OptiTextStyles.bodySmallHighlight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
