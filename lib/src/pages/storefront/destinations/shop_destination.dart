import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

class ShopDestination extends StatefulWidget {
  const ShopDestination({super.key});

  @override
  State<ShopDestination> createState() => _ShopDestinationState();
}

class _ShopDestinationState extends State<ShopDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: FutureBuilder(
          future: getProducts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var productsList = snapshot.data as List<Product>;
              if (productsList.isEmpty) {
                return Column(
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
                    const Text('No shopping items!'),
                  ],
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(),
                  ),
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: SizedBox(
                          width: double.infinity,
                          child: Text(
                              productsList[index].shortDescription as String)),
                    );
                  },
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
