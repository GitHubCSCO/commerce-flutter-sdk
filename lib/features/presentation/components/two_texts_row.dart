import 'package:flutter/material.dart';

class TwoTextsRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle textStyle;
  final int? maxLines;

  const TwoTextsRow({
    super.key,
    required this.label,
    required this.value,
    required this.textStyle,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: textStyle,
            maxLines: maxLines,
            overflow: (maxLines != null) ? TextOverflow.ellipsis : null,
          ),
        ),
        const SizedBox.shrink(),
        Text(
          value,
          style: textStyle,
        ),
      ],
    );
  }
}
