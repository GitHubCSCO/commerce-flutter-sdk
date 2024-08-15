import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_attributes_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_cross_sell_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_description_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_documents_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_general_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_standard_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/produc_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/style_trait/style_trait_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_add_to_cart_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_attributes_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_documents_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_general_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_pricing_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_spefication_expansion_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_standart_configuration_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details_style_traits_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:commerce_flutter_app/core/extensions/html_string_extension.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final ProductEntity? product;
  const ProductDetailsScreen(
      {super.key, required this.productId, this.product});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductDetailsBloc>(
          create: (context) => sl<ProductDetailsBloc>()
            ..add(FetchProductDetailsEvent(productId, product)),
        ),
        BlocProvider<ProductDetailsPricingBloc>(
          create: (context) => sl<ProductDetailsPricingBloc>(),
        ),
        BlocProvider<ProductDetailsAddToCartBloc>(
          create: (context) => sl<ProductDetailsAddToCartBloc>(),
        ),
        BlocProvider<StyleTraitCubit>(
          create: (context) => sl<StyleTraitCubit>(),
        ),
      ],
      child: ProductDetailsPage(productId, product),
    );
  }
}

class ProductDetailsPage extends StatelessWidget with BaseDynamicContentScreen {
  final String productId;
  final ProductEntity? product;
  const ProductDetailsPage(this.productId, this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context
                .read<ProductDetailsBloc>()
                .add(FetchProductDetailsEvent(productId, product));
          }
        },
        child: Scaffold(
          backgroundColor: OptiAppColors.backgroundGray,
          appBar: AppBar(actions: <Widget>[
            BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                builder: (_, state) {
              switch (state) {
                case ProductDetailsLoaded():
                  return BottomMenuWidget(
                      toolMenuList: [
                        ToolMenu(
                            title: LocalizationConstants.addToList.localized(),
                            action: () {
                              final currentState =
                                  context.read<AuthCubit>().state;
                              handleAuthStatusInProductDetails(
                                  context,
                                  currentState.status,
                                  context.read<ProductDetailsBloc>());
                            }),
                      ],
                      websitePath: context
                          .read<ProductDetailsBloc>()
                          .productDetailDataEntity
                          .product
                          ?.productDetailUrl);
                default:
                  return Container();
              }
            })
          ], backgroundColor: Theme.of(context).colorScheme.surface),
          body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (_, state) {
              switch (state) {
                case ProductDetailsInitial():
                case ProductDetailsLoading():
                  return const Center(child: CircularProgressIndicator());
                case ProductDetailsLoaded():
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildProductDetailsWidgets(
                          state.productDetailsEntities, context),
                    ),
                  );
                case ProductDetailsErrorState():
                  return const Center(child: Text("failure"));
                default:
                  return const Center(child: Text("failure"));
              }
            },
          ),
        ));
  }

  void handleAuthStatusInProductDetails(BuildContext context, AuthStatus status,
      ProductDetailsBloc productDetailsBloc) {
    if (status == AuthStatus.authenticated) {
      navigateToCheckout(context, productDetailsBloc);
    } else {
      showSignInDialog(context);
    }
  }

  void navigateToCheckout(
      BuildContext context, ProductDetailsBloc productDetailsBloc) {
    final addCartLineForWishList =
        productDetailsBloc.getAddCartLineForWistlist();

    addCartLineForWishList[0].qtyOrdered = context
            .read<ProductDetailsPricingBloc>()
            .state is ProductDetailsPricingLoaded
        ? (context.read<ProductDetailsPricingBloc>().state
                as ProductDetailsPricingLoaded)
            .productDetailsPriceEntity
            .quantity
        : addCartLineForWishList[0].qtyOrdered;
    WishListCallbackHelper.addItemsToWishList(
      context,
      addToCartCollection: WishListAddToCartCollection(
        wishListLines: addCartLineForWishList,
      ),
      onAddedToCart: null,
    );
  }

  void showSignInDialog(BuildContext context) {
    displayDialogWidget(
      context: context,
      title: LocalizationConstants.notSignedIn.localized(),
      message: LocalizationConstants.pleaseSignInBeforeAddingToList.localized(),
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
            AppRoute.login.navigateBackStack(context);
          },
          child: Text(LocalizationConstants.signIn.localized()),
        ),
      ],
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
        case ProdcutDeatilsPageWidgets
              .productDeatilsStanddardConfigurationSection:
          final productDetailsStandardConfigurationEntity =
              item as ProductDetailsStandardConfigurationEntity;
          widgets.add(buildStandanrConfigurationWidget(
              productDetailsStandardConfigurationEntity));
          break;
        case ProdcutDeatilsPageWidgets.productDetailsAddtoCart:
          final detailsAddToCartEntity = item as ProductDetailsAddtoCartEntity;
          widgets
              .add(buildAddToCartWidget(detailsAddToCartEntity, buildContext));
        case ProdcutDeatilsPageWidgets.productDetailsPrice:
          final productDetailsPriceEntity = item as ProductDetailsPriceEntity;
          widgets.add(buildPricingWidget(productDetailsPriceEntity));
          break;

        case ProdcutDeatilsPageWidgets.productDetailsCrossSellSection:
          final crossSellEntity = item as ProductDetailsCrossSellEntity;
          widgets.add(buildProductCarouselWidget(
              productCarouselWidgetEntity:
                  crossSellEntity.productCarouselWidgetEntity!));
        case ProdcutDeatilsPageWidgets.productDetailsStyleTraits:
          final productDetailsStyletraitsEntity =
              item as ProductDetailsStyletraitsEntity;
          widgets.add(buildProductDetailsStyleTraitWidget(
              productDetailsStyletraitsEntity:
                  productDetailsStyletraitsEntity));
        case ProdcutDeatilsPageWidgets.productDetailsDocuments:
          final productDetailsDocumentsEntity =
              item as ProductDetailsDocumentsEntity;
          widgets.add(buildProductDetailsDocumentsWidget(
              productDetailsDocumentsEntity: productDetailsDocumentsEntity));
        case ProdcutDeatilsPageWidgets.productDetailsAttributes:
          final productDetailsAttributesEntity =
              item as ProductDetailsAttributesEntity;
          widgets.add(buildProductDetailsAttributesWidget(
              productDetailsAttributesEntity: productDetailsAttributesEntity));
        default:
          break;
      }
    }
    return widgets;
  }

