import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LineItemQuantityGroupWidget extends StatelessWidget {
  final String? qtyOrdered;
  final void Function(int?)? onQtyChanged;
  final String? subtotalPriceText;
  final bool canEdit;
  final bool realTimeLoading;
  final bool? hidePricingEnable;

  const LineItemQuantityGroupWidget({
    super.key,
    this.qtyOrdered,
    this.onQtyChanged,
    this.subtotalPriceText,
    this.canEdit = true,
    this.realTimeLoading = false,
    this.hidePricingEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: canEdit
                ? NumberTextField(
                    max: CoreConstants.maximumOrderQuantity,
                    initialtText: qtyOrdered,
                    shouldShowIncrementDecermentIcon: false,
                    onChanged: onQtyChanged,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocalizationConstants.qTY.localized(),
                        style: OptiTextStyles.bodySmall,
                      ),
                      Text(
                        qtyOrdered ?? '',
                        style: OptiTextStyles.titleLarge,
                      ),
                    ],
                  ),
          ),
          // LineItemSubtotalColumnWidget(title: 'U/M', value: 'E/A'),
          if (!(hidePricingEnable ?? false)) ...{
            LineItemSubtotalColumnWidget(
              title: LocalizationConstants.subtotal.localized(),
              value: subtotalPriceText ?? '',
              realTimeLoading: realTimeLoading,
            ),
          }
          else ...{
            const Expanded(
              flex: 2, child: Center(),
            ),
          }
        ],
      ),
    );
  }
}

class LineItemSubtotalColumnWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool realTimeLoading;

  const LineItemSubtotalColumnWidget({
    required this.title,
    required this.value,
    this.realTimeLoading = false,
    super.key,
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
                  style: OptiTextStyles.titleLargeHighLight,
                )
        ],
      ),
    );
  }
}
