import 'package:flutter/material.dart';

class TwoTextsRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle textStyle;

  const TwoTextsRow({
    super.key,
    required this.label,
    required this.value,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textStyle,
        ),
        Text(
          value,
          style: textStyle,
        ),
      ],
    );
  }
}
