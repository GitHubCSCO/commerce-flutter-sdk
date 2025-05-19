import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:flutter/material.dart';

enum ChipOrientation { vertical, horizontal }

class SingleSelectionSwatchChip<T> extends StatefulWidget {
  SingleSelectionSwatchChip({
    super.key,
    required this.values,
    this.selectedValue,
    required this.onSelectionChanged,
    this.chipTitle,
    required this.maxItemsToShow,
    this.isSelectionEnabled = true,
    this.orientation = ChipOrientation.horizontal,
    this.shouldIgnoreTitleAndLabelName = false,
  });

  final List<T> values;
  final T? selectedValue;
  final void Function(T? selection) onSelectionChanged;
  final String? chipTitle;
  final int maxItemsToShow;
  final ChipOrientation orientation;
  bool? isSelectionEnabled;
  bool? shouldIgnoreTitleAndLabelName;
  @override
  _SingleSelectionSwatchChipState<T> createState() =>
      _SingleSelectionSwatchChipState<T>();
}

class _SingleSelectionSwatchChipState<T>
    extends State<SingleSelectionSwatchChip<T>> {
  late T? selectedValue;
  late String? chipTitle;
  late int maxItemsToShow;
  bool showAll = false;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    chipTitle = widget.chipTitle;
    maxItemsToShow = widget.maxItemsToShow;
  }

  Widget _getAvatar(T item) {
    if (item is StyleValueEntity) {
      if (!_getValueAvailibility(item)) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      } else if (item.swatchImageValue != null &&
          item.swatchImageValue!.isNotEmpty) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.swatchImageValue!,
            fit: BoxFit.cover,
            width: 40,
            height: 40,
          ),
        );
      } else if (item.swatchColorValue != null &&
          item.swatchColorValue!.isNotEmpty) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(int.parse("FF" + item.swatchColorValue!, radix: 16)),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }
    }

    return Image.network(
      '',
      fit: BoxFit.cover,
      width: 32,
      height: 32,
    );
  }

  String _getValueTitle(T item) {
    if (item is StyleValueEntity) {
      return item.value ?? "";
    }
    return "";
  }

  bool _getValueAvailibility(T item) {
    if (item is StyleValueEntity) {
      return item.isAvailable ?? true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // removing first item from the list as it is the dummy value
    List<T> itemsToShow = showAll
        ? widget.values.skip(1).toList()
        : widget.values.skip(1).take(maxItemsToShow).toList();

    return Padding(
      padding: EdgeInsets.all(getPaddingSize()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chipTitle != null)
            Visibility(
              visible: !widget.shouldIgnoreTitleAndLabelName!,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      chipTitle!,
                      style: OptiTextStyles.body,
                    ),
                    if (widget.values.length > maxItemsToShow)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showAll = !showAll;
                          });
                        },
                        child: Text(showAll ? 'View Less' : 'View More'),
                      ),
                  ],
                ),
              ),
            ),
          Wrap(
            spacing: 20,
            runSpacing: 8,
            children: itemsToShow.map((value) {
              bool isAvailable = _getValueAvailibility(value);
              return InkWell(
                onTap: isAvailable
                    ? () {
                        setState(() {
                          if (widget.isSelectionEnabled!) {
                            selectedValue = value;
                            widget.onSelectionChanged(selectedValue);
                          }
                        });
                      }
                    : null, // If not available, onTap is null (disabling onTap)
                child: widget.orientation == ChipOrientation.horizontal
                    ? Column(
                        children: _buildChildren(value),
                      )
                    : Row(
                        children: _buildChildren(value),
                      ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double getPaddingSize() {
    if (widget.shouldIgnoreTitleAndLabelName!) {
      return 2;
    }

    return 20;
  }

  double getGridSize() {
    if (widget.shouldIgnoreTitleAndLabelName!) {
      return 30;
    }

    return 40;
  }

  List<Widget> _buildChildren(T value) {
    bool isAvailable = _getValueAvailibility(value);
    return [
      Container(
        width: getGridSize(),
        height: getGridSize(),
        decoration: BoxDecoration(
          color: selectedValue == value
              ? Colors.black
              : (isAvailable
                  ? Colors.white
                  : Colors.grey), // Change color to gray if not available
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedValue == value
                ? Colors.black
                : (isAvailable
                    ? Colors.white
                    : Colors
                        .grey), // Change border color to black if selected, otherwise to gray if not available
            width: 2,
          ),
        ),
        child: Center(child: _getAvatar(value)),
      ),
      Visibility(
        visible: !widget.shouldIgnoreTitleAndLabelName!,
        child: widget.orientation == ChipOrientation.vertical
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(_getValueTitle(value),
                    style: OptiTextStyles.bodySmall),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(_getValueTitle(value),
                    style: OptiTextStyles.bodySmall),
              ),
      ),
    ];
  }
}
