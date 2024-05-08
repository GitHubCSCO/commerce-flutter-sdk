import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:flutter/material.dart';

enum ChipOrientation { vertical, horizontal }

class SingleSelectionSwatchChip<T> extends StatefulWidget {
  const SingleSelectionSwatchChip({
    Key? key,
    required this.values,
    this.selectedValue,
    required this.onSelectionChanged,
    this.chipTitle,
    required this.maxItemsToShow,
    this.orientation = ChipOrientation.horizontal,
  }) : super(key: key);

  final List<T> values;
  final T? selectedValue;
  final void Function(T? selection) onSelectionChanged;
  final String? chipTitle;
  final int maxItemsToShow;
  final ChipOrientation orientation;
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
    if (item is ProductDetailStyleValue) {
      if (item.styleValue?.swatchImageValue != null &&
          item.styleValue!.swatchImageValue!.isNotEmpty) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.styleValue!.swatchImageValue!,
            fit: BoxFit.cover,
            width: 40,
            height: 40,
          ),
        );
      } else if (item.styleValue?.swatchColorValue != null &&
          item.styleValue!.swatchColorValue!.isNotEmpty) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(int.parse("FF" + item.styleValue!.swatchColorValue!,
                radix: 16)),
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
    if (item is ProductDetailStyleValue) {
      return item.styleValue?.value ?? "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    // removeing first item from the list as it is the dummy value
    List<T> itemsToShow = showAll
        ? widget.values.skip(1).toList()
        : widget.values.take(maxItemsToShow).skip(1).toList();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chipTitle != null)
            Padding(
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
          Wrap(
            spacing: 20,
            runSpacing: 8,
            children: itemsToShow.map((value) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedValue = value;
                    widget.onSelectionChanged(selectedValue);
                  });
                },
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

  List<Widget> _buildChildren(T value) {
    return [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: selectedValue == value ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedValue == value ? Colors.black : Colors.white,
            width: 2,
          ),
        ),
        child: Center(child: _getAvatar(value)),
      ),
      widget.orientation == ChipOrientation.vertical
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child:
                  Text(_getValueTitle(value), style: OptiTextStyles.bodySmall),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child:
                  Text(_getValueTitle(value), style: OptiTextStyles.bodySmall),
            ),
    ];
  }
}
