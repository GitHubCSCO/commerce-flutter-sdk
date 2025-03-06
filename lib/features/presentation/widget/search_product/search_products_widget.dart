import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/domain/enums/state_status.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_product/search_product_filter_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_product/search_product_grid_item_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_product/search_product_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchProductsWidget extends StatefulWidget {
  final Function(int) onPageChanged; // Callback to handle page changes
  final ProductListType productListType;
  final bool? isGridView;

  const SearchProductsWidget({
    super.key,
    required this.onPageChanged,
    required this.productListType,
    this.isGridView,
  });

  @override
  State<SearchProductsWidget> createState() => _SearchProductsWidgetState();
}

class _SearchProductsWidgetState extends State<SearchProductsWidget> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<SearchProductsCubit>().loadMoreSearchProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchProductsCubit, SearchProductsState>(
      builder: (context, state) {
        return BlocListener<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            switch (state) {
              case AddToCartSuccess():
                context.read<CartCountCubit>().onCartItemChange();
                CustomSnackBar.showProductAddedToCart(
                    context, state.addToCartMsg);
                break;
              case AddToCartFailure():
                break;
              case AddToCartInvalidPrice(errorResponse: final message):
                CustomSnackBar.showSnackBarMessage(
                  context,
                  message,
                  seconds: 4,
                );
            }
          },
          child: state.searchProductStatus == StateStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: state.originalQuery != null &&
                                state.originalQuery!.isNotEmpty,
                            child: Expanded(
                              child: Text(
                                state.originalQuery == null
                                    ? LocalizationConstants.results
                                        .localized()
                                        .format(
                                        [
                                          (state.paginationEntity?.totalItemCount ==
                                                  0)
                                              ? LocalizationConstants.no
                                                  .localized()
                                              : state.paginationEntity
                                                  ?.totalItemCount
                                        ],
                                      )
                                    : LocalizationConstants.resultsFor
                                        .localized()
                                        .format(
                                        [
                                          (state.paginationEntity?.totalItemCount ==
                                                  0)
                                              ? LocalizationConstants.no
                                                  .localized()
                                              : state.paginationEntity
                                                  ?.totalItemCount,
                                          state.originalQuery
                                        ],
                                      ),
                                style: OptiTextStyles.header3,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SortToolMenu(
                                availableSortOrders: state.availableSortOrders,
                                onSortOrderChanged: (sortOrder) async {
                                  await context
                                      .read<SearchProductsCubit>()
                                      .sortOrderChanged(sortOrder);
                                },
                                onSortOrderCancel: () {
                                  context
                                      .read<SearchProductsCubit>()
                                      .sortOrderCancel();
                                },
                                selectedSortOrder: state.selectedSortOrder,
                              ),
                              SearchProductFilterWidget(
                                context,
                                productListType: widget.productListType,
                                badgeCount: context
                                    .watch<SearchProductsCubit>()
                                    .selectedFiltersCount,
                                previouslyPurchased: state.previouslyPurchased,
                                searchText: state.originalQuery,
                                selectedAttributeValueIds:
                                    state.selectedAttributeValueIds,
                                selectedBrandIds: state.selectedBrandIds,
                                selectedProductLineIds:
                                    state.selectedProductLineIds,
                                selectedCategoryId: state.selectedCategoryId,
                                selectedStockedItems:
                                    state.selectedStockedItems,
                                onApply: context
                                    .read<SearchProductsCubit>()
                                    .applyFilter,
                                onReset: context
                                    .read<SearchProductsCubit>()
                                    .resetFilter,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: (state.paginationEntity?.totalItemCount == 0)
                          ? Center(
                              child: Text(state.message ?? ''),
                            )
                          : (widget.isGridView == true)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: AlignedGridView.count(
                                    controller: _scrollController,
                                    itemCount: state.searchProductStatus ==
                                            StateStatus.moreLoading
                                        ? (state.productEntities?.length ?? 0) +
                                            1
                                        : state.productEntities?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      if (index >=
                                              (state.productEntities?.length ??
                                                  0) &&
                                          state.searchProductStatus ==
                                              StateStatus.moreLoading) {
                                        return const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }

                                      final product =
                                          state.productEntities![index];

                                      return SearchProductGridItemWidget(
                                        product: product,
                                        productSettings: state.productSettings,
                                        pricingEnable:
                                            state.productPricingEnabled,
                                        hidePricingEnable:
                                            state.hidePricingEnabled,
                                        hideInventoryEnable:
                                            state.hideInventoryEnabled,
                                        canAddToCartInProductList:
                                            state.canAddToCartInProductList,
                                      );
                                    },
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                  ),
                                )
                              : ListView.separated(
                                  controller: _scrollController,
                                  padding: EdgeInsets.zero,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 1,
                                    indent: 16,
                                    endIndent: 16,
                                    color: Color(0xFFF5F5F5),
                                  ),
                                  itemCount: state.searchProductStatus ==
                                          StateStatus.moreLoading
                                      ? (state.productEntities?.length ?? 0) + 1
                                      : state.productEntities?.length ?? 0,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (index >=
                                            (state.productEntities?.length ??
                                                0) &&
                                        state.searchProductStatus ==
                                            StateStatus.moreLoading) {
                                      return const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }

                                    final product =
                                        state.productEntities![index];

                                    return SearchProductListItemWidget(
                                      product: product,
                                      productSettings: state.productSettings,
                                      pricingEnable:
                                          state.productPricingEnabled,
                                      hidePricingEnable:
                                          state.hidePricingEnabled,
                                      hideInventoryEnable:
                                          state.hideInventoryEnabled,
                                      canAddToCartInProductList:
                                          state.canAddToCartInProductList,
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
