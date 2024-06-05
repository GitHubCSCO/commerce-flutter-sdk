import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:flutter/material.dart';

class MultipleSelectionOptionChip<T> extends StatelessWidget {
  const MultipleSelectionOptionChip({
    super.key,
    required this.values,
    required this.selectedValues,
    required this.onSelectionChanged,
    this.chipTitle,
  });

  final List<T> values;
  final Set<T> selectedValues;
  final String? chipTitle;
  final void Function(T? selection) onSelectionChanged;

  // late Set<T> selectedValues;
  @override
  Widget build(BuildContext context) {
    List<T> itemsToShow = _getItemsToShow(values);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chipTitle ?? '',
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
                      style: selectedValues.contains(value)
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
                    selected: selectedValues.contains(value),
                    onSelected: (bool selected) {
                      if (!_getValueAvailibility(value)) {
                        return;
                      }
                      // setState(
                      //   () {
                      //     selectedValues.contains(value)
                      //         ? selectedValues.remove(value)
                      //         : selectedValues.add(value);
                      //   },
                      // );
                      onSelectionChanged(value);
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
    } else if (item is FilterValueViewModel) {
      return item.title;
    }
    return "";
  }

  bool _getValueAvailibility(T item) {
    if (item is StyleValueEntity) {
      return item.isAvailable ?? true;
    }
    return true;
  }

  List<T> _getItemsToShow(List<T> items) {
    if (T is StyleValueEntity) {
      items.skip(1).toList();
    }
    return items;
  }
}
