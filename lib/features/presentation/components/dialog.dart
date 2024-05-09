import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

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
        title: title != null
            ? Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
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

void displayInputDialog({
  required BuildContext context,
  required String title,
  String? hintText,
  required void Function(String) onSubmit,
  bool obscureText = false,
  String confirmText = LocalizationConstants.oK,
  String existingValue = '',
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _InputDialog(
        title: title,
        hintText: hintText,
        onSubmit: onSubmit,
        obscureText: obscureText,
        confirmText: confirmText,
        existingValue: existingValue,
      );
    },
  );
}

class _InputDialog extends StatefulWidget {
  const _InputDialog({
    required this.title,
    required this.hintText,
    required this.onSubmit,
    required this.obscureText,
    required this.confirmText,
    this.existingValue = '',
  });

  final String title;
  final String? hintText;
  final bool obscureText;
  final String confirmText;
  final String existingValue;
  final void Function(String) onSubmit;

  @override
  State<_InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<_InputDialog> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.existingValue.isNullOrEmpty ? null : widget.existingValue,
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        obscureText: widget.obscureText,
        onSubmitted: (text) => context.closeKeyboard(),
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(LocalizationConstants.cancel),
        ),
        TextButton(
          onPressed: () {
            widget.onSubmit(_textEditingController.text);
            Navigator.of(context).pop();
          },
          child: Text(widget.confirmText),
        )
      ],
    );
  }
}
