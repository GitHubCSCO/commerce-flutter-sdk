import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_header_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_widget.dart';
import 'package:flutter/material.dart';

class CartAllListScreenArguments {
  final String orderNumber;
  final bool? showClearCart;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final List<CartLineEntity> cartLineEntities;

  CartAllListScreenArguments({
    required this.orderNumber,
    this.showClearCart,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    required this.cartLineEntities,
  });

  factory CartAllListScreenArguments.fromJson(Map<String, dynamic> json) {
    return CartAllListScreenArguments(
      orderNumber: json['orderNumber'],
      showClearCart: json['showClearCart'],
      hidePricingEnable: json['hidePricingEnable'],
      hideInventoryEnable: json['hideInventoryEnable'],
      cartLineEntities: json['cartLineEntities'],
    );
  }
}

class CartAllListScreen extends StatelessWidget {
  final String orderNumber;
  final bool? showClearCart;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final List<CartLineEntity> cartLineEntities;

  const CartAllListScreen({
    super.key,
    required this.orderNumber,
    this.showClearCart,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    required this.cartLineEntities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Cart Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartLineEntities.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return CartContentHeaderWidget(
                      orderNumber: orderNumber,
                      showClearCart: showClearCart,
                      cartCount: cartLineEntities.length,
                    );
                  }

                  final cartLineEntity = cartLineEntities[index - 1];
                  return CartLineWidget(
                    cartLineEntity: cartLineEntity,
                    showRemoveButton:
                        !(cartLineEntity.isPromotionItem ?? false),
                    onCartQuantityChangedCallback: (quantity) {
                      /// TODO: Implement this
                    },
                    onCartLineRemovedCallback: (cartLineEntity) {
                      /// TODO: Implement this
                    },
                    hidePricingEnable: hidePricingEnable,
                    hideInventoryEnable: hideInventoryEnable,
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () {
                  // TODO: Implement update cart functionality
                },
                text: 'Update Cart',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
