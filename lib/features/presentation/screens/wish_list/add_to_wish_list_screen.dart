import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_add_to/wish_list_add_to_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final GlobalKey _wishListAddToPageScaffoldKey = GlobalKey();

class AddToWishListScreen extends StatelessWidget {
  final WishListAddToCartCollection addToCartCollection;
  final void Function()? onWishListUpdated;

  const AddToWishListScreen({
    super.key,
    required this.addToCartCollection,
    this.onWishListUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WishListAddToCubit>()..loadSettings(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<WishListAddToCubit, WishListState>(
            listener: (context, state) {
              if (state.status == WishListStatus.allowMultipleListsSuccess) {
                context.read<WishListAddToCubit>().loadWishLists();
              }
            },
            builder: (context, state) {
              if (state.status == WishListStatus.allowMultipleListsLoading) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (state.status == WishListStatus.allowMultipleListsFailure) {
                return AddToSingleWishListPage(
                  addToCartCollection: addToCartCollection,
                  onWishListUpdated: onWishListUpdated,
                );
              }

              return AddToWishListPage(
                addToCartCollection: addToCartCollection,
                onWishListUpdated: onWishListUpdated,
              );
            },
          );
        },
      ),
    );
  }
}

class AddToSingleWishListPage extends StatelessWidget {
  final WishListAddToCartCollection addToCartCollection;
  final void Function()? onWishListUpdated;

  const AddToSingleWishListPage({
    super.key,
    required this.addToCartCollection,
    this.onWishListUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishListAddToCubit, WishListState>(
      listener: (context, state) {
        if (state.status == WishListStatus.allowMultipleListsSuccess) {
          context.read<WishListAddToCubit>().createEmptyWishListAndAddToList(
                listItems: addToCartCollection,
              );
        }

        if (state.status == WishListStatus.listItemAddToListLoading) {
          showPleaseWait(context);
        }

        if (state.status == WishListStatus.listItemAddToListSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          CustomSnackBar.showSnackBarMessage(
            context,
            SiteMessageConstants.defaultValueWishListProductAdded,
          );

          if (onWishListUpdated != null) {
            onWishListUpdated!();
          }

          context.pop();
        }

        if (state.status == WishListStatus.listItemAddToListFailure) {
          Navigator.of(context, rootNavigator: true).pop();
          displayDialogWidget(
            context: context,
            message: LocalizationConstants.failedToAddToList,
            title: LocalizationConstants.error,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pop();
                },
                child: const Text(LocalizationConstants.oK),
              )
            ],
          );
        }
      },
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class AddToWishListPage extends StatefulWidget {
  final WishListAddToCartCollection addToCartCollection;
  final void Function()? onWishListUpdated;

  const AddToWishListPage({
    super.key,
    required this.addToCartCollection,
    this.onWishListUpdated,
  });

  @override
  State<AddToWishListPage> createState() => _AddToWishListPageState();
}

class _AddToWishListPageState extends State<AddToWishListPage> {
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
      key: _wishListAddToPageScaffoldKey,
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text(LocalizationConstants.addToList),
        centerTitle: false,
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
                      .read<WishListAddToCubit>()
                      .searchQueryChanged(_textEditingController.text);
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              onChanged: (value) {
                context.read<WishListAddToCubit>().searchQueryChanged(value);
              },
              onSubmitted: (value) {
                context.read<WishListAddToCubit>().searchQueryChanged(value);
              },
            ),
          ),
          BlocConsumer<WishListAddToCubit, WishListState>(
            listener: (context, state) {
              if (state.status == WishListStatus.listItemAddToListLoading) {
                showPleaseWait(context);
              }

              if (state.status == WishListStatus.listItemAddToListSuccess) {
                Navigator.of(context, rootNavigator: true).pop();
                CustomSnackBar.showSnackBarMessage(
                  context,
                  SiteMessageConstants.defaultValueWishListProductAdded,
                );

                if (widget.onWishListUpdated != null) {
                  widget.onWishListUpdated!();
                }

                context.pop();
              }

              if (state.status == WishListStatus.listItemAddToListFailure) {
                CustomSnackBar.showSnackBarMessage(
                  context,
                  LocalizationConstants.failedToAddToList,
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
              } else if (context.read<WishListAddToCubit>().noWishListFound) {
                return const Expanded(
                  child: Center(
                    child: Text(LocalizationConstants.noListsAvailable),
                  ),
                );
              }
              return Expanded(
                child: Column(
                  children: [
                    if (!context.read<WishListAddToCubit>().noWishListFound)
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
                                      .read<WishListAddToCubit>()
                                      .availableSortOrders,
                                  onSortOrderChanged:
                                      (SortOrderAttribute sortOrder) async {
                                    await context
                                        .read<WishListAddToCubit>()
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
                      addToCartCollection: widget.addToCartCollection,
                      onWishListUpdated: widget.onWishListUpdated,
                    ),
                  ],
                ),
              );
            },
          ),
          ListInformationBottomSubmitWidget(
            actions: [
              PrimaryButton(
                text: LocalizationConstants.createNewList,
                onPressed: () {
                  AppRoute.wishListCreate.navigateBackStack(
                    context,
                    extra: WishListCreateScreenCallbackHelper(
                      onWishListCreated: widget.onWishListUpdated,
                      addToCartCollection: widget.addToCartCollection,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WishListsSection extends StatefulWidget {
  const _WishListsSection({
    required this.wishListEntities,
    required this.addToCartCollection,
    required this.onWishListUpdated,
  });

  final List<WishListEntity> wishListEntities;
  final WishListAddToCartCollection addToCartCollection;
  final void Function()? onWishListUpdated;

  @override
  State<_WishListsSection> createState() => _WishListsSectionState();
}

class _WishListsSectionState extends State<_WishListsSection> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<WishListAddToCubit>().loadMoreWishlists();
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
      child: BlocBuilder<WishListAddToCubit, WishListState>(
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
                onAddToListConfirmed: () {
                  context.read<WishListAddToCubit>().addToWishList(
                        wishListId: widget.wishListEntities[index].id!,
                        listItems: widget.addToCartCollection,
                      );
                },
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
  final void Function() onAddToListConfirmed;

  const _WishListItem({
    required this.wishList,
    required this.onAddToListConfirmed,
  });

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
        onTap: onAddToListConfirmed,
        child: Column(
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
    return BlocBuilder<WishListAddToCubit, WishListState>(
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
