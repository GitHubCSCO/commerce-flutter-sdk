import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchProductsWidget extends StatelessWidget {

  final GetProductCollectionResult productCollectionResult;

  const SearchProductsWidget({super.key, required this.productCollectionResult});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              LocalizationConstants.resultsFor.formatDynamic([
                productCollectionResult.products?.length ?? 0,
                productCollectionResult.originalQuery
              ]),
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFF5F5F5),
              ),
              itemCount: productCollectionResult.products?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = productCollectionResult.products![index];
                return SearchProductWidget(product: product);
              },
            ),
          ),
        ],
      ),
    );
    // return Column(
    //   children: [
    //     // if(autocompleteResult.categories != null && autocompleteResult.categories!.isNotEmpty)
    //     //   Container(
    //     //     padding: const EdgeInsets.symmetric(horizontal: 16),
    //     //     decoration: const BoxDecoration(color: Colors.white),
    //     //     child: ListView.builder(
    //     //       itemCount: autocompleteResult.categories!.length,
    //     //       shrinkWrap: true,
    //     //       physics: const NeverScrollableScrollPhysics(),
    //     //       itemBuilder: (context, index) {
    //     //         final autoCompleteCategory = autocompleteResult.categories![index];
    //     //         return ActionListItemWidget(action: action);
    //     //       },
    //     //     ),
    //     //   ),
    //     // if(autocompleteResult.brands != null && autocompleteResult.brands!.isNotEmpty)
    //     //   Container(
    //     //     padding: const EdgeInsets.symmetric(horizontal: 16),
    //     //     decoration: const BoxDecoration(color: Colors.white),
    //     //     child: ListView.builder(
    //     //       itemCount: autocompleteResult.brands!.length,
    //     //       shrinkWrap: true,
    //     //       physics: const NeverScrollableScrollPhysics(),
    //     //       itemBuilder: (context, index) {
    //     //         final autoCompleteBrand = autocompleteResult.brands![index];
    //     //         return ActionListItemWidget(action: autoCompleteBrand);
    //     //       },
    //     //     ),
    //     //   ),
    //     if(autocompleteResult.products != null && autocompleteResult.products!.isNotEmpty)
    //       Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         decoration: const BoxDecoration(color: Colors.white),
    //         child: Expanded(
    //           child: ListView.builder(
    //             itemCount: autocompleteResult.products!.length,
    //             shrinkWrap: true,
    //             itemBuilder: (context, index) {
    //               final autoCompleteProduct = autocompleteResult.products![index];
    //               return AutoCompleteProductWidget(autocompleteProduct: autoCompleteProduct);
    //             },
    //           ),
    //         ),
    //       ),
    //   ],
    // );
  }

}

class SearchProductWidget extends StatelessWidget {

  final Product product;

  const SearchProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
              ),
              child: Image.network(
                product.smallImagePath ?? "",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.shortDescription ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  LocalizationConstants.itemNumber.formatDynamic([product.erpNumber ?? '']),
                  style: const TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.basicListPrice != null ? '\$${product.basicListPrice}' : '',
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(32),
            ),
            child: SvgPicture.asset(
              "assets/images/add_to_cart.svg",
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );

  }

}