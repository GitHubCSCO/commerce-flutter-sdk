import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/wish_list_line_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:flutter/material.dart';

class WishListContentQuantityGroupWidget extends StatelessWidget {
  final WishListLineEntity wishListLineEntity;

  const WishListContentQuantityGroupWidget({
    super.key,
    required this.wishListLineEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NumberTextField(
                initialtText: wishListLineEntity.qtyOrdered?.toInt().toString(),
                shouldShowIncrementDecermentIcon: false,
                onChanged: (int? quantity) {
                  // wishListLineEntity =
                  //     wishListLineEntity.copyWith(qtyOrdered: quantity);
                  // context.read<WishListContentBloc>().add(
                  //     WishListContentQuantityChangedEvent(
                  //         WishListLineEntity: wishListLineEntity));

                  CustomSnackBar.showComingSoonSnackBar(context);
                }),
          ),
          // WishListContentTitleSubTitleColumn('U/M', 'E/A'),
          WishListContentTitleSubTitleColumn(
              'Subtotal', wishListLineEntity.updateSubtotalPriceValueText),
        ],
      ),
    );
  }
}

class WishListContentTitleSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;

  const WishListContentTitleSubTitleColumn(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            title,
            style: OptiTextStyles.bodySmall,
          ),
          Text(
            value,
            style: OptiTextStyles.titleLarge,
          )
        ],
      ),
    );
  }
}
