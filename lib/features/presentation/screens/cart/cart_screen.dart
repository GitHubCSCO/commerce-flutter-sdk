import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_payment_summary_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartPageBloc>(
        create: (context) => sl<CartPageBloc>()..add(CartPageLoadEvent()),
        child: const CartPage());
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        title: const Text(LocalizationConstants.cart),
        backgroundColor: Colors.white,
        actions: [BottomMenuWidget()],
      ),
      body: BlocBuilder<CartPageBloc, CartPageState>(
        builder: (context, state) {
          switch (state) {
            case CartPageInitialState():
            case CartPageLoadingState():
              return const Center(child: CircularProgressIndicator());
            case CartPageLoadedState():
              return ListView(
                padding: EdgeInsets.zero,
                children: _buildCartWidgets(state.cart, state.warehouse),
              );
            default:
              return const CustomScrollView(
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: Center(
                      child: Text(LocalizationConstants.errorLoadingCart),
                    ),
                  ),
                ],
              );
          }
        },
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         width: 50,
      //         height: 50,
      //         padding: const EdgeInsets.all(10),
      //         child: SvgPicture.asset(
      //           "assets/images/cart.svg",
      //           fit: BoxFit.fitWidth,
      //         ),
      //       ),
      //       const Text('There are no items in your cart'),
      //       Padding(
      //         padding: const EdgeInsets.all(24),
      //         child: TertiaryButton(
      //           onPressed: () {
      //             CustomSnackBar.showComingSoonSnackBar(context);
      //           },
      //           child: Text('Continue Shopping'),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  List<Widget> _buildCartWidgets(Cart? cart, Warehouse? warehouse) {
    List<Widget> list = [];

    final paymentSummaryEntity = PaymentSummaryEntity();
    final shippingEntity = ShippingEntity(warehouse: warehouse);

    list.add(
        CartPaymentSummaryWidget(paymentSummaryEntity: paymentSummaryEntity));

    list.add(BlocProvider<CartShippingSelectionBloc>(
      create: (context) => sl<CartShippingSelectionBloc>(),
      child: CartShippingWidget(shippingEntity: shippingEntity),
    ));
    
    list.add(CartLineWidgetList(
        cartLineEntities: CartLineListMapper()
            .toEntity(CartLineList(cartLines: cart!.cartLines))));

    return list;
  }
}
