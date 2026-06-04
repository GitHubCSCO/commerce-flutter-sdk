import 'package:commerce_flutter_sdk/src/core/utils/date_provider_utils.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

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
        color: context.colors.backgroundWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    orderEntity.orderNumberLabel ??
                        orderEntity.orderNumber ??
                        '',
                    style: context.text.body
                        .copyWith(color: context.scheme.primary),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  orderEntity.orderDate != null
                      ? formatDateByLocale(
                          orderEntity.orderDate!,
                        )
                      : '',
                  style: context.text.body,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Visibility(
              visible: orderEntity.showPoNumber ?? false,
              child: Text(
                (orderEntity.poNumberLabel ?? 'PO #') +
                    (orderEntity.customerPO ?? ''),
                style: context.text.bodySmall,
              ),
            ),
            ...(orderEntity.stCompanyName != null
                ? [
                    const SizedBox(height: 4),
                    Text(
                      orderEntity.stCompanyName ?? '',
                      style: context.text.bodySmall,
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
                    style: context.text.bodySmallHighlight,
                  ),
                ),
                Text(
                  orderEntity.statusDisplay ?? '',
                  style: context.text.bodySmallHighlight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
