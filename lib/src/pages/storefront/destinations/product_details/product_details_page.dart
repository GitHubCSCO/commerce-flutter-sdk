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
      future: ref.read(productInterfaceProvider).getProductV2(
          '${widget.id}?expand=detail%2Cspecifications%2Ccontent%2Cimages'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var product = snapshot.data?.model as Product;
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
                child: Column(
              children: [
                _getImage(product.mediumImagePath!),
                Text(product.productTitle ?? "No Title"),
                const Divider(),
                Text(product.content!.htmlContent!),
              ],
            )),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
