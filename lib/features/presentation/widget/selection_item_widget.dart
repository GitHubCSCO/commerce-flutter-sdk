import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';

class SelectionItemWidget extends StatelessWidget {
  final Object item;
  final String? label;
  final bool isSelected;
  final void Function(BuildContext context, Object item)? onCallBack;

  const SelectionItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    this.label,
    this.onCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onCallBack != null) {
          onCallBack!(context, item);
        }
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
                        label ?? '',
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
                  color: Colors.black,
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
