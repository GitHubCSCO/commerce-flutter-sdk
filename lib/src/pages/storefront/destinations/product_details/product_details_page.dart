import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  Widget _getImage() {
    String url = ImageUtils.createImageUrl(
        ClientConfig.hostUrl!, product.mediumImagePath!);
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getImage(),
            const Divider(),
            Text(product.shortDescription ?? ""),
            const Divider(),
            Text(product.shortDescription ?? ""),
          ],
        ),
      ),
    );
  }
}
