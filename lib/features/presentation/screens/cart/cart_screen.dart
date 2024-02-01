import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [BottomMenuWidget()],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your button's onPressed logic here
          },
          child: const Text('cart'),
        ),
      ),
    );
  }
}
