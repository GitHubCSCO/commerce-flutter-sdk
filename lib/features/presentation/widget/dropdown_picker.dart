import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/core/extensions/product_unit_of_measure_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DropdownPickerWidget extends StatelessWidget {
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
  _DropdownPickerState createState() => _DropdownPickerState();
}

class _DropdownPickerState extends State<DropdownPicker> {
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

    return Focus(
      focusNode: _focusNode,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppStyle.inputDropShadowSpreadRadius,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppStyle.borderRadius),
          boxShadow: _isDropdownOpen
              ? [
                  BoxShadow(
                    color: OptiAppColors.primaryColor.withOpacity(0.3),
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
                    if (_isDropdownOpen) {
                      _focusNode.requestFocus();
                    }
                  });
                },
                onChanged: (widget.isActionEnabled == true)
                    ? (int? newValue) {
                        setState(() {
                          selectedIndex = newValue!;
                          _isDropdownOpen = false;
                        });
                        if (widget.callback != null &&
                            widget.items.isNotEmpty) {
                          widget.callback!(
                              context, widget.items[selectedIndex]);
                        }
                      }
                    : null,
                items: List.generate(widget.items.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    enabled: _isOptionAvailable(widget.items[index]),
                    child: (index > 0 && widget.items.isNotEmpty)
                        ? _getDescriptionWidget(widget.items[index])
                        : Text(
                            _getDescriptions(widget.items[index]),
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
      ),
    );
  }

  bool _isOptionAvailable(Object option) {
    if (option is ProductDetailStyleValue) {
      return option.isAvailable!;
    } else {
      return true;
    }
  }

  bool _getValueAvailability(Object item) {
    if (item is StyleValueEntity) {
      return item.isAvailable ?? true;
    }
    return true;
  }

  Widget _getAvatar(Object item) {
    if (item is StyleValueEntity) {
      if (!_getValueAvailability(item)) {
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      } else if (item.swatchImageValue != null &&
          item.swatchImageValue!.isNotEmpty) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            item.swatchImageValue!,
            fit: BoxFit.cover,
            width: 20,
            height: 20,
          ),
        );
      } else if (item.swatchColorValue != null &&
          item.swatchColorValue!.isNotEmpty) {
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Color(int.parse("FF${item.swatchColorValue!}", radix: 16)),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }
    }

    return const SizedBox.shrink();
  }

  Widget _getDescriptionWidget(Object item) {
    if (item is ProductDetailStyleValue) {
      return Row(
        children: [
          _getAvatar(item.styleValue ?? ''),
          const SizedBox(width: 16),
          Text(
            item.displayName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: OptiTextStyles.body,
          ),
        ],
      );
    }

    return Text(
      _getDescriptions(item),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: OptiTextStyles.body,
    );
  }

  String _getDescriptions(Object item) {
    if (item is CarrierDto) {
      return item.description!;
    } else if (item is ShipViaDto) {
      return item.description!;
    } else if (item is PaymentMethodDto) {
      if (item.description! != "") {
        return item.description!;
      } else {
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
    } else if (item is CalculationMethod) {
      return item.displayName ?? item.name ?? item.value ?? "";
    } else if (item is ProductUnitOfMeasureEntity) {
      return item.getUnitOfMeasureTextDisplayWithQuantity();
    } else {
      return '';
    }
  }
}
