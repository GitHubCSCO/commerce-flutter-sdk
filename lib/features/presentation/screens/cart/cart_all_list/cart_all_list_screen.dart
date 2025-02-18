import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_header_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartAllListScreenArguments {
  final String orderNumber;
  final bool? showClearCart;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final Cart cart;

  CartAllListScreenArguments({
    required this.orderNumber,
    this.showClearCart,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    required this.cart,
  });

  factory CartAllListScreenArguments.fromJson(Map<String, dynamic> json) {
    return CartAllListScreenArguments(
      orderNumber: json['orderNumber'] ?? '',
      showClearCart: json['showClearCart'],
      hidePricingEnable: json['hidePricingEnable'],
      hideInventoryEnable: json['hideInventoryEnable'],
      cart: json['cart'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'showClearCart': showClearCart,
      'hidePricingEnable': hidePricingEnable,
      'hideInventoryEnable': hideInventoryEnable,
      'cart': cart,
    };
  }
}

class CartAllListScreen extends StatelessWidget {
  final String orderNumber;
  final bool? showClearCart;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final Cart cart;

  const CartAllListScreen({
    super.key,
    required this.orderNumber,
    this.showClearCart,
    this.hidePricingEnable,
    this.hideInventoryEnable,
    required this.cart,
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
                itemCount: cart.cartLines?.length ?? 0 + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return CartContentHeaderWidget(
                      orderNumber: orderNumber,
                      showClearCart: showClearCart,
                      cartCount: cart.cartLines?.length ?? 0,
                    );
                  }

                  final cartLineEntity = CartLineEntityMapper.toEntity(
                    cart.cartLines?[index - 1] ?? CartLine(),
                  );

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
