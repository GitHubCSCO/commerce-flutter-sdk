import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/single_selection_option_chip.dart';
import 'package:commerce_flutter_app/features/presentation/components/single_selection_swatch_chip.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum StyleTraitType {
  swatchDropdown,
  dropdown,
  button,
  swatchList,
  swatchGrid,
  unknown
}

StyleTraitType styleTraitTypeFromString(String displayType) {
  switch (displayType) {
    case 'SwatchDropdown':
      return StyleTraitType.swatchDropdown;
    case 'Dropdown':
      return StyleTraitType.dropdown;
    case 'Button':
      return StyleTraitType.button;
    case 'SwatchList':
      return StyleTraitType.swatchList;
    case 'SwatchGrid':
      return StyleTraitType.swatchGrid;
    default:
      return StyleTraitType.unknown;
  }
}

Widget buildStyleTraitSelectorWidget(
    String? displayType,
    ProductDetailStyleTrait styleTrait,
    BuildContext context,
    String? title,
    Map<String, StyleValueEntity?>? selectedStyleValues,
    {required void Function(BuildContext context, Object item)
        onSelectItemCallback}) {
  switch (styleTraitTypeFromString(displayType!)) {
    case StyleTraitType.swatchDropdown:
      return _buildStyleTraitDropdownWidget(
          styleTrait.styleValues, title, onSelectItemCallback);
    case StyleTraitType.dropdown:
      return _buildStyleTraitDropdownWidget(
          styleTrait.styleValues, title, onSelectItemCallback);
    case StyleTraitType.button:
      return Column(
        children: [
          SingleSelectionOptionChip<StyleValueEntity>(
              values:
                  styleTrait.styleValues!.map((e) => e.styleValue!).toList(),
              chipTitle: title,
              selectedValue: selectedStyleValues?[
                  styleTrait.selectedStyleValue?.styleValue?.styleTraitValueId],
              onSelectionChanged: (StyleValueEntity? selection) {
                onSelectItemCallback(context, selection!);
              }),
        ],
      );
    case StyleTraitType.swatchList:
      return Column(
        children: [
          SingleSelectionSwatchChip<StyleValueEntity>(
              values:
                  styleTrait.styleValues!.map((e) => e.styleValue!).toList(),
              chipTitle: title,
              maxItemsToShow: styleTrait.numberOfSwatchesVisible!,
              orientation: ChipOrientation.vertical,
              selectedValue: selectedStyleValues?[
                  styleTrait.selectedStyleValue?.styleValue?.styleTraitValueId],
              onSelectionChanged: (StyleValueEntity? selection) {
                onSelectItemCallback(context, selection!);
              }),
        ],
      );

    case StyleTraitType.swatchGrid:
      return Column(
        children: [
          SingleSelectionSwatchChip<StyleValueEntity>(
              values:
                  styleTrait.styleValues!.map((e) => e.styleValue!).toList(),
              chipTitle: title,
              maxItemsToShow: styleTrait.numberOfSwatchesVisible!,
              orientation: ChipOrientation.horizontal,
              selectedValue: selectedStyleValues?[
                  styleTrait.selectedStyleValue?.styleValue?.styleTraitValueId],
              onSelectionChanged: (StyleValueEntity? selection) {
                onSelectItemCallback(context, selection!);
              }),
        ],
      );
    default:
      return Container();
  }
}

Widget _buildStyleTraitDropdownWidget(
    List<ProductDetailStyleValue>? styleValues,
    String? title,
    void Function(BuildContext context, Object item) onSelectItemCallback) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
          child: Text(
            title!,
            style: OptiTextStyles.body,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: OptiAppColors.backgroundInput,
            borderRadius: BorderRadius.circular(AppStyle.borderRadius),
          ),
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListPickerWidget(
                        items: styleValues!, callback: onSelectItemCallback),
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
