import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartContentQuantityGroupWidget extends StatelessWidget {
  CartLineEntity cartLineEntity;

  CartContentQuantityGroupWidget(this.cartLineEntity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child:NumberTextField(
                initialtText: cartLineEntity.qtyOrdered?.toInt().toString(),
                shouldShowIncrementDecermentIcon: false,
                onChanged: (int? quantity) {
                  cartLineEntity =
                      cartLineEntity.copyWith(qtyOrdered: quantity);
                  context.read<CartContentBloc>().add(
                      CartContentQuantityChangedEvent(
                          cartLineEntity: cartLineEntity));
                }),
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
