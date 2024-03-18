import 'package:flutter/material.dart';

class DialogHighlightButton extends StatelessWidget {
  const DialogHighlightButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  final void Function() onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: style ??
          ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color.fromRGBO(0, 55, 255, 1)),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            alignment: Alignment.center,
          ),
      child: child,
    );
  }
}

class DialogPlainButton extends StatelessWidget {
  const DialogPlainButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  final void Function() onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style ??
          ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16),
            ),
            foregroundColor: const MaterialStatePropertyAll(Colors.black),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            alignment: Alignment.center,
          ),
      child: child,
    );
  }
}

void displayDialogWidget({
  required BuildContext context,
  String? title,
  String? message,
  Widget? content,
  Widget? icon,
  EdgeInsetsGeometry? iconPadding,
  Color? iconColor,
  Color? backgroundColor,
  Color? shadowColor,
  ShapeBorder? shape,
  bool barrierDismissible = true,
  double? elevation,
  List<Widget>? actions,
}) {
  showDialog(
    context: context,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message ?? ''),
            content ?? const SizedBox.shrink(),
          ],
        ),
        actions: actions,
        icon: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  icon,
                ],
              )
            : null,
        iconColor: iconColor,
        iconPadding: iconPadding,
        backgroundColor: backgroundColor ?? Colors.white,
        shadowColor: shadowColor,
        shape: shape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
        elevation: elevation,
      );
    },
  );
}
