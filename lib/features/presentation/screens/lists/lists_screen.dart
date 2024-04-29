import 'package:commerce_flutter_app/core/colors/app_colors.dart';
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
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/wish_list/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WishListCubit>()..loadWishLists(),
      child: ListsPage(),
    );
  }
}

class ListsPage extends StatelessWidget {
  ListsPage({super.key});

  final websitePath = WebsitePaths.listsWebsitePath;
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text(LocalizationConstants.lists),
        centerTitle: false,
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
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              controller: _textEditingController,
              onSubmitted: (value) {
                CustomSnackBar.showComingSoonSnackBar(context);
              },
            ),
          ),
          BlocBuilder<WishListCubit, WishListState>(
            builder: (context, state) {
              if (state.status == WishListStatus.loading) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state.status == WishListStatus.failure) {
                return const Expanded(
                    child: Center(child: Text(LocalizationConstants.error)));
              }
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              IconButton(
                                padding: const EdgeInsets.all(10),
                                onPressed: () =>
                                    CustomSnackBar.showComingSoonSnackBar(
                                        context),
                                icon: SvgPicture.asset(
                                  height: 20,
                                  width: 20,
                                  AssetConstants.sortIcon,
                                  semanticsLabel: 'sort icon',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const _WishListsSection(),
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

class _WishListsSection extends StatelessWidget {
  const _WishListsSection();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WishListCubit, WishListState>(
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return _WishListItem(
                wishList: state.wishLists.wishListCollection![index],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
                thickness: 1,
              );
            },
            itemCount: state.wishLists.wishListCollection?.length ?? 0,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(wishList.name ?? '', style: OptiTextStyles.body),
          Text(
            wishList.description ?? '',
            style: OptiTextStyles.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            _constructListSharingDisplay(),
            style: OptiTextStyles.bodySmall,
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
            style: OptiTextStyles.bodySmall,
          )
        ],
      ),
    );
  }
}
