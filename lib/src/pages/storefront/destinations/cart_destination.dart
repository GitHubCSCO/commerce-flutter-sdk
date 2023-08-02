import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartDestination extends StatelessWidget {
  const CartDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 250,
                  width: 250,
                  child: SvgPicture.asset(
                      'assets/images/undraw_empty_cart_co35.svg')),
              const SizedBox(
                height: 20,
              ),
              const Text('There are no items in your cart'),
            ]),
      ),
    );
  }
}
