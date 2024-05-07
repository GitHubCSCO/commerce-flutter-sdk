import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_add_to_cart_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list_details/wish_list_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list_details/wish_list_line/wish_list_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListDetailsScreen extends StatelessWidget {
  final String wishListId;

  const WishListDetailsScreen({
    super.key,
    required this.wishListId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<WishListDetailsCubit>()..loadWishListDetails(wishListId),
      child: const WishListDetailsPage(),
    );
  }
}

class WishListDetailsPage extends StatefulWidget {
  const WishListDetailsPage({super.key});

  @override
  State<WishListDetailsPage> createState() => _WishListDetailsPageState();
}

class _WishListDetailsPageState extends State<WishListDetailsPage> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        centerTitle: false,
        title: Text(
          context.watch<WishListDetailsCubit>().state.wishList.name ?? '',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => CustomSnackBar.showComingSoonSnackBar(context),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Input(
              hintText: LocalizationConstants.search,
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  _textEditingController.clear();
                  context
                      .read<WishListDetailsCubit>()
                      .searchQueryChanged(_textEditingController.text);
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              onChanged: (value) {
                context.read<WishListDetailsCubit>().searchQueryChanged(value);
              },
              onSubmitted: (value) {
                context.read<WishListDetailsCubit>().searchQueryChanged(value);
              },
            ),
          ),
          BlocConsumer<WishListDetailsCubit, WishListDetailsState>(
            listener: (context, state) {
              if (state.addToCartStatus == WishListAddToCartStatus.success) {
                context.read<CartCountCubit>().onCartItemChange();
                CustomSnackBar.showWishListAddToCart(context);
              }

              if (state.addToCartStatus == WishListAddToCartStatus.failure) {
                CustomSnackBar.showWishListAddToCartError(context);
              }

              if (state.addToCartStatus ==
                  WishListAddToCartStatus.failureOutOfStock) {
                displayDialogWidget(
                  context: context,
                  title: LocalizationConstants.productsOutOfStock,
                  message: LocalizationConstants.productsOutOfStockMessage,
                  actions: [
                    TextButton(
                      onPressed: () {
                        context
                            .read<WishListDetailsCubit>()
                            .addWishListToCart(ignoreOutOfStock: true);
                        Navigator.of(context).pop();
                      },
                      child: const Text(LocalizationConstants.oK),
                    )
                  ],
                );
              }
            },
            builder: (context, state) {
              if (state.status == WishListStatus.loading ||
                  state.addToCartStatus == WishListAddToCartStatus.loading) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state.status == WishListStatus.failure) {
                return const Expanded(
                    child: Center(child: Text(LocalizationConstants.error)));
              } else if (context.read<WishListDetailsCubit>().noWishListFound) {
                return const Expanded(
                  child: Center(
                    child: Text(LocalizationConstants.noListsAvailable),
                  ),
                );
              }
              return Expanded(
                child: Column(
                  children: [
                    if (!context.read<WishListDetailsCubit>().noWishListFound)
                      Container(
                        height: 50,
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${state.wishListLines.pagination?.totalItemCount ?? ' '} Products',
                              style: OptiTextStyles.header3,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 10),
                                SortToolMenu(
                                  availableSortOrders: context
                                      .read<WishListDetailsCubit>()
                                      .availableSortOrders,
                                  onSortOrderChanged:
                                      (SortOrderAttribute sortOrder) async {
                                    context
                                        .read<WishListDetailsCubit>()
                                        .changeSortOrder(
                                          sortOrder as WishListLineSortOrder,
                                        );
                                  },
                                  selectedSortOrder: state.sortOrder,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    _WishListLinesSection(
                      wishListLines: state.wishListLines.wishListLines ?? [],
                    ),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: PrimaryButton(
                        onPressed: () {
                          context
                              .read<WishListDetailsCubit>()
                              .addWishListToCart();
                        },
                        text: LocalizationConstants.addListToCart,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WishListLinesSection extends StatefulWidget {
  const _WishListLinesSection({required this.wishListLines});

  final List<WishListLineEntity> wishListLines;

  @override
  State<_WishListLinesSection> createState() => _WishListLinesSectionState();
}

class _WishListLinesSectionState extends State<_WishListLinesSection> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<WishListDetailsCubit>().loadMoreWishListLines();
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
    return Expanded(
      child: BlocBuilder<WishListDetailsCubit, WishListDetailsState>(
        builder: (context, state) {
          if (state.status == WishListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == WishListStatus.failure) {
            return const Center(
              child: Text('Failed to load wish list details'),
            );
          } else {
            return ListView.separated(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: state.status == WishListStatus.moreLoading
                  ? widget.wishListLines.length + 1
                  : widget.wishListLines.length,
              itemBuilder: (context, index) {
                if (index >= state.wishListLines.wishListLines!.length &&
                    state.status == WishListStatus.moreLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final line = state.wishListLines.wishListLines?[index];
                return WishListLineWidget(wishListLineEntity: line!);
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
        },
      ),
    );
  }
}
