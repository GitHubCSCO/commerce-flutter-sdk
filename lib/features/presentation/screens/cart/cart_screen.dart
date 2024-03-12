import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartPageBloc>(
      create: (context) => sl<CartPageBloc>()..add(const CartPageLoadEvent()),
      child: CartPage(),
    );
  }
}

class CartPage extends BaseDynamicContentScreen {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        actions: [BottomMenuWidget()],
      ),
      body: BlocBuilder<CartPageBloc, CartPageState>(builder: (context, state) {
        if (state is CartPageLoadedState) {
          return Text(state.pageWidgets.length.toString());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}

class EmptyCartPage extends StatelessWidget {
  const EmptyCartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              "assets/images/cart.svg",
              fit: BoxFit.fitWidth,
            ),
          ),
          const Text('There are no items in your cart'),
          Padding(
            padding: const EdgeInsets.all(24),
            child: TertiaryButton(
              onPressed: () {
                CustomSnackBar.showComingSoonSnackBar(context);
              },
              child: Text('Continue Shopping'),
            ),
          )
        ],
      ),
    );
  }
}
