import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/extra/delayer.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';

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
class WishListFilterAutocompleteScreen extends StatefulWidget {
  final WishListFilterAutocompleteType type;

  const WishListFilterAutocompleteScreen({
    super.key,
    required this.type,
  });

  @override
  State<WishListFilterAutocompleteScreen> createState() =>
      _WishListFilterAutocompleteScreenState();
}

class _WishListFilterAutocompleteScreenState
    extends State<WishListFilterAutocompleteScreen> {
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
      // unawaited(
      //   context.read<WishListCubit>().searchQueryChanged(query),
      // );
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
                    searchQueryChanged('');
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
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
