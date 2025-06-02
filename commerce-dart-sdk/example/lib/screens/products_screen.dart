import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future<Result<GetProductCollectionResult, ErrorResponse>>?
      _getProductsCollectionResult;

  @override
  void initState() {
    super.initState();
    _getProductsCollectionResult =
        productService.getProducts(ProductsQueryParameters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () async {
              authenticationService.logoutAsync().then((value) {
                if (context.mounted) context.go('/');
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _getProductsCollectionResult =
                productService.getProducts(ProductsQueryParameters());
          });
        },
        child: const Icon(
          Icons.refresh,
        ),
      ),
      body: FutureBuilder(
        future: _getProductsCollectionResult,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final productsResult = snapshot.data
                as Result<GetProductCollectionResult, ErrorResponse>;

            switch (productsResult) {
              case Success(value: final value):
                {
                  final products = value?.products;
                  if (products == null) {
                    return const Center(child: Text('No products found'));
                  }

                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      final product = products[index];
                      return _ProductCard(product: product);
                    },
                  );
                }
              case Failure(errorResponse: final errorResponse):
                {
                  return Center(child: Text(errorResponse.error.toString()));
                }
            }
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
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
                  child: Image.network(
                    ImageUtils.createImageUrl(
                      'https://${ClientConfig.hostUrl!}',
                      product.mediumImagePath!,
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    product.productTitle ??
                        product.altText ??
                        product.shortDescription ??
                        'Unknown',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text('\$${product.basicListPrice}'),
                ),
              ],
            ),
          ),
          onTap: () {
            context.go('/products/${product.id}');
          },
        ));
  }
}
