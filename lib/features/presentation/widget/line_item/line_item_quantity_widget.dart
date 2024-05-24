import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:flutter/material.dart';

class LineItemQuantityGroupWidget extends StatelessWidget {
  final String? qtyOrdered;
  final void Function(int?)? onQtyChanged;
  final String? subtotalPriceText;
  final bool canEdit;

  const LineItemQuantityGroupWidget({
    super.key,
    this.qtyOrdered,
    this.onQtyChanged,
    this.subtotalPriceText,
    this.canEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: canEdit
                ? NumberTextField(
                    initialtText: qtyOrdered,
                    shouldShowIncrementDecermentIcon: false,
                    onChanged: onQtyChanged,
                  )
                : Text(
                    qtyOrdered ?? '',
                    style: OptiTextStyles.titleLarge,
                  ),
          ),
          // LineItemSubtotalColumnWidget(title: 'U/M', value: 'E/A'),
          LineItemSubtotalColumnWidget(
            title: 'Subtotal',
            value: subtotalPriceText ?? '',
          ),
        ],
      ),
    );
  }
}

class LineItemSubtotalColumnWidget extends StatelessWidget {
  final String title;
  final String value;

  const LineItemSubtotalColumnWidget({
    required this.title,
    required this.value,
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
          Text(
            value,
            style: OptiTextStyles.titleLarge,
          )
        ],
      ),
    );
  }
}
