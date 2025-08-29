import 'package:commerce_flutter_sdk/src/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_content/cart_content_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_line/cart_line_header_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_line/cart_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartLineWidgetList extends StatelessWidget {
  final String? orderNumber;
  final bool? showClearCart;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final int? cartItemsCount;
  final List<CartLineEntity> cartLineEntities;
  final void Function(BuildContext) onCartChangeCallBack;

  const CartLineWidgetList({
    super.key,
    required this.orderNumber,
    required this.cartLineEntities,
    required this.onCartChangeCallBack,
    this.cartItemsCount,
    this.showClearCart,
    this.hidePricingEnable,
    this.hideInventoryEnable,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartContentBloc, CartContentState>(
        buildWhen: (previous, current) {
      return current is CartContentDefaultState;
    }, listener: (context, state) {
      if (state is CartContentClearAllSuccessState ||
          state is CartContentItemRemovedSuccessState) {
        onCartChangeCallBack.call(context);
      } else if (state is CartContentQuantityChangedSuccessState) {
        if (state.message != null) {
          CustomSnackBar.showSnackBarMessage(
            context,
            state.message ?? '',
          );
        }
        onCartChangeCallBack.call(context);
      }
    }, builder: (context, state) {
      switch (state) {
        case CartContentDefaultState():
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartContentHeaderWidget(
                orderNumber: orderNumber,
                showClearCart: showClearCart,
                cartCount: cartItemsCount ?? cartLineEntities.length,
              ),
              Column(
                children: cartLineEntities
                    .map((cartLineEntity) => CartLineWidget(
                          cartLineEntity: cartLineEntity,
                          showRemoveButton: context
                              .read<CartContentBloc>()
                              .showRemoveButtonForPromotionItem(cartLineEntity),
                          onCartQuantityChangedCallback: (quantity) {
                            context.read<CartContentBloc>().add(
                                  CartContentQuantityChangedEvent(
                                    orderNumber: orderNumber,
                                    cartLineEntity: cartLineEntity.copyWith(
                                        qtyOrdered: quantity),
                                  ),
                                );
                          },
                          onCartLineRemovedCallback: (cartLineEntity) {
                            context.read<CartContentBloc>().add(
                                CartContentRemoveEvent(
                                    orderNumber: orderNumber,
                                    cartLine: CartLineEntityMapper.toModel(
                                        cartLineEntity)));
                          },
                          hidePricingEnable: hidePricingEnable,
                          hideInventoryEnable: hideInventoryEnable,
                        ))
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
