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
  Future<ServiceResponse<List<Product>>>? _getProductsResponse;

  @override
  void initState() {
    super.initState();
    _getProductsResponse = ref.read(productInterfaceProvider).getProductsV2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: FutureBuilder(
          future: _getProductsResponse,
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
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    return _ProductCard(product: productsList[index]);
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

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 300,
        margin: const EdgeInsets.all(10),
        child: GestureDetector(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 200,
                  width: double.infinity,
                  child: Image.network(ImageUtils.createImageUrl(
                      ClientConfig.hostUrl!, product.mediumImagePath!)),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    product.productTitle!,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(product.unitListPriceDisplay!),
                ),
              ],
            ),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsPage(id: product.id!))),
        ));
  }
}
