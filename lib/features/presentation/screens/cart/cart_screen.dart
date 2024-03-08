import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        actions: [BottomMenuWidget()],
      ),
      body: Center(
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
      ),
    );
  }
}
