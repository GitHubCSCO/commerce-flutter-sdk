import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/style_trait/style_trait_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/style_trait/style_trait_state.dart';
import 'package:commerce_flutter_app/features/presentation/widget/style_trait_widget_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showStyleTraitFilter(
  ProductEntity product,
  BuildContext context, {
  required void Function(StyledProductEntity? styledProductEntity) onGetProduct,
}) {
  final isApplyEnabledNotifier = ValueNotifier(false);

  context.read<StyleTraitCubit>().initSelectedAvailableTraitValues(product);
  context.read<StyleTraitCubit>().fetchStyleTraitValues(product);
  showFilterModalSheet(
    context,
    onApply: () {
      var styledProduct = context.read<StyleTraitCubit>().styledProductEntity;
      if (styledProduct != null) {
        onGetProduct(styledProduct);
      }
    },
    onReset: null,
    isApplyEnabledNotifier: isApplyEnabledNotifier,
    child: BlocProvider.value(
      value: BlocProvider.of<StyleTraitCubit>(context),
      child: BlocConsumer<StyleTraitCubit, StyleTraitState>(
        listener: (BuildContext _, StyleTraitState state) {
          // Update the ValueNotifier based on whether all traits are selected
          isApplyEnabledNotifier.value =
              context.read<StyleTraitCubit>().isAllTraitSelected();
        },
        builder: (context, state) {
          if (state is StyleTraitStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StyleTraitStateFailure) {
            return const Center(
              child: Text('Error loading product values'),
            );
          } else if (state is StyleTraitStateLoaded &&
              state.styleTraitsEntity.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.styleTraitsEntity.map((styleTrait) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildStyleTraitSelectorWidget(
                      "Button",
                      styleTrait,
                      context,
                      styleTrait.styleTraitName,
                      context.read<StyleTraitCubit>().selectedStyleValues,
                      onSelectItemCallback: (context, item) {
                        StyleValueEntity? selectedValue;
                        if (item is ProductDetailStyleValue) {
                          selectedValue = item.styleValue!;
                        } else {
                          selectedValue = item as StyleValueEntity;
                        }

                        context
                            .read<StyleTraitCubit>()
                            .updateStyledProductBasedOnSelection(selectedValue);
                      },
                    ),
                  ],
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    ),
  );
}
