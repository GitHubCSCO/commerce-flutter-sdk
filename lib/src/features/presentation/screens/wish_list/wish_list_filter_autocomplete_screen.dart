import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_filter/wish_list_filter_autocomplete_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/extra/delayer.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/network_image.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum WishListFilterAutocompleteType {
  erpNumber,
  brandId,
  sharedBy,
  ;

  static const erpNumberKey = 'erpNumber';
  static const brandIdKey = 'brandId';
  static const sharedByKey = 'sharedBy';
}

// Should get the selected value in calling function by context.pop(selectedValue);
class WishListFilterAutocompleteScreen extends StatelessWidget {
  final WishListFilterAutocompleteType type;

  const WishListFilterAutocompleteScreen({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WishListFilterAutocompleteCubit>(),
      child: WishListFilterAutocompletePage(type: type),
    );
  }
}

class WishListFilterAutocompletePage extends StatefulWidget {
  final WishListFilterAutocompleteType type;

  const WishListFilterAutocompletePage({
    super.key,
    required this.type,
  });

  @override
  State<WishListFilterAutocompletePage> createState() =>
      _WishListFilterAutocompletePageState();
}

class _WishListFilterAutocompletePageState
    extends State<WishListFilterAutocompletePage> {
  final _textEditingController = TextEditingController();
  final _delayer = Delayer(milliseconds: 500);

  @override
  void dispose() {
    _textEditingController.dispose();
    _delayer.dispose();
    super.dispose();
  }

  void searchQueryChanged(String query) {
    _delayer.run(() {
      switch (widget.type) {
        case WishListFilterAutocompleteType.erpNumber:
          unawaited(
            context.read<WishListFilterAutocompleteCubit>().getProducts(query),
          );
        case WishListFilterAutocompleteType.brandId:
          unawaited(
            context.read<WishListFilterAutocompleteCubit>().getBrands(query),
          );
        case WishListFilterAutocompleteType.sharedBy:
          unawaited(
            context
                .read<WishListFilterAutocompleteCubit>()
                .getSharedByUsers(query),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        centerTitle: false,
        title: Text(
          switch (widget.type) {
            WishListFilterAutocompleteType.erpNumber =>
              LocalizationConstants.searchForAProduct.localized(),
            WishListFilterAutocompleteType.brandId =>
              LocalizationConstants.searchForABrand.localized(),
            WishListFilterAutocompleteType.sharedBy =>
              LocalizationConstants.searchByUsername.localized(),
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Input(
                hintText: switch (widget.type) {
                  WishListFilterAutocompleteType.erpNumber =>
                    LocalizationConstants.searchForAProduct.localized(),
                  WishListFilterAutocompleteType.brandId =>
                    LocalizationConstants.searchForABrand.localized(),
                  WishListFilterAutocompleteType.sharedBy =>
                    LocalizationConstants.searchByUsername.localized(),
                },
                suffixIcon: IconButton(
                  icon: SvgAssetImage(
                    assetName: AssetConstants.iconClear,
                    semanticsLabel: 'search query clear icon',
                    fit: BoxFit.fitWidth,
                  ),
                  onPressed: () {
                    _textEditingController.clear();
                    context.read<WishListFilterAutocompleteCubit>().reset();
                    context.closeKeyboard();
                  },
                ),
                onTapOutside: (p0) => context.closeKeyboard(),
                textInputAction: TextInputAction.search,
                controller: _textEditingController,
                onChanged: (value) {
                  searchQueryChanged(value);
                },
              ),
            ),
            Expanded(child: BlocBuilder<WishListFilterAutocompleteCubit,
                WishListFilterAutocompleteState>(
              builder: (context, state) {
                switch (state) {
                  case WishListFilterError(:final message):
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          message,
                          style: OptiTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  case WishListFilterAutocompleteInitial():
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          'Start typing to see suggestions',
                          style: OptiTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  case WishListFilterAutocompleteLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  case WishListFilterAutocompleteBrandsLoaded(:final brands):
                    if (brands.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            LocalizationConstants.noOptions.localized(),
                            style: OptiTextStyles.body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final brand = brands[index];
                        return ListTile(
                          tileColor: OptiAppColors.backgroundWhite,
                          leading: NetworkImageWithFallback(
                            imageUrl: brand.image,
                          ),
                          title: Text(brand.title ?? ''),
                          subtitle: Text(brand.subtitle ?? ''),
                          onTap: () {
                            context.pop(
                              WishListFilterItemEntity(
                                actualValue: brand.id,
                                displayValue: brand.title,
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                      itemCount: brands.length,
                    );
                  case WishListFilterAutocompleteProductsLoaded(
                      :final products
                    ):
                    if (products.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            LocalizationConstants.noOptions.localized(),
                            style: OptiTextStyles.body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          tileColor: OptiAppColors.backgroundWhite,
                          leading: NetworkImageWithFallback(
                            imageUrl: product.image,
                          ),
                          title: Text(product.title ?? ''),
                          subtitle: Text(product.subtitle ?? ''),
                          onTap: () {
                            context.pop(
                              WishListFilterItemEntity(
                                actualValue: product.erpNumber,
                                displayValue: product.title,
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                      itemCount: products.length,
                    );
                  case WishListFilterAutocompleteSharedByUsersLoaded(
                      :final users
                    ):
                    if (users.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            LocalizationConstants.noOptions.localized(),
                            style: OptiTextStyles.body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          tileColor: OptiAppColors.backgroundWhite,
                          title: Text(user.displayValue ?? ''),
                          onTap: () {
                            context.pop(user);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                      itemCount: users.length,
                    );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
