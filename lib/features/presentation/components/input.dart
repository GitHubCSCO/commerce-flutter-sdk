import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
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
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final void Function(bool hasFocus)? focusListener;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator; // Added validator parameter
  final bool? isRequired;
  final int? maxLength;

  const Input(
      {super.key,
      this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.controller,
      this.keyboardType,
      this.onEditingComplete,
      this.onTap,
      this.onTapOutside,
      this.textDirection,
      this.textInputAction,
      this.label,
      this.obscureText = false,
      this.textAlign = TextAlign.start,
      this.focusListener,
      this.suffixIcon,
      this.validator,
    this.maxLength,
      this.isRequired = false});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  String? _errorText; // State to hold the error text

  void _setState() {
    setState(() {});
  }

  void _resetScroll() {
    if (!_focusNode.hasFocus) {
      _scrollController.jumpTo(0);
      setState(() {});
    }
  }

  void requestFocus() {
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_setState);

    _scrollController = ScrollController();
    _focusNode.addListener(_resetScroll);

    if (widget.focusListener != null) {
      _focusNode.addListener(() {
        widget.focusListener!(_focusNode.hasFocus);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_setState);
    _focusNode.removeListener(_resetScroll);
    _focusNode.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _handleChange(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  String? _validate(String? value) {
    if (widget.validator != null) {
      final error = widget.validator!(value);
      setState(() {
        _errorText = error;
      });
      return error;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: _validate,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      widget.label!,
                      style: OptiTextStyles.body,
                    ),
                    const SizedBox(width: 4.0), // Space between text and star
                    Visibility(
                        visible: widget.isRequired!,
                        child: const Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red, // Change the color if needed
                          ),
                        )),
                  ],
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppStyle.inputDropShadowSpreadRadius,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppStyle.borderRadius),
                boxShadow: (_focusNode.hasFocus && widget.maxLength == null)
                    ? [
                        BoxShadow(
                          color: OptiAppColors.primaryColor.withOpacity(0.3),
                          spreadRadius: AppStyle.inputDropShadowSpreadRadius,
                        ),
                      ]
                    : null,
              ),
              child: TextField(
                scrollController: _scrollController,
                onChanged: (value) {
                  _handleChange(value);
                  state.didChange(value); // Notify the form field of the change
                },
                maxLength: widget.maxLength,
                onSubmitted: widget.onSubmitted,
                controller: widget.controller,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                onEditingComplete: widget.onEditingComplete,
                onTap: widget.onTap,
                onTapOutside: widget.onTapOutside,
                style: OptiTextStyles.body,
                textAlign: widget.textAlign,
                textDirection: widget.textDirection,
                textInputAction: widget.textInputAction,
                focusNode: _focusNode,
                cursorColor: AppStyle.neutral990,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: OptiTextStyles.body.copyWith(
                    color: AppStyle.neutral500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppStyle.defaultHorizontalPadding,
                    vertical: AppStyle.defaultVerticalPadding,
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
                    borderSide: BorderSide(
                      color: OptiAppColors.primaryColor,
                    ),
                  ),
                  filled: true,
                  fillColor: _focusNode.hasFocus
                      ? AppStyle.neutral00
                      : AppStyle.neutral100,
                  suffixIcon: _focusNode.hasFocus ? widget.suffixIcon : null,
                ),
              ),
            ),
            if (_errorText != null && _errorText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  _errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
