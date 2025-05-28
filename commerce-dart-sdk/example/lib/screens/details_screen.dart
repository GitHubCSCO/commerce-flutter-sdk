import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import '../service.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future<Result<GetProductResult, ErrorResponse>>? _getProductResponse;

  @override
  void initState() {
    super.initState();
    _getProductResponse = productService.getProduct(
      widget.id,
      parameters: ProductQueryParameters(
        expand: 'htmlcontent',
      ),
    );
  }

  Widget _getImage(String mediumImagePath) {
    String url = ImageUtils.createImageUrl(
        'https://${ClientConfig.hostUrl}', mediumImagePath);
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

  Widget _buildProductDetails(Product product) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getImage(product.mediumImagePath ?? ''),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productTitle ??
                          product.altText ??
                          product.shortDescription ??
                          'Unknown',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text('\$${product.basicListPrice}'),
                    const Divider(),
                    Text(
                      product.htmlContent ?? 'No description',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getProductResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final productResult =
              snapshot.data as Result<GetProductResult, ErrorResponse>;
          switch (productResult) {
            case Success(value: final value):
              {
                final product = value?.product;
                if (product == null) {
                  return const Center(child: Text('No product found'));
                }
                return _buildProductDetails(product);
              }
            case Failure(errorResponse: final errorResponse):
              {
                return Center(child: Text(errorResponse.error.toString()));
              }
          }
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
