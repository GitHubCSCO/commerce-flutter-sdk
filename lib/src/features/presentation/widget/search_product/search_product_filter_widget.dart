import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/product_list_filter_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/filter.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/multiple_selection_option_chip.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_list_filter/product_list_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchProductFilterWidget extends StatelessWidget {
  final ProductListType productListType;
  final int badgeCount;
  final List<String>? selectedAttributeValueIds;
  final List<String>? selectedBrandIds;
  final List<String>? selectedProductLineIds;
  final String? selectedCategoryId;
  final bool? previouslyPurchased;
  final bool? selectedStockedItems;
  final String? searchText;
  final void Function({
    required List<String> selectedAttributeValueIds,
    required List<String> selectedBrandIds,
    required List<String> selectedProductLineIds,
    required String selectedCategoryId,
    required bool previouslyPurchased,
    required bool selectedStockedItems,
  }) onApply;
  final void Function()? onReset;

  const SearchProductFilterWidget(
    BuildContext context, {
    super.key,
    required this.productListType,
    required this.badgeCount,
    this.selectedAttributeValueIds,
    this.selectedBrandIds,
    this.selectedProductLineIds,
    this.selectedCategoryId,
    this.previouslyPurchased,
    this.selectedStockedItems,
    this.searchText,
    required this.onApply,
    this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductListFilterCubit>(),
      child: Builder(builder: (context) {
        return badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 0),
          badgeStyle: const badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: Colors.black,
            padding: EdgeInsets.all(6),
            elevation: 0,
          ),
          showBadge: badgeCount > 0,
          badgeContent: Text(
            badgeCount.toString(),
            style: OptiTextStyles.badgesStyle,
          ),
          child: IconButton(
            padding: const EdgeInsets.all(10),
            onPressed: () {
              context.read<ProductListFilterCubit>().initialize(
                    productListType: productListType,
                    productsParameters: ProductsQueryParameters(
                      page: 1,
                      pageSize: 16,
                      expand: ["pricing", "facets", "brand"],
                      attributeValueIds: selectedAttributeValueIds,
                      brandIds: selectedBrandIds,
                      productLineIds: selectedProductLineIds,
                      categoryId: selectedCategoryId,
                      previouslyPurchasedProducts: previouslyPurchased,
                      stockedItemsOnly: selectedStockedItems,
                      query: searchText,
                    ),
                  );
              _showProductFilterWidget(
                context,
                onApply: () {
                  final currentState =
                      context.read<ProductListFilterCubit>().state;
                  onApply(
                    selectedAttributeValueIds:
                        currentState.productsParameters.attributeValueIds ?? [],
                    selectedBrandIds:
                        currentState.productsParameters.brandIds ?? [],
                    selectedProductLineIds:
                        currentState.productsParameters.productLineIds ?? [],
                    selectedCategoryId:
                        currentState.productsParameters.categoryId ?? '',
                    previouslyPurchased: currentState
                            .productsParameters.previouslyPurchasedProducts ??
                        false,
                    selectedStockedItems:
                        currentState.productsParameters.stockedItemsOnly ??
                            false,
                  );
                },
                onReset: () {
                  context.read<ProductListFilterCubit>().initialize(
                        productsParameters:
                            _getProductsQueryParameters(productListType),
                        productListType: productListType,
                      );
                  onReset?.call();
                },
                onFilterSelected: (v) {
                  context.read<ProductListFilterCubit>().selectFilter(
                        productListType: productListType,
                        filterValue: v,
                      );
                },
              );
            },
            icon: SvgAssetImage(
              height: 20,
              width: 20,
              assetName: AssetConstants.filterIcon,
              semanticsLabel: 'filter icon',
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      }),
    );
  }

  ProductsQueryParameters _getProductsQueryParameters(
      ProductListType productListType) {
    String? selectedCategoryId;
    List<String>? selectedBrandIds;
    List<String>? selectedProductLineIds;

    switch (productListType) {
      case ProductListType.categoryProducts:
        selectedCategoryId = this.selectedCategoryId;
        break;
      case ProductListType.shopBrandCategoryProducts:
        selectedCategoryId = this.selectedCategoryId;
        selectedBrandIds = this.selectedBrandIds;
        break;
      case ProductListType.shopBrandProducts:
        selectedBrandIds = this.selectedBrandIds;
      case ProductListType.shopBrandProductLineProducts:
        selectedBrandIds = this.selectedBrandIds;
        selectedProductLineIds = this.selectedProductLineIds;
        break;
      default:
    }

    return ProductsQueryParameters(
      page: 1,
      pageSize: 16,
      expand: ["pricing", "facets", "brand"],
      attributeValueIds: const [],
      brandIds: selectedBrandIds,
      productLineIds: selectedProductLineIds,
      categoryId: selectedCategoryId,
      previouslyPurchasedProducts: false,
      stockedItemsOnly: false,
      query: searchText,
    );
  }
}

void _showProductFilterWidget(
  BuildContext context, {
  required void Function(FilterValueViewModel v)? onFilterSelected,
  required void Function() onReset,
  required void Function() onApply,
}) {
  /// This is how you can initialize the filter cubit
  /// and load the filters for the first time
  /// Might need in the future when we implement more search filters
  // context.read<ProductListFilterCubit>().initialize(
  //       productListType: productListType,
  //       productsParameters: ProductsQueryParameters(
  //         replaceProducts: false,
  //         getAllAttributeFacets: false,
  //         includeAlternateInventory: true,
  //         previouslyPurchasedProducts: false,
  //         stockedItemsOnly: false,
  //         page: 1,
  //         pageSize: 16,
  //         makeBrandUrls: false,
  //         expand: ["pricing", "facets", "brand"],
  //         includeSuggestions: "True",
  // applyPersonalization: true,
  // query: 'vmi',
  //   ),
  // );
  showFilterModalSheet(
    context,
    onApply: onApply,
    onReset: onReset,
    child: BlocProvider.value(
      value: BlocProvider.of<ProductListFilterCubit>(context),
      child: BlocBuilder<ProductListFilterCubit, ProductListFilterState>(
        builder: (context, state) {
          if (state.status == ProductListFilterStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == ProductListFilterStatus.failure) {
            return const Center(
              child: Text('Failed to load filters'),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.filterValues
                  .map(
                    (e) => MultipleSelectionOptionChip<FilterValueViewModel>(
                      values: e.values,
                      chipTitle: e.title,
                      selectedValues: e.values
                          .where((element) => element.isSelected ?? false)
                          .toSet(),
                      onSelectionChanged: (FilterValueViewModel? v) {
                        if (v == null) {
                          return;
                        }

                        final changedValue = v.copyWith(
                          isSelected: !(v.isSelected ?? false),
                        );

                        if (onFilterSelected != null) {
                          onFilterSelected(changedValue);
                        }
                      },
                    ),
                  )
                  .toList(),
            );
          }
        },
      ),
    ),
  );
}
