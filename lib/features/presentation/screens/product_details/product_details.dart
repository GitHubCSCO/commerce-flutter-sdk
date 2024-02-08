import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/produc_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailsScreen({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailsBloc>(
        create: (context) => sl<ProductDetailsBloc>()
          ..add(FetchProductDetailsEvent(productEntity)),
        child: ProductDetailsPage());
  }
}

class ProductDetailsPage extends BaseDynamicContentScreen {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        switch (state) {
          case ProductDetailsInitial():
          case ProductDetailsLoading():
            return const Center(child: CircularProgressIndicator());
          case ProductDetailsLoaded():
            return Scaffold(
                appBar: AppBar(), body: Text(state.product?.id ?? ""));
          case ProductDetailsErrorState():
            return const Center(child: Text("failure"));
          default:
            return const Center(child: Text("failure"));
        }
      },
    );
  }
}
