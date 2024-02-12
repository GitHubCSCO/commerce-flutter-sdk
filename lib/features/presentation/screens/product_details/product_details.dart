import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/specification_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/produc_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:commerce_flutter_app/core/extensions/html_string_extension.dart';

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
                appBar: AppBar(),
                body: ListView(
                    children: _buildProductDetailsWidgets(
                        state.productDetailsWidgets, state.product)),
                backgroundColor: AppColors.grayBackgroundColor);
          case ProductDetailsErrorState():
            return const Center(child: Text("failure"));
          default:
            return const Center(child: Text("failure"));
        }
      },
    );
  }

  List<Widget> _buildProductDetailsWidgets(
      List<ProdcutDeatilsPageWidgets> productDetailsWidgets,
      ProductEntity productEntity) {
    List<Widget> widgets = [];
    for (var item in productDetailsWidgets) {
      switch (item.runtimeType) {
        case ProdcutDeatilsPageWidgets:
          widgets.add(Column(
            children:
                buildExpandableDescriptionWidgets(productEntity.specifications),
          ));
          break;
        // Add more cases for other widget types if needed
        default:
          break;
      }
    }
    return widgets;
  }

  List<Widget> buildExpandableDescriptionWidgets(
      List<SpecificationEntity>? specifications) {
    if (specifications == null) {
      return [];
    }

    return specifications.map((specification) {
      return Theme(
          data: ThemeData(dividerColor: Colors.white),
          child: ExpansionTile(
            title: Text(specification.name!),
            collapsedBackgroundColor: Colors.white,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                    specification.htmlContent?.styleHtmlContent() ?? ''),
              ),
            ],
          ));
    }).toList();
  }
}
