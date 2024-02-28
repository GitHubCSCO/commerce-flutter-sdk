import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_description_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/produc_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_add_to_cart_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_general_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_pricing_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_spefication_expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:commerce_flutter_app/core/extensions/html_string_extension.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailsBloc>(
          create: (context) => sl<ProductDetailsBloc>()
            ..add(FetchProductDetailsEvent(productId)),
        ),
        BlocProvider<ProductDetailsPricingBloc>(
          create: (context) => sl<ProductDetailsPricingBloc>(),
        ),
        BlocProvider<ProductDetailsAddToCartBloc>(
          create: (context) => sl<ProductDetailsAddToCartBloc>(),
        ),
      ],
      child: ProductDetailsPage(),
    );
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
                body: SingleChildScrollView(
                  child: Column(
                    children: _buildProductDetailsWidgets(
                        state.productDetailsEntities, context),
                  ),
                ),
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
      List<ProductDetailsBaseEntity> productDetailsEntities,
      BuildContext buildContext) {
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
        case ProdcutDeatilsPageWidgets.productDetailsAddtoCart:
          final detailsAddToCartEntity = item as ProductDetailsAddtoCartEntity;
          widgets
              .add(buildAddToCartWidget(detailsAddToCartEntity, buildContext));
        case ProdcutDeatilsPageWidgets.productDetailsPrice:
          final productDetailsPriceEntity = item as ProductDetailsPriceEntity;
          widgets.add(buildPricingWidget(productDetailsPriceEntity));
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
    return ProductDetailsExpansionItemWidget(specification: specification);
  }

  // details general info widget
  Widget buildGeneralInfoWidget(
      ProductDetailsGeneralInfoEntity generalInfoEntity) {
    return ProductDetailsGeneralWidget(generalInfoEntity: generalInfoEntity);
  }

  // details add to cart widget

  Widget buildAddToCartWidget(
      ProductDetailsAddtoCartEntity detailsAddToCartEntity,
      BuildContext buildContext) {
    return BlocListener<ProductDetailsPricingBloc, ProductDetailsPricingState>(
      listener: (context, state) {
        if (state is ProductDetailsPricingLoaded) {
          final priceEntity = state.productDetailsPriceEntity;
          buildContext.read<ProductDetailsAddToCartBloc>().add(
                LoadProductDetailsAddToCartEvent(
                  productDetailsAddToCartEntity: detailsAddToCartEntity,
                  productDetailsPriceEntity: priceEntity,
                ),
              );
        }
      },
      child: BlocBuilder<ProductDetailsAddToCartBloc,
          ProductDetailsAddtoCartState>(builder: (context, state) {
        if (state is ProductDetailsAddtoCartInitial ||
            state is ProductDetailsAddtoCartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductDetailsAddtoCartSuccess) {
          return ProductDetailsAddToCartWidget(
              detailsAddToCartEntity: state.productDetailsAddToCartEntity);
        } else {
          return Container(); // return a default widget in case of other states
        }
      }),
    );
  }

  Widget buildPricingWidget(
      ProductDetailsPriceEntity productDetailsPriceEntity) {
    // return BlocProvider(
    //   create: (context) => sl<ProductDetailsPricingBloc>()
    //     ..add(LoadProductDetailsPricing(
    //         productDetailsPriceEntity: productDetailsPriceEntity)),
    //   child: ProductDetailsPricingWidget(
    //       productDetailsPricingEntity: productDetailsPriceEntity),
    // );

    return ProductDetailsPricingWidget(
        productDetailsPricingEntity: productDetailsPriceEntity);
  }
}
