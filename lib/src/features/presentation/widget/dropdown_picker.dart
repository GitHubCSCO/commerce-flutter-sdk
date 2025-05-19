import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/mixins/picker_mixin.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:flutter/material.dart';

class DropdownPickerWidget extends StatelessWidget with PickerMixin {
  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;
  final int? selectedIndex;
  final String? descriptionText;
  final bool? isActionEnabled;

  const DropdownPickerWidget({
    super.key,
    required this.items,
    this.selectedIndex,
    required this.callback,
    this.descriptionText,
    this.isActionEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownPicker(
      items: items,
      selectedIndex: selectedIndex,
      callback: callback,
      descriptionText: descriptionText,
      isActionEnabled: isActionEnabled,
    );
  }
}

class DropdownPicker extends StatefulWidget {
  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;
  final int? selectedIndex;
  final String? descriptionText;
  final bool? isActionEnabled;

  const DropdownPicker({
    super.key,
    required this.items,
    this.selectedIndex,
    required this.callback,
    this.descriptionText,
    this.isActionEnabled,
  });

  @override
  State<DropdownPicker> createState() => _DropdownPickerState();
}

class _DropdownPickerState extends State<DropdownPicker> with PickerMixin {
  late int selectedIndex;
  bool _isDropdownOpen = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex ?? 0;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedIndex = widget.selectedIndex ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppStyle.inputDropShadowSpreadRadius,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppStyle.borderRadius),
        boxShadow: _isDropdownOpen
            ? [
                BoxShadow(
                  color: OptiAppColors.primaryColor.withValues(alpha: 0.3),
                  spreadRadius: AppStyle.inputDropShadowSpreadRadius,
                ),
              ]
            : null,
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppStyle.borderRadius),
              color: _isDropdownOpen ? Colors.white : AppStyle.neutral100,
              border: _isDropdownOpen
                  ? Border.all(color: OptiAppColors.primaryColor)
                  : null,
            ),
            child: DropdownButton<int>(
              isExpanded: true,
              value: selectedIndex,
              focusNode: _focusNode,
              icon: AnimatedRotation(
                turns: _isDropdownOpen ? 0.25 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
              elevation: 8,
              style: OptiTextStyles.body,
              dropdownColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              onTap: () {
                setState(() {
                  _isDropdownOpen = !_isDropdownOpen;
                });
              },
              onChanged: (widget.isActionEnabled == true)
                  ? (int? newValue) {
                      setState(() {
                        selectedIndex = newValue!;
                        _isDropdownOpen = false;
                      });
                      if (widget.callback != null && widget.items.isNotEmpty) {
                        widget.callback!(context, widget.items[selectedIndex]);
                      }
                    }
                  : null,
              items: List.generate(widget.items.length, (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  enabled: isOptionAvailable(widget.items[index]),
                  child: (index > 0 && widget.items.isNotEmpty)
                      ? getItemDescriptionWithAvatar(widget.items[index])
                      : Text(
                          getItemDescriptions(widget.items[index]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: OptiTextStyles.body,
                        ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
