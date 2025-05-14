import 'dart:async';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_details/wish_list_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_handler/wish_list_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_delete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_details/wish_list_line/wish_list_line_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListDetailsScreen extends BaseStatelessWidget {
  final String wishListId;

  const WishListDetailsScreen({
    super.key,
    required this.wishListId,
  });

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<WishListDetailsCubit>();
        unawaited(cubit.loadWishListDetails(wishListId));
        return cubit;
      },
      child: Builder(builder: (context) {
        return BlocListener<WishListHandlerCubit, WishListHandlerState>(
          listener: (context, state) {
            if (state.status == WishListHandlerStatus.shouldRefreshWishList) {
              unawaited(
                context
                    .read<WishListDetailsCubit>()
                    .loadWishListDetails(wishListId),
              );
              context.read<WishListHandlerCubit>().resetState();
            }
          },
          child: WishListDetailsPage(
            wishListId: wishListId,
          ),
        );
      }),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() {
    return AnalyticsEvent(
      AnalyticsConstants.eventViewScreen,
      AnalyticsConstants.screenNameListDetail,
    ).withProperty(
      name: AnalyticsConstants.eventPropertyListId,
      strValue: wishListId,
    );
  }
}

class WishListDetailsPage extends StatefulWidget {
  const WishListDetailsPage({
    super.key,
    required this.wishListId,
  });

