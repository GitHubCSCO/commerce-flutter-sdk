
import 'dart:async';

import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/website_paths.dart';
import 'package:commerce_flutter_sdk/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/wish_list/wish_list_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/wish_list/wish_list_handler/wish_list_handler_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/wish_list/wish_list_delete_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListsScreen extends BaseStatelessWidget {
  const WishListsScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<WishListCubit>();
        unawaited(cubit.loadWishLists());
        return cubit;
      },
      child: Builder(builder: (context) {
        return BlocListener<WishListHandlerCubit, WishListHandlerState>(
          listener: (context, state) {
            if (state.status == WishListHandlerStatus.shouldRefreshWishList) {
              unawaited(context.read<WishListCubit>().loadWishLists());
              context.read<WishListHandlerCubit>().resetState();
            }
          },
          child: const WishListsPage(),
        );
      }),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() {
    return AnalyticsEvent(
      AnalyticsConstants.eventViewScreen,
      AnalyticsConstants.screenNameLists,
    );
  }
}

class WishListsPage extends StatefulWidget {
  const WishListsPage({super.key});

  @override
  State<WishListsPage> createState() => _WishListsPageState();
}

class _WishListsPageState extends State<WishListsPage> {
  final websitePath = WebsitePaths.listsWebsitePath;

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
        title: Text(LocalizationConstants.lists.localized()),
        centerTitle: false,
        actions: [
          _OptionsMenu(
            onWishListCreated: () {
              context.read<WishListHandlerCubit>().shouldRefreshWishList();
            },
          ),
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
                icon:  SvgAssetImage(
                  assetName: AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  _textEditingController.clear();

                  unawaited(
                    context
                        .read<WishListCubit>()
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
                  context.read<WishListCubit>().searchQueryChanged(value),
                );
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                unawaited(
                  context.read<WishListCubit>().loadWishLists(),
                );
              },
              child: BlocConsumer<WishListCubit, WishListState>(
                listener: (context, state) {
                  if (state.status == WishListStatus.listDeleteLoading) {
                    showPleaseWait(context);
                  }

                  if (state.status == WishListStatus.listDeleteSuccess) {
                    context
                        .read<WishListHandlerCubit>()
                        .shouldRefreshWishList();
                    Navigator.of(context, rootNavigator: true).pop();
                    CustomSnackBar.showSnackBarMessage(
                      context,
                      LocalizationConstants.listDeleted.localized(),
                    );
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
                },
                builder: (context, state) {
                  if (state.status == WishListStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == WishListStatus.failure) {
                    return Center(
                        child: Text(LocalizationConstants.error.localized()));
                  } else if (context.read<WishListCubit>().noWishListFound) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverFillRemaining(
                          child: Center(
                            child: Text(LocalizationConstants.noListsAvailable
                                .localized()),
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      if (!context.read<WishListCubit>().noWishListFound)
                        Container(
                          height: 50,
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 10),
                                  SortToolMenu(
                                    availableSortOrders: context
                                        .read<WishListCubit>()
                                        .availableSortOrders,
                                    onSortOrderChanged:
                                        (SortOrderAttribute sortOrder) async {
                                      await context
                                          .read<WishListCubit>()
                                          .changeSortOrder(
                                            sortOrder as WishListSortOrder,
                                          );
                                    },
                                    onSortOrderCancel: context
                                        .read<WishListCubit>()
                                        .cancelSort,
                                    selectedSortOrder: state.sortOrder,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      _WishListsSection(
                        wishListEntities:
                            state.wishLists.wishListCollection ?? [],
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _WishListsSection extends StatefulWidget {
  const _WishListsSection({required this.wishListEntities});

  final List<WishListEntity> wishListEntities;

  @override
  State<_WishListsSection> createState() => _WishListsSectionState();
}

class _WishListsSectionState extends State<_WishListsSection> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      unawaited(
        context.read<WishListCubit>().loadMoreWishlists(),
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
      child: BlocBuilder<WishListCubit, WishListState>(
        builder: (context, state) {
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index >= state.wishLists.wishListCollection!.length &&
                  state.status == WishListStatus.moreLoading) {
                return const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return _WishListItem(
                wishList: widget.wishListEntities[index],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
                thickness: 1,
              );
            },
            itemCount: state.status == WishListStatus.moreLoading
                ? widget.wishListEntities.length + 1
                : widget.wishListEntities.length,
          );
        },
      ),
    );
  }
}

class _WishListItem extends StatelessWidget {
  final WishListEntity wishList;

  const _WishListItem({required this.wishList});

  String _constructListSharingDisplay() {
    if (wishList.isSharedList == true ||
        (wishList.wishListSharesCount != null &&
            wishList.wishListSharesCount! > 0)) {
      if (wishList.wishListSharesCount! > 0 && wishList.isSharedList == false) {
        return LocalizationConstants.sharedWith
            .localized()
            .format([wishList.wishListSharesCount ?? '']);
      } else if (wishList.isSharedList == true) {
        final result = LocalizationConstants.sharedBy
            .localized()
            .format([wishList.sharedByDisplayName ?? '']);
        return result;
      }
    } else if (wishList.isSharedList == false &&
        !(wishList.wishListSharesCount != 0)) {
      return LocalizationConstants.private.localized();
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      color: OptiAppColors.backgroundWhite,
      child: InkWell(
        onTap: () => AppRoute.wishlistsDetails.navigateBackStack(
          context,
          pathParameters: {
            'id': wishList.id ?? '',
          },
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wishList.name ?? '',
                    style: OptiTextStyles.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    wishList.description ?? '',
                    style: OptiTextStyles.bodySmall.copyWith(
                      color: OptiAppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _constructListSharingDisplay(),
                    style: OptiTextStyles.bodySmall.copyWith(
                      color: OptiAppColors.textSecondary,
                    ),
                  ),
                  Text(
                    LocalizationConstants.updateBy.localized().format(
                      [
                        wishList.updatedOn != null
                            ? DateFormat(CoreConstants.dateFormatString)
                                .format(wishList.updatedOn!)
                            : '',
                        wishList.updatedByDisplayName ?? '',
                      ],
                    ),
                    style: OptiTextStyles.bodySmall.copyWith(
                      color: OptiAppColors.textSecondary,
                    ),
                  )
                ],
              ),
            ),
            if (context
                .read<WishListCubit>()
                .canDeleteWishList(wishList: wishList))
              InkWell(
                onTap: () async {
                  displayWishListDeleteWidget(
                    wishList: wishList,
                    context: context,
                    onDelete: () {
                      context.read<WishListCubit>().deleteWishList(
                            wishListId: wishList.id,
                          );
                    },
                  );
                },
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    AssetConstants.cartItemRemoveIcon,
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

class _OptionsMenu extends StatelessWidget {
  const _OptionsMenu({
    this.onWishListCreated,
  });
  final void Function()? onWishListCreated;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListCubit, WishListState>(
      builder: (context, state) {
        return BottomMenuWidget(
          websitePath: WebsitePaths.listsWebsitePath,
          screenName: AnalyticsConstants.screenNameLists,
          toolMenuList: [
            if (state.settings.allowMultipleWishLists == true ||
                (state.settings.allowMultipleWishLists == false &&
                    (state.wishLists.pagination?.totalItemCount ?? 0) == 0))
              ToolMenu(
                title: LocalizationConstants.createNewList.localized(),
                action: () async {
                  context.read<RootBloc>().add(
                        RootAnalyticsEvent(
                          AnalyticsEvent(
                            AnalyticsConstants.eventViewCreateList,
                            AnalyticsConstants.screenNameLists,
                          ),
                        ),
                      );
                  final result = await context.pushNamed(
                    AppRoute.wishListCreate.name,
                    extra: WishListCreateScreenCallbackHelper(),
                  );

                  if (result == true && onWishListCreated != null) {
                    onWishListCreated!();
                  }
                },
              )
          ],
        );
      },
    );
  }
}
