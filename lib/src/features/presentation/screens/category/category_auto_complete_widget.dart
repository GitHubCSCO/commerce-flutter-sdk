import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryAutoCompleteWidget extends StatelessWidget {
  final Function(BuildContext, AutocompleteCategory) callback;
  final List<AutocompleteCategory>? autocompleteCategories;

  const CategoryAutoCompleteWidget(
      {super.key,
      required this.callback,
      required this.autocompleteCategories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Color(0xFFF5F5F5),
      ),
      itemCount: autocompleteCategories?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final autoCompleteCategory = autocompleteCategories![index];
        return InkWell(
          onTap: () {
            callback(context, autoCompleteCategory);
          },
          child: AutoCompleteCategoryWidget(
              autoCompleteCategory: autoCompleteCategory),
        );
      },
    );
  }
}

class AutoCompleteCategoryWidget extends StatelessWidget {
  final AutocompleteCategory autoCompleteCategory;

  const AutoCompleteCategoryWidget(
      {super.key, required this.autoCompleteCategory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Text(
        _getCategoryTitle(autoCompleteCategory),
        style: OptiTextStyles.body,
      ),
    );
  }

  String _getCategoryTitle(AutocompleteCategory autoCompleteCategory) {
    final title = autoCompleteCategory.title ?? '';
    final subTitle = autoCompleteCategory.subtitle ?? '';
    if (title.isNotEmpty && subTitle.isNotEmpty) {
      return LocalizationConstants.autocompleteCategoryOrBrandCombinedTitle
          .localized()
          .format([title, subTitle]);
    } else {
      return title;
    }
  }
}