  final String wishListId;

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
          _FavoriteButton(
            isFavorite: context
                    .watch<WishListDetailsCubit>()
                    .state
                    .wishList
                    .isFavorite ==
                true,
            onPressed: () {
              unawaited(
                context.read<WishListDetailsCubit>().toggleWishListFavorite(),
              );
            },
          ),
          _OptionsMenu(
            onWishListUpdated: () =>
                context.read<WishListHandlerCubit>().shouldRefreshWishList(),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Input(
              hintText: LocalizationConstants.search.localized(),
              suffixIcon: IconButton(
                icon: const SvgAssetImage(
                  assetName: AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  _textEditingController.clear();
                  unawaited(
                    context
                        .read<WishListDetailsCubit>()
                        .searchQueryChanged(_textEditingController.text),
                  );
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              onSubmitted: (value) {
                unawaited(
                  context
                      .read<WishListDetailsCubit>()
                      .searchQueryChanged(value),
                );
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<WishListDetailsCubit>()
                    .loadWishListDetails(widget.wishListId)
                    .ignore();
              },
              child: BlocConsumer<WishListDetailsCubit, WishListDetailsState>(
                listener: (context, state) {
                  if (state.status == WishListStatus.listAddToCartSuccess) {
                    unawaited(
                      context.read<CartCountCubit>().onCartItemChange(),
                    );
                    CustomSnackBar.showWishListAddToCart(context);
                  }

                  if (state.status == WishListStatus.listAddToCartFailure) {
                    CustomSnackBar.showWishListAddToCartError(context);
                  }

                  if (state.status ==
                      WishListStatus.listAddToCartFailureTimeOut) {
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      LocalizationConstants
                          .addWishListToCartTimeoutCheckCartAgain
                          .localized(),
                      seconds: 3,
                    );
                  }

                  if (state.status ==
                      WishListStatus.listAddToCartPartialSuccess) {
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      context
                          .read<WishListDetailsCubit>()
                          .siteMessageNotAllAddedToCart,
                      seconds: 3,
                    );
                  }

                  if (state.status ==
                      WishListStatus.listAddToCartFailureOutOfStock) {
                    displayDialogWidget(
                      context: context,
                      title:
                          LocalizationConstants.productsOutOfStock.localized(),
                      message: LocalizationConstants.productsOutOfStockMessage
                          .localized(),
                      actions: [
                        TextButton(
                          onPressed: () {
                            unawaited(
                              context
                                  .read<WishListDetailsCubit>()
                                  .addWishListToCart(ignoreOutOfStock: true),
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text(LocalizationConstants.oK.localized()),
                        )
                      ],
                    );
                  }

                  if (state.status == WishListStatus.errorModification) {
                    displayDialogWidget(
                      context: context,
                      title: LocalizationConstants.error.localized(),
                      message: state.message ?? '',
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(LocalizationConstants.oK.localized()),
                        )
                      ],
                    );
                  }

                  if (state.status == WishListStatus.listLineAddToCartSuccess) {
                    CustomSnackBar.showProductAddedToCart(
                        context,
                        context
                            .read<WishListDetailsCubit>()
                            .siteMessageAddToCartSuccess);
                    unawaited(
                      context.read<CartCountCubit>().onCartItemChange(),
                    );
                  }

                  if (state.status == WishListStatus.listLineAddToCartFailure) {
                    CustomSnackBar.showAddToCartFailed(
                        context,
                        context
                            .read<WishListDetailsCubit>()
                            .siteMessageAddToCartFailed);
                  }

                  if (state.status == WishListStatus.listLineDeleteSuccess) {
                    CustomSnackBar.showProductDeleted(context);
                    unawaited(
                      context
                          .read<WishListDetailsCubit>()
                          .loadWishListLines(state.wishList),
                    );
                  }

                  if (state.status == WishListStatus.listLineDeleteFailure) {
                    CustomSnackBar.showAddToCartFailed(
                        context,
                        context
                            .read<WishListDetailsCubit>()
                            .siteMessageAddToCartFailed);
                  }

                  if (state.status == WishListStatus.listUpdateSuccess) {
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      LocalizationConstants.listSaved.localized(),
                    );

                    context
                        .read<WishListHandlerCubit>()
                        .shouldRefreshWishList();
                  }

                  if (state.status == WishListStatus.listUpdateFailure) {
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      LocalizationConstants.renameFailed.localized(),
                    );
                  }

                  if (state.status == WishListStatus.listDeleteLoading) {
                    showPleaseWait(context);
                  }

                  if (state.status == WishListStatus.listDeleteSuccess) {
                    Navigator.of(context, rootNavigator: true).pop();
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      LocalizationConstants.listDeleted.localized(),
                    );

                    context
                        .read<WishListHandlerCubit>()
                        .shouldRefreshWishList();

                    Navigator.of(context).pop();
                  }

                  if (state.status == WishListStatus.listDeleteFailure) {
                    Navigator.of(context, rootNavigator: true).pop();
                    displayDialogWidget(
                      context: context,
                      title: LocalizationConstants.error.localized(),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(LocalizationConstants.oK.localized()),
                        )
                      ],
                    );
                  }

                  if (state.status == WishListStatus.listCopySuccess) {
                    Navigator.of(context, rootNavigator: true).pop();
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      LocalizationConstants.listCopied.localized(),
                    );

                    context
                        .read<WishListHandlerCubit>()
                        .shouldRefreshWishList();
                  }

                  if (state.status == WishListStatus.listCopyLoading) {
                    showPleaseWait(context);
                  }

                  if (state.status == WishListStatus.listCopyFailure) {
                    Navigator.of(context, rootNavigator: true).pop();
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      LocalizationConstants.copyFailed.localized(),
                    );
                  }

                  if (state.status == WishListStatus.listLeaveSuccess) {
                    context
                        .read<WishListHandlerCubit>()
                        .shouldRefreshWishList();

                    Navigator.of(context).pop();
                  }

                  if (state.status == WishListStatus.listLeaveFailure) {
                    displayDialogWidget(
                      context: context,
                      title: LocalizationConstants.error.localized(),
                      message: context
                          .watch<WishListDetailsCubit>()
                          .siteMessageMobileAppAlertCommunicationError,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(LocalizationConstants.oK.localized()),
                        )
                      ],
                    );
                  }

                  if (state.status ==
                      WishListStatus.listFavoriteUpdateLoading) {
                    showPleaseWait(context);
                  }

                  if (state.status ==
                          WishListStatus.listFavoriteUpdateSuccessAdded ||
                      state.status ==
                          WishListStatus.listFavoriteUpdateSuccessRemoved) {
                    Navigator.of(context, rootNavigator: true).pop();
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      state.wishList.isFavorite == true
                          ? LocalizationConstants.addedToFavorites.localized()
                          : LocalizationConstants.removedFromFavorites
                              .localized(),
                    );

                    context
                        .read<WishListHandlerCubit>()
                        .shouldRefreshWishListWithoutDetails();
                  }

                  if (state.status ==
                      WishListStatus.listFavoriteUpdateFailure) {
                    Navigator.of(context, rootNavigator: true).pop();
                    displayDialogWidget(
                      context: context,
                      title: LocalizationConstants.error.localized(),
                      message: context
                          .watch<WishListDetailsCubit>()
                          .siteMessageMobileAppAlertCommunicationError,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(LocalizationConstants.oK.localized()),
                        )
                      ],
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == WishListStatus.loading ||
                      state.status == WishListStatus.listAddToCartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == WishListStatus.failure) {
                    return Center(
                        child: Text(LocalizationConstants.error.localized()));
                  } else if (context
                      .read<WishListDetailsCubit>()
                      .emptyWishList) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverFillRemaining(
                          child: Center(
                            child: Text(
                              context
                                  .watch<WishListDetailsCubit>()
                                  .siteMessageWishListNoProducts,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (context
                      .read<WishListDetailsCubit>()
                      .noSearchResult) {
                    return Center(
                      child: Text(
                        context
                            .watch<WishListDetailsCubit>()
                            .siteMessageDealerLocatorNoResults,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      if (!context.read<WishListDetailsCubit>().emptyWishList)
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
                                          )
                                          .ignore();
                                    },
                                    onSortOrderCancel: context
                                        .read<WishListDetailsCubit>()
                                        .cancelSort,
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
                          isEnabled: state.canAddWishListToCart == true,
                          onPressed: () {
                            unawaited(
                              context
                                  .read<WishListDetailsCubit>()
                                  .addWishListToCart(),
                            );
                          },
                          text: LocalizationConstants.addListToCart.localized(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({
    required this.isFavorite,
    required this.onPressed,
  });

  final bool isFavorite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgAssetImage(
        assetName: isFavorite
            ? AssetConstants.iconHeartFilled
            : AssetConstants.iconHeartUnfilled,
        semanticsLabel: isFavorite ? 'favorite icon' : 'unfavorite icon',
        fit: BoxFit.fitWidth,
      ),
      onPressed: onPressed,
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
      unawaited(
        context.read<WishListDetailsCubit>().loadMoreWishListLines(),
      );
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
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
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

              final canEditWishList =
                  (state.wishList.allowEditingBySharedWithUsers == true ||
                          state.wishList.isSharedList != true) &&
                      state.wishList.isAutogenerated != true;

              final line = state.wishListLines.wishListLines?[index];

              return WishListLineWidget(
                wishListLineEntity: line!,
                realTimeLoading:
                    state.status == WishListStatus.realTimeAttributesLoading,
                isDeleteButtonVisible: canEditWishList,
                canEditQuantity:
                    line.canEnterQuantity == true && canEditWishList,
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}

class _OptionsMenu extends StatelessWidget {
  const _OptionsMenu({
    this.onWishListUpdated,
  });

  final void Function()? onWishListUpdated;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListDetailsCubit, WishListDetailsState>(
      builder: (context, state) {
        return BottomMenuWidget(
          screenName: AnalyticsConstants.screenNameListDetail,
          websitePath: WebsitePaths.listDetailsWebsitePath.format(
            [
              state.wishList.id ?? '',
            ],
          ),
          toolMenuList: [
            ToolMenu(
              title: LocalizationConstants.listInformation.localized(),
              action: () async {
                final result = await context.pushNamed(
                  AppRoute.wishListInfo.name,
                  extra: state.wishList,
                );

                if (!context.mounted) {
                  return;
                }

                if (result == true) {
                  unawaited(
                    context
                        .read<WishListDetailsCubit>()
                        .loadWishListDetails(state.wishList.id ?? ''),
                  );
                  if (onWishListUpdated != null) {
                    onWishListUpdated!();
                  }
                }
              },
            ),
            if (state.wishList.isSharedList != true &&
                state.wishList.isAutogenerated != true)
              ToolMenu(
                title: LocalizationConstants.rename.localized(),
                action: () {
                  displayInputDialog(
                    context: context,
                    title: LocalizationConstants.rename.localized(),
                    hintText: LocalizationConstants.enterListName.localized(),
                    confirmText: LocalizationConstants.save.localized(),
                    existingValue: state.wishList.name ?? '',
                    onSubmit: (text) {
                      unawaited(
                        context
                            .read<WishListDetailsCubit>()
                            .renameWishList(text),
                      );
                    },
                  );
                },
              ),
            if (state.settings.allowEditingOfWishLists == true &&
                state.wishList.isSharedList == true &&
                state.wishList.shareOption != "AllCustomerUsers")
              ToolMenu(
                title: LocalizationConstants.leave.localized(),
                action: () {
                  displayDialogWidget(
                    context: context,
                    title: LocalizationConstants.leaveList.localized(),
                    message: LocalizationConstants.leaveSpecificList
                        .localized()
                        .format(
                      [state.wishList.name ?? ''],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(LocalizationConstants.cancel.localized()),
                      ),
                      TextButton(
                        onPressed: () {
                          unawaited(
                            context
                                .read<WishListDetailsCubit>()
                                .leaveWishList(),
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text(LocalizationConstants.leave.localized()),
                      ),
                    ],
                  );
                },
              ),
            if (context
                .read<WishListDetailsCubit>()
                .canDeleteWishList(wishList: state.wishList))
              ToolMenu(
                title: LocalizationConstants.delete.localized(),
                action: () {
                  displayWishListDeleteWidget(
                    wishList: state.wishList,
                    context: context,
                    onDelete: () {
                      unawaited(
                        context.read<WishListDetailsCubit>().deleteWishList(),
                      );
                    },
                  );
                },
              ),
            ToolMenu(
              title: LocalizationConstants.copy.localized(),
              action: () {
                displayInputDialog(
                  context: context,
                  title: LocalizationConstants.copyList.localized(),
                  hintText: LocalizationConstants.enterListName.localized(),
                  onSubmit: (name) async {
                    await context
                        .read<WishListDetailsCubit>()
                        .copyWishList(name: name.trim());
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
