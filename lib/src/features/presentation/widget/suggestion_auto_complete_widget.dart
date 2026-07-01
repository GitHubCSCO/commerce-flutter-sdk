import 'package:flutter/material.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class SuggestionAutoCompleteWidget extends StatelessWidget {
  final Function(BuildContext, String) callback;
  final List<String>? suggestions;

  const SuggestionAutoCompleteWidget({
    super.key,
    required this.callback,
    required this.suggestions,
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
      itemCount: suggestions?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final suggestion = suggestions![index];
        return InkWell(
          onTap: () {
            callback(context, suggestion);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Text(
              suggestion,
              style: context.text.body,
            ),
          ),
        );
      },
    );
  }
}
