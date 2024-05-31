import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailsAddToCartWidget extends StatelessWidget {
  const ProductDetailsAddToCartWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: AppStyle.neutral00,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: (context
                          .read<ProductDetailsBloc>()
                          .productDetailDataEntity
                          .addToCartEnabled ==
                      true &&
                  context
                          .read<ProductDetailsBloc>()
                          .productDetailDataEntity
                          .productPricingEnabled ==
                      true)
              ? AddToCartSignInWidget()
              : AddToCartNotSignedInWidget(
                  productPricingEnabled: context
                          .read<ProductDetailsBloc>()
                          .productDetailDataEntity
                          .productPricingEnabled ==
                      true),
        ),
      ),
    );
  }
}

class AddToCartSignInWidget extends StatelessWidget {
  final textEditingController = TextEditingController();

  AddToCartSignInWidget();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailsAddToCartBloc,
        ProductDetailsAddtoCartState>(
      listener: (bloccontext, state) {
        if (state is ProductDetailsProdctAddedToCartSuccess) {
          context.read<CartCountCubit>().onCartItemChange();
          CustomSnackBar.showProductAddedToCart(context);
        }
      },
      child: BlocBuilder<ProductDetailsAddToCartBloc,
          ProductDetailsAddtoCartState>(
        buildWhen: (previous, current) {
          return current is! ProductDetailsProdctAddedToCartSuccess;
        },
        builder: (context, state) {
          if (state is ProductDetailsAddtoCartInitial ||
              state is ProductDetailsAddtoCartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsAddtoCartSuccess) {
            return AddToCartSuccessWidget(state.productDetailsAddToCartEntity);
          }
          if (state is ProductDetailsAddtoCartError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text("failure"));
          }
        },
      ),
    );
  }
}

class AddToCartSuccessWidget extends StatefulWidget {
  final ProductDetailsAddtoCartEntity detailsAddToCartEntity;

  AddToCartSuccessWidget(this.detailsAddToCartEntity);

  @override
  _AddToCartSuccessWidgetState createState() => _AddToCartSuccessWidgetState();
}

class _AddToCartSuccessWidgetState extends State<AddToCartSuccessWidget> {
  int? quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductDetailsAddCartRow(widget.detailsAddToCartEntity, (int? value) {
          setState(() {
            quantity = value;
          });
        }),
        if (widget.detailsAddToCartEntity.isAddToCartAllowed == true)
          PrimaryButton(
              isEnabled:
                  widget.detailsAddToCartEntity.addToCartButtonEnabled == true,
              leadingIcon: SvgPicture.asset(
                AssetConstants.productDeatilsAddToCartIcon,
                fit: BoxFit.fitWidth,
                color: Colors.white,
              ),
              text: LocalizationConstants.addToCart,
              onPressed:
                  widget.detailsAddToCartEntity.addToCartButtonEnabled == true
                      ? () {
                          context.read<ProductDetailsAddToCartBloc>().add(
                              AddToCartEvent(
                                  productDetailsDataEntity: context
                                      .read<ProductDetailsBloc>()
                                      .productDetailDataEntity,
                                  productDetailsAddToCartEntity:
                                      widget.detailsAddToCartEntity.copyWith(
                                          quantityText: quantity.toString())));
                        }
                      : null)
      ],
    );
  }
}

class ProductDetailsAddCartRow extends StatelessWidget {
  final ProductDetailsAddtoCartEntity detailsAddToCartEntity;
  final ValueChanged<int?> onQuantityChanged;

  ProductDetailsAddCartRow(this.detailsAddToCartEntity, this.onQuantityChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: NumberTextField(
                max: CoreConstants.maximumOrderQuantity,
                initialtText: detailsAddToCartEntity.quantityText,
                shouldShowIncrementDecermentIcon: true,
                onChanged: (int? quantity) {
                  onQuantityChanged(quantity);
                  var pricingState =
                      context.read<ProductDetailsPricingBloc>().state;
                  if (pricingState is ProductDetailsPricingLoaded) {
                    var productDetailsPricingEntity =
                        pricingState.productDetailsPriceEntity;
                    var productDetailsBloc = context.read<ProductDetailsBloc>();
                    productDetailsBloc.updateQuantity(quantity!);

                    context
                        .read<ProductDetailsPricingBloc>()
                        .add(LoadProductDetailsPricing(
                          productDetailsPricingEntity:
                              productDetailsPricingEntity,
                          productDetailsDataEntity:
                              productDetailsBloc.productDetailDataEntity,
                          quantity: quantity,
                        ));
                  }
                }),
          ),
          Expanded(
              flex: 1,
              child: ProductDetailsAddCartTtitleSubTitleColumn('U/M', 'E/A')),
          Expanded(
            flex: 3,
            child: ProductDetailsAddCartTtitleSubTitleColumn(
                'Subtotal', detailsAddToCartEntity.subtotalValueText ?? ''),
          ),
        ],
      ),
    );
  }
}

class ProductDetailsAddCartTtitleSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;

  ProductDetailsAddCartTtitleSubTitleColumn(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: OptiTextStyles.bodySmall,
        ),
        FittedBox(
          child: Text(
            value,
            style: OptiTextStyles.titleLarge,
          ),
          fit: BoxFit.scaleDown,
        ),
      ],
    );
  }
}

class AddToCartNotSignedInWidget extends StatelessWidget {
  final bool productPricingEnabled;

  const AddToCartNotSignedInWidget(
      {super.key, required this.productPricingEnabled});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: productPricingEnabled
          ? LocalizationConstants.signInForAddToCart
          : LocalizationConstants.signInForPricing,
      onPressed: () {
        AppRoute.login.navigateBackStack(context);
      },
    );
  }
}
