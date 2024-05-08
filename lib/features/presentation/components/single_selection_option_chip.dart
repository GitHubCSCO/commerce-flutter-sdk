import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
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
            children: widget.values
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
                      setState(() {
                        selectedValue = selected ? value : null;
                      });
                      widget.onSelectionChanged(selected ? value : null);
                    },
                    backgroundColor: OptiAppColors.backgroundWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(
                        color: OptiAppColors.textPrimary,
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
    if (item is ProductDetailStyleValue) {
      return item.displayName!;
    }
    return "";
  }
}
