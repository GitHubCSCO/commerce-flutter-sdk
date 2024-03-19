import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:flutter/material.dart';

class CartContentProductTitleWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  const CartContentProductTitleWidget({Key? key, required this.cartLineEntity})
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
                  cartLineEntity.shortDescription ?? '',
                  style: OptiTextStyles.body,
                  textAlign: TextAlign.left,
                ),
                if (cartLineEntity.getProductNumber() != '')
                  Text(
                    cartLineEntity.getProductNumber(),
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                if (cartLineEntity.manufacturerItem != null &&
                    cartLineEntity.manufacturerItem!.isNotEmpty)
                  Row(children: [
                    Text(
                      cartLineEntity.manufacturerItem ?? '',
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
