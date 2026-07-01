import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class ContentAutoCompleteWidget extends StatelessWidget {
  final Function(BuildContext, AutocompleteContent) callback;
  final List<AutocompleteContent>? autocompleteContentList;

  const ContentAutoCompleteWidget({
    super.key,
    required this.callback,
    required this.autocompleteContentList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: context.colors.grayBackgroundColor,
      ),
      itemCount: autocompleteContentList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final autoCompleteContent = autocompleteContentList![index];
        return InkWell(
          onTap: () {
            callback(context, autoCompleteContent);
          },
          child: AutoCompleteContentItemWidget(
              autoCompleteContent: autoCompleteContent),
        );
      },
    );
  }
}

class AutoCompleteContentItemWidget extends StatelessWidget {
  final AutocompleteContent autoCompleteContent;

  const AutoCompleteContentItemWidget(
      {super.key, required this.autoCompleteContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Text(
        autoCompleteContent.title ?? '',
        style: context.text.body,
      ),
    );
  }
}
