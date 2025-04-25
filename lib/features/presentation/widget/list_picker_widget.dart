import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/mixins/picker_mixin.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPickerWidget extends StatelessWidget {
  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;
  final int? selectedIndex;
  final String? descriptionText;
  final bool? showDropDown;
  final bool? isActionEnabled;

  const ListPickerWidget(
      {super.key,
      required this.items,
      this.selectedIndex,
      required this.callback,
      this.descriptionText,
      this.showDropDown,
      this.isActionEnabled = true});

  @override
  Widget build(BuildContext context) {
    return ListPicker(
        items: items,
        selectedIndex: selectedIndex,
        callback: callback,
        descriptionText: descriptionText,
        showDropDown: showDropDown,
        isActionEnabled: isActionEnabled);
  }
}

class ListPicker extends StatefulWidget {
  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;
  final int? selectedIndex;
  final String? descriptionText;
  final bool? showDropDown;
  final bool? isActionEnabled;
  const ListPicker(
      {super.key,
      required this.items,
      this.selectedIndex,
      required this.callback,
      this.descriptionText,
      this.showDropDown,
      this.isActionEnabled});

  @override
  _ListPickerState createState() => _ListPickerState();
}

class _ListPickerState extends State<ListPicker> with PickerMixin {
  late int selectedIndex;
  late bool isButtonEnabled;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex ?? 0;
    isButtonEnabled = (selectedIndex != -1 && widget.items.isNotEmpty)
        ? isOptionAvailable(widget.items[selectedIndex])
        : true;
  }

  @override
  Widget build(BuildContext context) {
    selectedIndex = widget.selectedIndex ?? 0;
    return GestureDetector(
      onTap: (widget.isActionEnabled ?? false)
          ? () {
              _selectItem(context);
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                (selectedIndex != -1 && widget.items.isNotEmpty)
                    ? getItemDescriptions(widget.items[selectedIndex])
                    : widget.descriptionText ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: OptiTextStyles
                    .body, // Assuming you have OptiTextStyles defined
              ),
            ),
            Icon(
              (widget.showDropDown == true)
                  ? Icons.keyboard_arrow_down
                  : Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _selectItem(BuildContext context) {
    if (!widget.isActionEnabled!) {
      return;
    }

    var scrollController =
        FixedExtentScrollController(initialItem: selectedIndex);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext innerContext) {
        return StatefulBuilder(
          builder: (BuildContext _, StateSetter setState) {
            return Container(
              height: 200,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        isButtonEnabled // Enable/disable button based on isButtonEnabled state
                            ? () {
                                Navigator.pop(innerContext);
                                if (widget.callback != null) {
                                  if (selectedIndex != -1 &&
                                      widget.items.isNotEmpty) {
                                    widget.callback!(
                                        context, widget.items[selectedIndex]);
                                  }
                                }
                              }
                            : null,
                    child: Text(LocalizationConstants.done.localized()),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: scrollController,
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          if (widget.items.isNotEmpty) {
                            selectedIndex = index;
                            isButtonEnabled =
                                isOptionAvailable(widget.items[index]);
                          }
                        });
                      },
                      children: widget.items.map((Object option) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              getItemDescriptions(option),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: OptiTextStyles.body,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
