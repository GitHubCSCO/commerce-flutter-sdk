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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textStyle,
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Text(
            value,
            style: textStyle,
            maxLines: maxLines,
            overflow: (maxLines != null) ? TextOverflow.ellipsis : null,
          ),
        ),
      ],
    );
  }
}