// details description widget
  Widget buildProductDetailsDescriptionWidget(
      ProductDetailsDescriptionEntity detailsEntity) {
    if (detailsEntity.htmlContent.isNullOrEmpty) {
      return const SizedBox.shrink(); // or return Container();
    }

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: HtmlWidget(
            detailsEntity.htmlContent.styleHtmlContent()!,
            textStyle: OptiTextStyles.body,
          )),
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
          detailsAddToCartEntity = detailsAddToCartEntity.copyWith(
              productDetailsPriceEntity: priceEntity,
              isAddToCartAllowed: priceEntity.addToCartVisible,
              addToCartButtonEnabled: priceEntity.addToCartEnabled);

          buildContext.read<ProductDetailsAddToCartBloc>().add(
                LoadProductDetailsAddToCartEvent(
                  productDetailsAddToCartEntity: detailsAddToCartEntity,
                ),
              );
        }
      },
      child: const ProductDetailsAddToCartWidget(),
    );
  }

  Widget buildPricingWidget(
      ProductDetailsPriceEntity productDetailsPriceEntity) {
    return ProductDetailsPricingWidget(
        productDetailsPricingEntity: productDetailsPriceEntity);
  }

  Widget buildStandanrConfigurationWidget(
      ProductDetailsStandardConfigurationEntity
          productDetailsStandardConfigurationEntity) {
    return ProductDetailsStandardConfigurationWidget(
        productDetailsStandardConfigurationEntity:
            productDetailsStandardConfigurationEntity);
  }

  Widget buildProductCarouselWidget(
      {required ProductCarouselWidgetEntity productCarouselWidgetEntity}) {
    return BlocProvider(
      create: (context) => sl<ProductCarouselCubit>()
        ..getCarouselProducts(productCarouselWidgetEntity),
      child: ProductCarouselSectionWidget(
          productCarouselWidgetEntity: productCarouselWidgetEntity),
    );
  }

  Widget buildProductDetailsStyleTraitWidget(
      {required ProductDetailsStyletraitsEntity
          productDetailsStyletraitsEntity}) {
    return ProductDetailsStyleTraitWidget(
        productDetailsStyletraitsEntity: productDetailsStyletraitsEntity);
  }

  Widget buildProductDetailsDocumentsWidget({
    required ProductDetailsDocumentsEntity productDetailsDocumentsEntity,
  }) {
    return ProductDetailsDocumentsWidget(
        productdetailsdocumentsEntity: productDetailsDocumentsEntity);
  }

  Widget buildProductDetailsAttributesWidget(
      {required ProductDetailsAttributesEntity
          productDetailsAttributesEntity}) {
    return ProductDetailsAttributesWidget(
        productDetailsAttributesEntity: productDetailsAttributesEntity);
  }
}
