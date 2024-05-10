import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/wish_list_line_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_details/wish_list_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WishListContentQuantityGroupWidget extends StatelessWidget {
  final WishListLineEntity wishListLineEntity;
  final bool realTimeLoading;
  final bool canEditQuantity;

  const WishListContentQuantityGroupWidget({
    super.key,
    this.realTimeLoading = false,
    this.canEditQuantity = true,
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
                onChanged: (int? quantity) async {
                  if (canEditQuantity == false) {
                    return;
                  }

                  final newWishListLineEntity =
                      wishListLineEntity.copyWith(qtyOrdered: quantity);
                  await context
                      .read<WishListDetailsCubit>()
                      .updateWishListLineQuantity(
                          newWishListLineEntity,
                          quantity ??
                              (wishListLineEntity.qtyOrdered as int?) ??
                              1);
                }),
          ),
          // WishListContentTitleSubTitleColumn('U/M', 'E/A'),
          WishListContentTitleSubTitleColumn(
            'Subtotal',
            wishListLineEntity.updateSubtotalPriceValueText,
            realTimeLoading: realTimeLoading,
          ),
        ],
      ),
    );
  }
}

class WishListContentTitleSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;
  final bool realTimeLoading;

  const WishListContentTitleSubTitleColumn(
    this.title,
    this.value, {
    super.key,
    this.realTimeLoading = false,
  });

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
          realTimeLoading
              ? Container(
                  alignment: Alignment.center,
                  child: LoadingAnimationWidget.prograssiveDots(
                    color: OptiAppColors.iconPrimary,
                    size: 30,
                  ),
                )
              : Text(
                  value,
                  style: OptiTextStyles.titleLarge,
                )
        ],
      ),
    );
  }
}
