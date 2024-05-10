import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/widget/style_trait_widget_items.dart';
import 'package:flutter/material.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




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
                  buildStyleTraitSelectorWidget(
                    styleTrait.displayType,
                    styleTrait,
                    context,
                    styleTrait.styleTraitName,
                    context.read<ProductDetailsBloc>().selectedStyleValues,
                    onSelectItemCallback: (BuildContext context, Object item) {
                      _onSelectStyle(context, item);
                    },
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
    StyleValueEntity? selectedValue;
    if (item is ProductDetailStyleValue) {
      selectedValue = item.styleValue!;
    } else {
      selectedValue = item as StyleValueEntity;
    }
    var productDetailsBloc = context.read<ProductDetailsBloc>();
    productDetailsBloc.add(StyleTraitSelectedEvent(selectedValue));
  }
}

