import 'package:commerce_flutter_app/src/pages/storefront/destinations/product_details/product_details_page.dart';
import 'package:commerce_flutter_app/src/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShopDestination extends ConsumerStatefulWidget {
  const ShopDestination({super.key});

  @override
  ShopDestinationState createState() => ShopDestinationState();
}

class ShopDestinationState extends ConsumerState<ShopDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: FutureBuilder(
          future: ref.read(productInterfaceProvider).getProductListV2(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var productsList = snapshot.data?.model as List<Product>;
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
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(productsList[index].productTitle ??
                                index.toString())),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsPage(id: productsList[index].id!))),
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
