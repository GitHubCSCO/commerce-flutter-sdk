import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/seardh_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchProductsWidget extends StatelessWidget {
  final GetProductCollectionResult productCollectionResult;

  const SearchProductsWidget(
      {super.key, required this.productCollectionResult});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchProductsCubit, SearchProductsState>(
      listener: (context, state) {
        switch (state) {
          case SearchProductsAddToCartSuccess():
            context.read<CartCountCubit>().onCartItemChange();
            CustomSnackBar.showProductAddedToCart(context);
            break;
          case SearchProductsAddToCartFailure(
              errorResponse: final errorResponse
            ):
            break;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              LocalizationConstants.resultsFor.format([
                productCollectionResult.products?.isEmpty ?? true
                    ? LocalizationConstants.no
                    : productCollectionResult.products!.length,
                productCollectionResult.originalQuery
              ]),
              style: OptiTextStyles.header3,
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
                return SearchProductWidget(
                    product: ProductEntityMapper().toEntity(product));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchProductWidget extends StatelessWidget {
  final ProductEntity product;

  const SearchProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var productId = product.styleParentId ?? product.id;
        AppRoute.productDetails.navigateBackStack(context,
            pathParameters: {"productId": productId.toString()},
            extra: product);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.smallImagePath.makeImageUrl(),
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      // This function is called when the image fails to load
                      return Container(
                        color:
                            OptiAppColors.backgroundGray, // Placeholder color
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image, // Icon to display
                          color: Colors.grey, // Icon color
                          size: 30, // Icon size
                        ),
                      );
                    },
                  ),
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
                    style: OptiTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LocalizationConstants.itemNumber
                        .format([product.erpNumber ?? '']),
                    style: OptiTextStyles.bodySmall.copyWith(
                      color: OptiAppColors.textDisabledColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.basicListPrice != null
                        ? '\$${product.basicListPrice}'
                        : '',
                    style: OptiTextStyles.bodySmallHighlight,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                var productId = product.styleParentId ?? product.id;
                context
                    .read<SearchProductsCubit>()
                    .searchPorductAddToCard(productId!);
              },
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: SvgPicture.asset(
                  AssetConstants.addToCart,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
