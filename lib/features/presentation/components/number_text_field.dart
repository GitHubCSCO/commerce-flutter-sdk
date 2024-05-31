import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int min;
  final int max;
  final int step;
  final double arrowsWidth;
  final double arrowsHeight;
  final EdgeInsets contentPadding;
  final double borderWidth;
  final ValueChanged<int?>? onChanged;
  final String? initialtText;
  final bool shouldShowIncrementDecermentIcon;
  final void Function(bool hasFocus)? focusListener;

  const NumberTextField({
    Key? key,
    this.initialtText,
    this.shouldShowIncrementDecermentIcon = false,
    this.controller,
    this.focusNode,
    this.min = 1,
    this.max = 100000,
    this.step = 1,
    this.arrowsWidth = 24,
    this.arrowsHeight = kMinInteractiveDimension,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.borderWidth = 2,
    this.onChanged,
    this.focusListener,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _canGoUp = false;
  bool _canGoDown = false;
  bool _shouldShowIncrementDecermentIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.text = widget.initialtText!;
    _shouldShowIncrementDecermentIcon =
        widget.shouldShowIncrementDecermentIcon!;
    _updateArrows(int.tryParse(_controller.text));

    if (widget.focusListener != null) {
      _focusNode.addListener(() {
        widget.focusListener!(_focusNode.hasFocus);
      });
    }
  }

  @override
  void didUpdateWidget(covariant NumberTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller = widget.controller ?? _controller;
    _focusNode = widget.focusNode ?? _focusNode;
    _updateArrows(int.tryParse(_controller.text));
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // Minus button
          if (_shouldShowIncrementDecermentIcon)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_canGoDown) {
                      _update(false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OptiAppColors.backgroundGray,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
          // TextField
          Expanded(
            child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLength: widget.max.toString().length +
                    (widget.min.isNegative ? 1 : 0),
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppStyle.textFieldDefaultHorizontalPadding,
                    vertical: AppStyle.defaultVerticalPadding,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppStyle.textFieldborderRadius,
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppStyle.textFieldborderRadius,
                    ),
                    borderSide: const BorderSide(
                      color: AppStyle.neutral500,
                    ),
                  ),
                  filled: true,
                  fillColor: _focusNode.hasFocus
                      ? AppStyle.neutral00
                      : AppStyle.neutral100,
                ),
                maxLines: 1,
                onTapOutside: (p0) => context.closeKeyboard(),
                onSubmitted: (value) {
                  _focusNode.unfocus();
                },
                onChanged: (value) {
                  final intValue = int.tryParse(value);
                  widget.onChanged?.call(intValue);
                  _updateArrows(intValue);
                },
                inputFormatters: [
                  _NumberTextInputFormatter(widget.min, widget.max)
                ]),
          ),
          // Plus button
          if (_shouldShowIncrementDecermentIcon)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_canGoUp) {
                      _update(true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OptiAppColors.backgroundGray,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            )
        ],
      );

  void _update(bool up) {
    var intValue = int.tryParse(_controller.text);
    intValue == null
        ? intValue = 1
        : intValue += up ? widget.step : -widget.step;
    _controller.text = intValue.toString();
    widget.onChanged?.call(intValue); // Fire onChanged event
    _updateArrows(intValue);
    _focusNode.requestFocus();
  }

  void _updateArrows(int? value) {
    final canGoUp = value == null || value < widget.max;
    final canGoDown = value == null || value > widget.min;
    if (_canGoUp != canGoUp || _canGoDown != canGoDown)
      setState(() {
        _canGoUp = canGoUp;
        _canGoDown = canGoDown;
      });
  }
}

class _NumberTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  _NumberTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (const ['-', ''].contains(newValue.text)) return newValue;
    final intValue = int.tryParse(newValue.text);
    if (intValue == null) return oldValue;
    if (intValue < min) return newValue.copyWith(text: min.toString());
    if (intValue > max) return newValue.copyWith(text: max.toString());
    return newValue.copyWith(text: intValue.toString());
  }
}
