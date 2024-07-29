import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LanguageItem extends StatelessWidget {

  final Language language;
  final bool isSelected;
  final void Function(BuildContext, Language)? onCallBack;

  const LanguageItem(
      {super.key,
      required this.isSelected,
      required this.language,
      this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCallBack?.call(context, language);
      },
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        language.description ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: OptiTextStyles.body.copyWith(
                            fontWeight: isSelected
                                ? OptiTextStyles.bodyHighlightWeight
                                : OptiTextStyles.bodyWeight),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 2),
            Visibility(
              visible: isSelected,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(7),
                child: const Icon(
                  Icons.radio_button_checked,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}