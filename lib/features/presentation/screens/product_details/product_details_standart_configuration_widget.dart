import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_standard_configuration_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/list_picker_widget.dart';
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
    return BlocBuilder<ProductDetailsPricingBloc, ProductDetailsPricingState>(
        builder: (context, state) {
      if (state is ProductDetailsPricingLoaded) {
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
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 15.0, 0.0, 5.0),
                        child: Text(
                          configSectionOption.sectionName!,
                          style: OptiTextStyles.body,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: OptiAppColors.backgroundInput,
                            borderRadius:
                                BorderRadius.circular(AppStyle.borderRadius),
                          ),
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
                                        selectedIndex: _getIndexOfConfig(
                                            configSectionOption.options,
                                            context
                                                    .read<ProductDetailsBloc>()
                                                    .productDetailDataEntity
                                                    .selectedConfigurations?[
                                                configSectionOption
                                                    .sectionName!]),
                                        callback: _onSelectConfigurationPicker),
                                  )),
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
      } else
        return Container();
    });
  }

  int _getIndexOfConfig(final List<ConfigSectionOptionEntity>? option,
      ConfigSectionOptionEntity? selectedOption) {
    if (option == null || selectedOption == null) {
      return 0;
    }
    for (var i = 0; i < option.length; i++) {
      if (option[i] == selectedOption) {
        return i;
      }
    }
    return 0;
  }

  void _onSelectConfigurationPicker(BuildContext context, Object item) {
    var event = context.read<ProductDetailsPricingBloc>();
    var productDetailsBloc = context.read<ProductDetailsBloc>();
    productDetailsBloc
        .onSelectedConfiguration(item as ConfigSectionOptionEntity);

    event.add(LoadProductDetailsPricing(
        productDetailsPricingEntity: event.productDetailsPricingEntity,
        quantity: productDetailsBloc.quantity,
        productDetailsDataEntity: productDetailsBloc.productDetailDataEntity));
  }
}
