import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/single_selection_swatch_chip.dart';
import 'package:commerce_flutter_app/features/presentation/components/single_selection_option_chip.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class ProductDetailsStyleTraitWidget extends StatelessWidget {
  final ProductDetailsStyletraitsEntity productDetailsStyletraitsEntity;

  const ProductDetailsStyleTraitWidget(
      {super.key, required this.productDetailsStyletraitsEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                productDetailsStyletraitsEntity.styleTraits!.map((styleTrait) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildStyleTraitSelectorWidget(styleTrait.displayType,
                      styleTrait, context, styleTrait.styleTraitName),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildStyleTraitDropdownWidget(
      List<ProductDetailStyleValue>? styleValues, String? title) {
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
                          items: styleValues!,
                          callback: _onSelectStyleFromDropDown),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AssetConstants.iconArrowDown,
                          fit: BoxFit.fitWidth,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSelectStyleFromDropDown(BuildContext context, Object item) {
    var value = item as ProductDetailStyleValue;
    _onSelectStyle(context, value);
  }

  void _onSelectStyle(
      BuildContext context, ProductDetailStyleValue selectedValue) {
    var productDetailsBloc = context.read<ProductDetailsBloc>();
    productDetailsBloc.add(StyleTraitSelectedEvent(selectedValue));
  }

  Widget _buildStyleTraitSelectorWidget(String? displayType,
      ProductDetailStyleTrait styleTrait, BuildContext context, String? title) {
    switch (styleTraitTypeFromString(displayType!)) {
      case StyleTraitType.swatchDropdown:
        return _buildStyleTraitDropdownWidget(styleTrait.styleValues, title);
      case StyleTraitType.dropdown:
        return _buildStyleTraitDropdownWidget(styleTrait.styleValues, title);
      case StyleTraitType.button:
        return Column(
          children: [
            SingleSelectionOptionChip<ProductDetailStyleValue>(
                values: styleTrait.styleValues!,
                chipTitle: title,
                selectedValue:
                    context.read<ProductDetailsBloc>().selectedStyleValue,
                onSelectionChanged: (ProductDetailStyleValue? selection) {
                  _onSelectStyle(context, selection!);
                }),
          ],
        );
      case StyleTraitType.swatchList:
        return Column(
          children: [
            SingleSelectionSwatchChip<ProductDetailStyleValue>(
                values: styleTrait.styleValues!,
                chipTitle: title,
                maxItemsToShow: styleTrait.numberOfSwatchesVisible!,
                orientation: ChipOrientation.vertical,
                selectedValue:
                    context.read<ProductDetailsBloc>().selectedStyleValue,
                onSelectionChanged: (ProductDetailStyleValue? selection) {
                  _onSelectStyle(context, selection!);
                }),
          ],
        );

      case StyleTraitType.swatchGrid:
        return Column(
          children: [
            SingleSelectionSwatchChip<ProductDetailStyleValue>(
                values: styleTrait.styleValues!,
                chipTitle: title,
                maxItemsToShow: styleTrait.numberOfSwatchesVisible!,
                orientation: ChipOrientation.horizontal,
                selectedValue:
                    context.read<ProductDetailsBloc>().selectedStyleValue,
                onSelectionChanged: (ProductDetailStyleValue? selection) {
                  _onSelectStyle(context, selection!);
                }),
          ],
        );
      default:
        return Container();
    }
  }
}
