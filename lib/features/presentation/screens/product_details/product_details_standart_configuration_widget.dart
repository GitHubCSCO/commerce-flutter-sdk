import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_standard_configuration_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailsStandardConfigurationWidget extends StatelessWidget {
  final ProductDetailsStandardConfigurationEntity
      productDetailsStandardConfigurationEntity;

  const ProductDetailsStandardConfigurationWidget(
      {super.key, required this.productDetailsStandardConfigurationEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          color: Colors.white,
          child: Column(
            children: productDetailsStandardConfigurationEntity
                .configSectionOptions!
                .map((configSectionOption) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 5.0),
                    child: Text(
                      configSectionOption.sectionName!,
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
                                    items: configSectionOption.options!,
                                    callback: _onSelectConfigurationPicker),
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

  void _onSelectConfigurationPicker(BuildContext context, Object item) {
    var event = context.read<ProductDetailsPricingBloc>();
    var productDetailsBloc = context.read<ProductDetailsBloc>();
    productDetailsBloc
        .onSelectedConfiguration(item as ConfigSectionOptionEntity);

    event.add(LoadProductDetailsPricing(
        productDetailsPricingEntity: event.productDetailsPricingEntity,
        product: productDetailsBloc.product,
        styledProduct: productDetailsBloc.styledProduct,
        productPricingEnabled: productDetailsBloc.productPricingEnabled,
        quantity: productDetailsBloc.quantity,
        chosenUnitOfMeasure: productDetailsBloc.chosenUnitOfMeasure,
        realtimeProductAvailabilityEnabled:
            productDetailsBloc.realtimeProductAvailabilityEnabled,
        realtimeProductPricingEnabled:
            productDetailsBloc.realtimeProductPricingEnabled,
        productSettings: productDetailsBloc.productSettings,
        selectedConfigurations: productDetailsBloc.selectedConfigurations));
  }
}
