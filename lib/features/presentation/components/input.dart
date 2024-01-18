import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? hintText;
  final String? label;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;

  const Input({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.keyboardType,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.style,
    this.textDirection,
    this.textInputAction,
    this.label,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
      debugPrint('has focus: ${_focusNode.hasFocus}');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius),
        boxShadow: _focusNode.hasFocus
            ? const [
                BoxShadow(
                  color: AppStyle.inputDropShadowColor,
                  spreadRadius: 3,
                ),
              ]
            : null,
      ),
      child: TextField(
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        style: widget.style,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        textInputAction: widget.textInputAction,
        focusNode: _focusNode,
        cursorHeight: AppStyle.cursorHeight,
        cursorColor: AppStyle.neutral990,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppStyle.borderRadius,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppStyle.borderRadius,
            ),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppStyle.borderRadius,
            ),
            borderSide: const BorderSide(
              color: AppStyle.primary500,
              strokeAlign: 10,
            ),
          ),
          filled: true,
          fillColor:
              _focusNode.hasFocus ? AppStyle.neutral00 : AppStyle.neutral100,
        ),
      ),
    );
  }
}
