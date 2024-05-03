import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        title: const Text(LocalizationConstants.quickOrder),
        actions: <Widget>[
          IconButton(
              onPressed: () {

              },
              icon: const Icon(
                Icons.flash_off,
                color: Colors.black,
              )
          ),
          BottomMenuWidget(websitePath: 'websitePath')
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.black,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Input(
              hintText: LocalizationConstants.search,
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  // textEditingController.clear();
                  // context.read<SearchBloc>().add(SearchTypingEvent(''));
                  // context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              focusListener: (bool hasFocus) {
                // if (hasFocus) {
                //   context.read<SearchBloc>().add(SearchFocusEvent());
                // } else {
                //   context.read<SearchBloc>().add(SearchUnFocusEvent());
                // }
              },
              onChanged: (String searchQuery) {
                // context.read<SearchBloc>().add(SearchTypingEvent(searchQuery));
              },
              onSubmitted: (String query) {
                // context.read<SearchBloc>().add(SearchSearchEvent());
              },
              // controller: textEditingController,
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              LocalizationConstants.quickOrderContents,
                              textAlign: TextAlign.start,
                              style: OptiTextStyles.titleSmall,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {  },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                LocalizationConstants.clear,
                                style: OptiTextStyles.bodyFade,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'To add an item to your quick order form, search by keyword or item # then click on the item',
                      style: OptiTextStyles.body,
                    )
                  ],
                ),
              )
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 32, vertical: 16),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          LocalizationConstants.listTotal,
                          textAlign: TextAlign.start,
                          style: OptiTextStyles.subtitle,
                        ),
                      ),
                    ),
                    Text(
                      '\$0.00',
                      textAlign: TextAlign.start,
                      style: OptiTextStyles.subtitle,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  onPressed: () {

                  },
                  text: LocalizationConstants.addToCartAndCheckout,
                ),
                const SizedBox(height: 4),
                PrimaryButton(
                  onPressed: () {

                  },
                  text: LocalizationConstants.tapToScan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}