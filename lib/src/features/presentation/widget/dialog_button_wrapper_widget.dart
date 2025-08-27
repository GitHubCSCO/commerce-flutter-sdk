import 'package:flutter/material.dart';

class DialogButtonWrapper extends StatelessWidget {
  const DialogButtonWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: IntrinsicWidth(
        child: child,
      ),
    );
  }
}
