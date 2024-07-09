import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/domain/enums/search_product_status.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_pricing_widgert.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_product_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchProductsWidget extends StatefulWidget {
  final Function(int) onPageChanged; // Callback to handle page changes
  final ProductListType productListType;

  const SearchProductsWidget({
    super.key,
    required this.onPageChanged, required this.productListType,
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
                CustomSnackBar.showProductAddedToCart(context);
                break;
              case AddToCartFailure():
                break;
            }
          },
          child: state.searchProductStatus == SearchProductStatus.loading
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
                            visible: state.originalQuery != null && state.originalQuery!.isNotEmpty,
                            child: Text(
                              state.originalQuery==null ?
                              LocalizationConstants.results.format(
                                [
                                  (state.paginationEntity
                                              ?.totalItemCount ==
                                          0)
                                      ? LocalizationConstants.no
                                      : state.paginationEntity
                                          ?.totalItemCount
                                ],
                              )
                              :
                              LocalizationConstants.resultsFor.format(
                                [
                                  (state.paginationEntity
                                              ?.totalItemCount ==
                                          0)
                                      ? LocalizationConstants.no
                                      : state.paginationEntity
                                          ?.totalItemCount,
                                  state.originalQuery
                                ],
                              ),
                              style: OptiTextStyles.header3,
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
                                selectedSortOrder: state.selectedSortOrder,
                              ),
                              SearchProductFilterWidget(
                                context,
                                productListType: widget.productListType,
                                badgeCount: context
                                    .watch<SearchProductsCubit>()
                                    .selectedFiltersCount,
                                previouslyPurchased: state.previouslyPurchased,
                                searchText:
                                    state.originalQuery,
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => const Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: Color(0xFFF5F5F5),
                        ),
                        itemCount: state.searchProductStatus ==
                                SearchProductStatus.moreLoading
                            ? (state.productEntities?.length ?? 0) + 1
                            : state.productEntities?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index >=
                                  (state.productEntities?.length ??
                                      0) &&
                              state.searchProductStatus ==
                                  SearchProductStatus.moreLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final product =
                              state.productEntities![index];
                          return SearchProductWidget(
                            product: product,
                            productSettings: state.productSettings,
                            pricingEnable: state.productPricingEnabled,
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

class SearchProductWidget extends StatelessWidget {
  final ProductEntity product;
  final ProductSettings? productSettings;
  final bool? pricingEnable;

  const SearchProductWidget({super.key, required this.product, required this.productSettings, required this.pricingEnable});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var productId = product.styleParentId ?? product.id;
        //TODO what if productid is null, 
        AppRoute.topLevelProductDetails.navigateBackStack(context,
            pathParameters: {"productId": productId.toString()},
            extra: product);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                  LineItemPricingWidget(
                    discountMessage: product.pricing?.getDiscountValue(),
                    priceValueText: product.updatePriceValueText(pricingEnable),
                    unitOfMeasureValueText: product.updateUnitOfMeasure(pricingEnable),
                    availabilityText: product.availability?.message,
                    productId: product.id,
                    erpNumber: product.erpNumber,
                    unitOfMeasure: product.unitOfMeasure,
                    showViewAvailabilityByWarehouse: _showWarehouseInventory(),
                  ),
                ],
              ),
            ),
            BlocProvider<AddToCartCubit>(
                create: (context) =>
                    sl<AddToCartCubit>()..updateAddToCartButton(product),
                child: BlocListener<AddToCartCubit, AddToCartState>(
                    listener: (context, state) {
                      if (state is AddToCartSuccess) {
                        context.read<CartCountCubit>().onCartItemChange();
                        CustomSnackBar.showProductAddedToCart(context);
                      }
                    },
                    child: BlocBuilder<AddToCartCubit, AddToCartState>(
                      buildWhen: (previous, current) =>
                          current is AddToCartEnable &&
                          previous is AddToCartButtonLoading,
                      builder: (context, state) {
                        if (state is AddToCartInitial) {
                          return Container();
                        } else if (state is AddToCartButtonLoading) {
                          return Container(
                            alignment: Alignment.bottomLeft,
                            child: LoadingAnimationWidget.prograssiveDots(
                              color: OptiAppColors.iconPrimary,
                              size: 30,
                            ),
                          );
                        } else if (state is AddToCartEnable) {
                          if (state.canAddToCart) {
                            return InkWell(
                              onTap: () {
                                var productId =
                                    product.styleParentId ?? product.id;
                                context
                                    .read<AddToCartCubit>()
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
                            );
                          }
                        }
                        return Container();
                      },
                    )))
          ],
        ),
      ),
    );
  }

  bool _showWarehouseInventory() {
    var warehouseInventoryButtonEnabled = InventoryUtils.isInventoryPerWarehouseButtonShownAsync(productSettings);
    var showWarehouseInventoryButton = false;

    if (!(product.isConfigured ?? false) || (product.isFixedConfiguration ?? false) && !(product.isStyleProductParent ?? false)) {
      if (product.availability != null && !(product.availability?.requiresRealTimeInventory ?? false) && (product.availability?.messageType ?? 0) != 0) {
        showWarehouseInventoryButton = (product.trackInventory ?? false) && warehouseInventoryButtonEnabled;
      }
    }

    return showWarehouseInventoryButton;
  }

}
