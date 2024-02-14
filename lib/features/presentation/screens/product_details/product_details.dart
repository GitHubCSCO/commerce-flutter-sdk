import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_description_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/produc_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_carousel_widget.dart';
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
                        state.productDetailsEntities)),
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
      List<ProductDetailsBaseEntity> productDetailsEntities) {
    List<Widget> widgets = [];
    for (var item in productDetailsEntities) {
      switch (item.detailsSectionType) {
        case ProdcutDeatilsPageWidgets.productDetailsSpecification:
          final specificationEntity = item as ProductDetailItemEntity;
          widgets.add(buildExpandableDescriptionWidget(specificationEntity));
          break;
        case ProdcutDeatilsPageWidgets.productDetailsDescription:
          final detailsEntity = item as ProductDetailsDescriptionEntity;
          widgets.add(buildProductDetailsDescriptionWidget(detailsEntity));
          break;
        case ProdcutDeatilsPageWidgets.productDetailsGeneralInfo:
          final generalInfoEntity = item as ProductDetailsGeneralInfoEntity;
          widgets.add(buildGeneralInfoWidget(generalInfoEntity));
          break;
        default:
          break;
      }
    }
    return widgets;
  }

// details description widget
  Widget buildProductDetailsDescriptionWidget(
      ProductDetailsDescriptionEntity detailsEntity) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: HtmlWidget(detailsEntity.htmlContent?.styleHtmlContent() ?? ''),
      ),
    );
  }

  // details expandable widgets
  Widget buildExpandableDescriptionWidget(
      ProductDetailItemEntity specification) {
    return Theme(
        data: ThemeData(dividerColor: Colors.white),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          title: Text(specification.title),
          collapsedBackgroundColor: Colors.white,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: HtmlWidget(
                  specification.htmlContent?.styleHtmlContent() ?? ''),
            ),
          ],
        ));
  }

  // details general info widget

  Widget buildGeneralInfoWidget(
      ProductDetailsGeneralInfoEntity generalInfoEntity) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocProvider(
            create: (context) => CarouselIndicatorCubit(),
            child: ProductDetailsCarouselWidget(
                generalInfoEntity: generalInfoEntity),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  generalInfoEntity.productName ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                if (generalInfoEntity.originalPartNumberValue != null)
                  Text(
                    generalInfoEntity.originalPartNumberValue ?? '',
                    style: const TextStyle(color: AppColors.lightGrayTextColor),
                    textAlign: TextAlign.left,
                  ),
                if (generalInfoEntity.myPartNumberValue != null &&
                    generalInfoEntity.myPartNumberValue!.isNotEmpty)
                  Row(children: [
                    Text(
                      generalInfoEntity.myPartNumberTitle ?? '',
                      style:
                          const TextStyle(color: AppColors.darkGrayTextColor),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      generalInfoEntity.myPartNumberValue ?? '',
                      style:
                          const TextStyle(color: AppColors.lightGrayTextColor),
                      textAlign: TextAlign.left,
                    ),
                  ]),
                if (generalInfoEntity.mFGNumberValue != null &&
                    generalInfoEntity.mFGNumberValue!.isNotEmpty)
                  Row(children: [
                    Text(
                      generalInfoEntity.mFGNumberTitle ?? '',
                      style:
                          const TextStyle(color: AppColors.darkGrayTextColor),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      generalInfoEntity.mFGNumberValue ?? '',
                      style:
                          const TextStyle(color: AppColors.lightGrayTextColor),
                      textAlign: TextAlign.left,
                    ),
                  ]),
                if (generalInfoEntity.packDescriptionValue != null &&
                    generalInfoEntity.packDescriptionValue!.isNotEmpty)
                  Row(children: [
                    Text(
                      generalInfoEntity.packDescriptionTitle ?? '',
                      style:
                          const TextStyle(color: AppColors.darkGrayTextColor),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      generalInfoEntity.packDescriptionValue ?? '',
                      style:
                          const TextStyle(color: AppColors.lightGrayTextColor),
                      textAlign: TextAlign.left,
                    ),
                  ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
