import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _OrderHistoryListItem extends StatelessWidget {
  const _OrderHistoryListItem({required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderEntity.orderNumberLabel ?? '',
                style: OptiTextStyles.body,
              ),
              Text(
                orderEntity.orderDate != null
                    ? DateFormat(CoreConstants.dateFormatShortString)
                        .format(orderEntity.orderDate!)
                    : '',
                style: OptiTextStyles.body,
              ),
            ],
          ),
          ...(orderEntity.webOrderNumber != null
              ? [
                  const SizedBox(height: 4),
                  Text(
                    (orderEntity.webOrderNumberLabel ?? '') +
                        (orderEntity.webOrderNumber ?? ''),
                    style: OptiTextStyles.bodySmall,
                  ),
                ]
              : []),
          ...(orderEntity.customerPO != null
              ? [
                  const SizedBox(height: 4),
                  Text(
                    (orderEntity.poNumberLabel ?? '') +
                        (orderEntity.customerPO ?? ''),
                    style: OptiTextStyles.bodySmall,
                  ),
                ]
              : []),
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
              Text(orderEntity.orderGrandTotalDisplay ?? ''),
              Text(
                orderEntity.statusDisplay ?? '',
                style: OptiTextStyles.bodySmallHighlight,
              ),
              Text(
                orderEntity.statusDisplay ?? '',
                style: OptiTextStyles.bodySmallHighlight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
