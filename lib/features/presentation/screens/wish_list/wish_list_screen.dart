import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_delete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final GlobalKey _wishListPageScaffoldKey = GlobalKey();

class WishListsScreen extends StatelessWidget {
  const WishListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WishListCubit>()..loadWishLists(),
      child: const WishListsPage(),
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
      key: _wishListPageScaffoldKey,
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text(LocalizationConstants.lists),
        centerTitle: false,
        actions: [
          _OptionsMenu(
            onWishListCreated: () {
              _wishListPageScaffoldKey.currentContext
                  ?.read<WishListCubit>()
                  .loadWishLists();
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
                      .read<WishListCubit>()
                      .searchQueryChanged(_textEditingController.text);
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              onChanged: (value) {
                context.read<WishListCubit>().searchQueryChanged(value);
              },
              onSubmitted: (value) {
                context.read<WishListCubit>().searchQueryChanged(value);
              },
            ),
          ),
          BlocConsumer<WishListCubit, WishListState>(
            listener: (context, state) {
              if (state.status == WishListStatus.listDeleteLoading) {
                showPleaseWait(context);
              }

              if (state.status == WishListStatus.listDeleteSuccess) {
                Navigator.of(context, rootNavigator: true).pop();
                CustomSnackBar.showListDeleted(context);
                context.read<WishListCubit>().loadWishLists();
              }

              if (state.status == WishListStatus.listDeleteFailure) {
                Navigator.of(context, rootNavigator: true).pop();
                displayDialogWidget(
                  context: context,
                  title: LocalizationConstants.error,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(LocalizationConstants.oK),
                    )
                  ],
                );
              }
            },
            builder: (context, state) {
              if (state.status == WishListStatus.loading) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state.status == WishListStatus.failure) {
                return const Expanded(
                    child: Center(child: Text(LocalizationConstants.error)));
              } else if (context.read<WishListCubit>().noWishListFound) {
                return const Expanded(
                  child: Center(
                    child: Text(LocalizationConstants.noListsAvailable),
                  ),
                );
              }
              return Expanded(
                child: Column(
                  children: [
                    if (!context.read<WishListCubit>().noWishListFound)
                      Container(
                        height: 50,
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 16),
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
                ),
              );
            },
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
      context.read<WishListCubit>().loadMoreWishlists();
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
            .format([wishList.wishListSharesCount ?? '']);
      } else if (wishList.isSharedList == true) {
        final result = LocalizationConstants.sharedBy
            .format([wishList.sharedByDisplayName ?? '']);
        return result;
      }
    } else if (wishList.isSharedList == false &&
        !(wishList.wishListSharesCount != 0)) {
      return LocalizationConstants.private;
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
          extra: WishListScreenCallbackHelper(
            onWishListUpdated: () {
              _wishListPageScaffoldKey.currentContext
                  ?.read<WishListCubit>()
                  .loadWishLists();
            },
            onWishListDeleted: () {
              _wishListPageScaffoldKey.currentContext
                  ?.read<WishListCubit>()
                  .loadWishLists();
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wishList.name ?? '', style: OptiTextStyles.body),
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
                  LocalizationConstants.updateBy.format(
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
          toolMenuList: [
            if (state.settings.allowMultipleWishLists == true ||
                (state.settings.allowMultipleWishLists == false &&
                    (state.wishLists.pagination?.totalItemCount ?? 0) == 0))
              ToolMenu(
                title: LocalizationConstants.createNewList,
                action: () {
                  AppRoute.wishListCreate.navigateBackStack(
                    context,
                    extra: WishListCreateScreenCallbackHelper(
                      onWishListCreated: onWishListCreated,
                    ),
                  );
                },
              )
          ],
        );
      },
    );
  }
}
