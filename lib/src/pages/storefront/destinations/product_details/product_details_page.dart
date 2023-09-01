import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_flutter_app/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({super.key, required this.id});

  final String id;

  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  Future<ServiceResponse<Product>>? _getProductResponse;

  @override
  void initState() {
    super.initState();
    _getProductResponse = ref.read(productInterfaceProvider).getProductV2(
        '${widget.id}?expand=detail%2Cspecifications%2Ccontent%2Cimages');
  }

  Widget _getImage(String mediumImagePath) {
    String url =
        ImageUtils.createImageUrl(ClientConfig.hostUrl!, mediumImagePath);
    Widget returnVal;
    try {
      returnVal = Image.network(url);
    } catch (e) {
      returnVal = SizedBox(
        width: double.infinity,
        height: 300,
        child: Text('No image found at: $url'),
      );
      // print(e);
    }
    return returnVal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getProductResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var product = snapshot.data?.model as Product;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text('Add to Cart'),
              icon: const Icon(Icons.add_shopping_cart_outlined),
              tooltip: 'Add to Cart',
            ),
            appBar: AppBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _getImage(product.mediumImagePath!),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productTitle ?? "No Title",
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(product.unitListPriceDisplay ?? "\$0.00"),
                          const Divider(),
                          Text(product.content!.htmlContent!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
