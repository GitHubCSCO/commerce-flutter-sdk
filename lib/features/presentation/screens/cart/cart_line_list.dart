import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartLineWidgetList extends StatelessWidget {
  final List<CartLineEntity> cartLineEntities;

  CartLineWidgetList({required this.cartLineEntities});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartContentBloc, CartContentState>(
        buildWhen: (previous, current) {
      return current is CartContentDefaultState;
    }, listener: (context, state) {
      if (state is CartContentClearAllSuccessState ||
          state is CartContentItemRemovedSuccessState ||
          state is CartContentQuantityChangedSuccessState) {
        context.read<CartCountCubit>().loadCurrentCartCount();
        context.read<CartPageBloc>().add(CartPageLoadEvent());
      }
    }, builder: (context, state) {
      switch (state) {
        case CartContentDefaultState():
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartContentHeaderWidget(cartCount: cartLineEntities.length),
              Column(
                children: cartLineEntities
                    .map((cartLineEntity) =>
                        CartLineWidget(cartLineEntity: cartLineEntity))
                    .toList(),
              ),
            ],
          );
        default:
          return Container();
      }
    });
  }
}
