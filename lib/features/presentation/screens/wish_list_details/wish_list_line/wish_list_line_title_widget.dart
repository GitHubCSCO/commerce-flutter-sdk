import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListContentProductTitleWidget extends StatelessWidget {
  final WishListLineEntity wishListLineEntity;

  const WishListContentProductTitleWidget({super.key, required this.wishListLineEntity});

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
                  wishListLineEntity.shortDescription ?? '',
                  style: OptiTextStyles.body,
                  textAlign: TextAlign.left,
                ),
                if (!wishListLineEntity.erpNumber.isNullOrEmpty)
                  Text(
                    wishListLineEntity.erpNumber ?? '',
                    style: OptiTextStyles.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                if (wishListLineEntity.manufacturerItem != null &&
                    wishListLineEntity.manufacturerItem!.isNotEmpty)
                  Row(children: [
                    Text(
                      wishListLineEntity.manufacturerItem ?? '',
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
