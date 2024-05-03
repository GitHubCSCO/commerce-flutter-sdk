// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';

import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
            children: productDetailsStyletraitsEntity.styleTraits!
                .map((configSectionOption) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 5.0),
                    child: Text(
                      configSectionOption.styleTraitName!,
                      style: OptiTextStyles.body,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: OptiAppColors.backgroundInput,
                        borderRadius:
                            BorderRadius.circular(AppStyle.borderRadius),
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
                                    items: configSectionOption.styleValues!,
                                    callback: _onSelectStyle),
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
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _onSelectStyle(BuildContext context, Object item) {
    var productDetailsBloc = context.read<ProductDetailsBloc>();
    var value = item as ProductDetailStyleValue;
    productDetailsBloc.add(StyleTraitSelectedEvent(value.styleValue!));
    
  }
}
