import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ListPickerWidget extends StatelessWidget {
  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;
  final int? selectedIndex;
  final String? descriptionText;

  const ListPickerWidget({
    super.key,
    required this.items,
    this.selectedIndex,
    required this.callback,
    this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return ListPicker(
      items: items,
      selectedIndex: selectedIndex,
      callback: callback,
      descriptionText: descriptionText,
    );
  }
}

class ListPicker extends StatefulWidget {
  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;
  final int? selectedIndex;
  final String? descriptionText;

  const ListPicker({
    super.key,
    required this.items,
    this.selectedIndex,
    required this.callback,
    this.descriptionText,
  });

  @override
  _ListPickerState createState() => _ListPickerState();
}

class _ListPickerState extends State<ListPicker> {
  late int selectedIndex;
  late bool isButtonEnabled;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex ?? 0;

    isButtonEnabled = (selectedIndex != -1 && widget.items.isNotEmpty)
        ? _isOptionAvailable(widget.items[selectedIndex])
        : true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectItem(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                (selectedIndex != -1 && widget.items.isNotEmpty)
                    ? _getDescriptions(widget.items[selectedIndex!])
                    : widget.descriptionText ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: OptiTextStyles
                    .body, // Assuming you have OptiTextStyles defined
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _selectItem(BuildContext context) {
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
                    child: const Text("Done"),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedIndex = index;
                          isButtonEnabled =
                              _isOptionAvailable(widget.items[index]);
                        });
                      },
                      children: widget.items.map((Object option) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _getDescriptions(option),
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

  bool _isOptionAvailable(Object option) {
    // Assuming isAvailable is a property of the option object
    if (option is ProductDetailStyleValue) {
      return option.isAvailable!;
    } else {
      return true; // Return true by default if isAvailable property is not found
    }
  }

  String _getDescriptions(Object item) {
    if (item is CarrierDto) {
      return item.description!;
    } else if (item is ShipViaDto) {
      return item.description!;
    } else if (item is PaymentMethodDto) {
      if(item.description! != ""){
        return item.description!;
      }else {
        return item.name ?? "";
      }
    } else if (item is ConfigSectionOptionEntity) {
      return item.description!;
    } else if (item is ProductDetailStyleValue) {
      return item.displayName!;
    } else if (item is String) {
      return item;
    } else if (item is KeyValuePair) {
      return item.key.toString();
    } else if (item is Country) {
      return item.name ?? "";
    } else if (item is StateModel) {
      return item.name ?? "";
    } else {
      return '';
    }
  }
}
