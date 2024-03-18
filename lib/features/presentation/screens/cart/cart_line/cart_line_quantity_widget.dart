import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:flutter/material.dart';

class CartContentQuantityGroupWidget extends StatelessWidget {
  final CartLineEntity cartLineEntity;

  CartContentQuantityGroupWidget(this.cartLineEntity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NumberTextField(
                initialtText: "1",
                shouldShowIncrementDecermentIcon: false,
                onChanged: (int? quantity) {}),
          ),
          // CartContentTitleSubTitleColumn('U/M', 'E/A'),
          CartContentTitleSubTitleColumn(
              'Subtotal', cartLineEntity.updateSubtotalPriceValueText()),
        ],
      ),
    );
  }
}

class CartContentTitleSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;

  CartContentTitleSubTitleColumn(this.title, this.value);

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
