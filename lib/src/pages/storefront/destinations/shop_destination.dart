import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopDestination extends StatelessWidget {
  const ShopDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 250,
                  width: 250,
                  child: SvgPicture.asset(
                      'assets/images/undraw_shopping_bags_mxgo.svg')),
              const SizedBox(
                height: 20,
              ),
              const Text('No shopping items yet!'),
            ]),
      ),
    );
  }
}
