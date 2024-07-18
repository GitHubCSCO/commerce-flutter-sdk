import 'dart:math';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:flutter/material.dart';

class MultipleSelectionOptionChip<T> extends StatefulWidget {
  const MultipleSelectionOptionChip({
    super.key,
    required this.values,
    required this.selectedValues,
    required this.onSelectionChanged,
    this.chipTitle,
  });

  static const maxItemsToShow = 8;

  final List<T> values;
  final Set<T> selectedValues;
  final String? chipTitle;
  final void Function(T? selection) onSelectionChanged;

  bool get overFlow => values.length > maxItemsToShow;

  @override
  State<MultipleSelectionOptionChip<T>> createState() =>
      _MultipleSelectionOptionChipState<T>();
}

class _MultipleSelectionOptionChipState<T>
    extends State<MultipleSelectionOptionChip<T>> {
  bool showAll = true;

  @override
  void initState() {
    super.initState();
    showAll = widget.overFlow ? false : true;

    for (var value in widget.selectedValues) {
      if (widget.values.indexOf(value) >=
          MultipleSelectionOptionChip.maxItemsToShow) {
        showAll = true;

        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<T> itemsToShow = _getItemsToShow(widget.values);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.chipTitle ?? '',
            style: OptiTextStyles.body,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 2,
            children: [
              ...itemsToShow
                  .map(
                    (value) => ChoiceChip(
                      label: Text(
                        _getValueTitle(value),
                        style: widget.selectedValues.contains(value)
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
                      selected: widget.selectedValues.contains(value),
                      onSelected: (bool selected) {
                        if (!_getValueAvailibility(value)) {
                          return;
                        }
                        widget.onSelectionChanged(value);
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
                  .toList()
                  .sublist(
                    0,
                    showAll
                        ? itemsToShow.length
                        : min(MultipleSelectionOptionChip.maxItemsToShow,
                            itemsToShow.length),
                  ),
              widget.overFlow
                  ? (showAll
                      ? PlainButton(
                          onPressed: () {
                            setState(() {
                              showAll = false;
                            });
                          },
                          style: OptiTextStyles.bodySmallHighlight.copyWith(
                            color: OptiAppColors.primaryColor,
                          ),
                          text: 'See less',
                        )
                      : PlainButton(
                          onPressed: () {
                            setState(() {
                              showAll = true;
                            });
                          },
                          style: OptiTextStyles.bodySmallHighlight.copyWith(
                            color: OptiAppColors.primaryColor,
                          ),
                          text: 'See more',
                        ))
                  : const SizedBox.shrink(),
            ],
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
