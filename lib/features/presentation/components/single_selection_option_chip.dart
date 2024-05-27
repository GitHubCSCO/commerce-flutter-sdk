import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:flutter/material.dart';

class SingleSelectionOptionChip<T> extends StatefulWidget {
  const SingleSelectionOptionChip({
    Key? key,
    required this.values,
    this.selectedValue,
    required this.onSelectionChanged,
    this.chipTitle,
  }) : super(key: key);

  final List<T> values;
  final T? selectedValue;
  final String? chipTitle;
  final void Function(T? selection) onSelectionChanged;

  @override
  _SingleSelectionOptionChipState<T> createState() =>
      _SingleSelectionOptionChipState<T>();
}

class _SingleSelectionOptionChipState<T>
    extends State<SingleSelectionOptionChip<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    List<T> itemsToShow = widget.values.skip(1).toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.chipTitle!,
            style: OptiTextStyles.body,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 2,
            children: itemsToShow
                .map(
                  (value) => ChoiceChip(
                    label: Text(
                      _getValueTitle(value),
                      style: selectedValue == value
                          ? OptiTextStyles.bodySmallHighlight
                              .copyWith(color: OptiAppColors.backgroundWhite)
                          : OptiTextStyles.bodySmallHighlight,
                    ),
                    selectedColor: OptiAppColors.textPrimary,
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    selected: selectedValue == value,
                    onSelected: (bool selected) {
                      if (!_getValueAvailibility(value)) {
                        return;
                      }
                      setState(() {
                        selectedValue = selected ? value : null;
                      });
                      widget.onSelectionChanged(selected ? value : null);
                    },
                    backgroundColor: (!_getValueAvailibility(value))
                        ? Colors.grey // Gray if not available
                        : OptiAppColors.backgroundWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: (!_getValueAvailibility(value))
                            ? Colors.grey // Gray if not available
                            : OptiAppColors.textPrimary,
                        width: 1,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  String _getValueTitle(T item) {
    if (item is StyleValueEntity) {
      return item.valueDisplay!;
    }
    return "";
  }

  bool _getValueAvailibility(T item) {
    if (item is StyleValueEntity) {
      return item.isAvailable ?? true;
    }
    return true;
  }
}
