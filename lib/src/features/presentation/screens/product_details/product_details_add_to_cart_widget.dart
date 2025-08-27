import 'package:collection/collection.dart';
import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/producut_details_bloc/product_details_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/producut_details_bloc/product_details_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/number_text_field.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

void _updateCart(BuildContext context, bool shouldEagerReloadCart) {
  unawaited(context.read<CartCountCubit>().onCartItemChange());
  if (shouldEagerReloadCart) {
    context.read<RootBloc>().add(RootCartUpdateEvent());
  }
}

class ProductDetailsAddToCartWidget extends StatelessWidget {
  final bool shouldEagerReloadCart;

  const ProductDetailsAddToCartWidget({
    super.key,
    this.shouldEagerReloadCart = false,
  });

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

  AddToCartSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailsAddToCartBloc,
        ProductDetailsAddtoCartState>(
      listener: (bloccontext, state) {
        if (state is ProductDetailsProdctAddedToCartSuccess) {
          _updateCart(
              context,
              context
                      .findAncestorWidgetOfExactType<
                          ProductDetailsAddToCartWidget>()
                      ?.shouldEagerReloadCart ??
                  false);
          CustomSnackBar.showProductAddedToCart(
              context,
              context
                  .read<ProductDetailsAddToCartBloc>()
                  .messageAddToCartSuccess);
        } else if (state is ProductDetailsAddtoCartError) {
          CustomSnackBar.showAddToCartFailed(context,
              context.read<ProductDetailsAddToCartBloc>().messageAddtoCartFail);
        } else if (state is ProductDetailsAddToCartInvalidPrice) {
          CustomSnackBar.showSnackBarMessage(
            context,
            context
                .read<ProductDetailsAddToCartBloc>()
                .messageAddtoCartFailInvalidPrice,
            seconds: 4,
          );
        } else if (state is ProductDetailsAddtoCartWarning) {
          _displayQuanityWarningDialog(
              context,
              context
                  .read<ProductDetailsAddToCartBloc>()
                  .messageAddToCartQuantityAdjusted);
        }
      },
      child: BlocBuilder<ProductDetailsAddToCartBloc,
          ProductDetailsAddtoCartState>(
        buildWhen: (previous, current) {
          if (current is ProductDetailsProdctAddedToCartSuccess ||
              current is ProductDetailsAddtoCartError ||
              current is ProductDetailsAddtoCartWarning ||
              current is ProductDetailsAddToCartInvalidPrice) {
            return false;
          }
          return true;
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
            return Center(child: Text(state.errorMessage ?? ""));
          } else {
            return const Center(child: Text("failure"));
          }
        },
      ),
    );
  }

  void _displayQuanityWarningDialog(BuildContext context, String msg) {
    displayDialogWidget(context: context, message: msg, actions: [
      DialogPlainButton(
        onPressed: () {
          _updateCart(
              context,
              context
                      .findAncestorWidgetOfExactType<
                          ProductDetailsAddToCartWidget>()
                      ?.shouldEagerReloadCart ??
                  false);
          CustomSnackBar.showProductAddedToCart(
              context,
              context
                  .read<ProductDetailsAddToCartBloc>()
                  .messageAddToCartSuccess);
          Navigator.of(context).pop();
        },
        child: Text(LocalizationConstants.oK.localized()),
      ),
    ]);
  }
}

class AddToCartSuccessWidget extends StatefulWidget {
  final ProductDetailsAddtoCartEntity detailsAddToCartEntity;

  AddToCartSuccessWidget(this.detailsAddToCartEntity, {super.key});

  @override
  _AddToCartSuccessWidgetState createState() => _AddToCartSuccessWidgetState();
}

class _AddToCartSuccessWidgetState extends State<AddToCartSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductDetailsAddCartRow(widget.detailsAddToCartEntity, (int? value) {
          context.read<ProductDetailsAddToCartBloc>().add(
              AddToCartUpdateQuantityEvent(quantityText: value.toString()));
        }),
        if (widget.detailsAddToCartEntity.isAddToCartAllowed == true)
          PrimaryButton(
              isEnabled:
                  widget.detailsAddToCartEntity.addToCartButtonEnabled == true,
              leadingIcon: SvgPicture.asset(
                AssetConstants.productDeatilsAddToCartIcon,
                fit: BoxFit.fitWidth,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              text: LocalizationConstants.addToCart.localized(),
              onPressed: widget.detailsAddToCartEntity.addToCartButtonEnabled ==
                      true
                  ? () {
                      context.read<ProductDetailsAddToCartBloc>().add(
                          AddToCartEvent(
                              productDetailsDataEntity: context
                                  .read<ProductDetailsBloc>()
                                  .productDetailDataEntity,
                              productDetailsAddToCartEntity:
                                  widget.detailsAddToCartEntity.copyWith(
                                      quantityText: context
                                          .read<ProductDetailsAddToCartBloc>()
                                          .quantityText)));
                    }
                  : null)
      ],
    );
  }
}

class ProductDetailsAddCartRow extends StatelessWidget {
  final ProductDetailsAddtoCartEntity detailsAddToCartEntity;
  final ValueChanged<int?> onQuantityChanged;

  ProductDetailsAddCartRow(this.detailsAddToCartEntity, this.onQuantityChanged,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final isUnitOfMeasureEnabled =
        detailsAddToCartEntity.productUnitOfMeasures != null &&
            (detailsAddToCartEntity.productUnitOfMeasures?.length ?? 0) > 0;

    return SizedBox(
      height: 170,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    LocalizationConstants.qTY.localized(),
                    style: OptiTextStyles.subtitle,
                  ),
                ),
                if (isUnitOfMeasureEnabled)
                  Expanded(
                    flex: 2,
                    child: Text(
                      LocalizationConstants.unitOfMeasure.localized(),
                      style: OptiTextStyles.subtitle,
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: NumberTextField(
                      max: CoreConstants.maximumOrderQuantity,
                      initialText: detailsAddToCartEntity.quantityText,
                      shouldShowIncrementDecrementIcon: true,
                      onSubmitted: (num? quantity) {
                        if (quantity == null) {
                          return;
                        }

                        context.read<RootBloc>().add(RootAnalyticsEvent(
                            AnalyticsEvent(AnalyticsConstants.eventQtyIncDec,
                                AnalyticsConstants.screenNameProductDetail)));

                        onQuantityChanged(quantity.toInt());
                        var pricingState =
                            context.read<ProductDetailsPricingBloc>().state;
                        if (pricingState is ProductDetailsPricingLoaded) {
                          var productDetailsPricingEntity =
                              pricingState.productDetailsPriceEntity;
                          var productDetailsBloc =
                              context.read<ProductDetailsBloc>();
                          productDetailsBloc.updateQuantity(quantity.toInt());

                          context
                              .read<ProductDetailsPricingBloc>()
                              .add(LoadProductDetailsPricing(
                                productDetailsPricingEntity:
                                    productDetailsPricingEntity,
                                productDetailsDataEntity:
                                    productDetailsBloc.productDetailDataEntity,
                                quantity: quantity.toInt(),
                              ));
                        } else {
                          context
                              .read<ProductDetailsBloc>()
                              .add(ProductDetailsReloadEvent());
                        }
                      }),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                    flex: 2, child: _buildUnitOFMeasureChangeWidget(context)),
              ],
            ),
            if (!(detailsAddToCartEntity.hidePricing ?? false))
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ProductDetailsAddCartTtitleSubTitleColumn(
                    LocalizationConstants.subtotal.localized(),
                    detailsAddToCartEntity.subtotalValueText ?? ''),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitOFMeasureChangeWidget(
    BuildContext context,
  ) {
    void onUnitOfMeasureSelec(BuildContext context, Object item) {
      context.read<ProductDetailsBloc>().add(UnitOfMeasuteChangeEvent(
          productunitOfMeasureEntity: item as ProductUnitOfMeasureEntity));
    }

    int getIndexOfUOM(List<ProductUnitOfMeasureEntity>? productUnitOfMeasures,
        ProductUnitOfMeasureEntity? chosenUnitOfMeasure) {
      if (productUnitOfMeasures == null || chosenUnitOfMeasure == null) {
        return 0;
      }

      for (int i = 0; i < productUnitOfMeasures.length; i++) {
        if (productUnitOfMeasures[i].productUnitOfMeasureId ==
            chosenUnitOfMeasure.productUnitOfMeasureId) {
          return i;
        }
      }
      return 0;
    }

    final defaultUom = detailsAddToCartEntity.productUnitOfMeasures
        ?.firstWhereOrNull((o) => o.isDefault == true);

    final alternateUnitsOfMeasureEnabled = context
            .watch<ProductDetailsBloc>()
            .productDetailDataEntity
            .productSettings
            ?.alternateUnitsOfMeasure ??
        false;

    final showMultipleUoM =
        detailsAddToCartEntity.productUnitOfMeasures != null &&
            detailsAddToCartEntity.productUnitOfMeasures!.length > 1 &&
            alternateUnitsOfMeasureEnabled;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showMultipleUoM
            ? Container(
                decoration: BoxDecoration(
                  color: OptiAppColors.backgroundInput,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListPickerWidget(
                      items: detailsAddToCartEntity.productUnitOfMeasures ?? [],
                      selectedIndex: getIndexOfUOM(
                          detailsAddToCartEntity.productUnitOfMeasures,
                          context
                              .read<ProductDetailsBloc>()
                              .productDetailDataEntity
                              .chosenUnitOfMeasure),
                      callback: onUnitOfMeasureSelec),
                ),
              )
            : () {
                if (detailsAddToCartEntity.productUnitOfMeasures != null &&
                    detailsAddToCartEntity.productUnitOfMeasures!.length == 1) {
                  return Text(
                      detailsAddToCartEntity.productUnitOfMeasures?.first
                              .unitOfMeasureTextDisplayWithQuantity ??
                          "",
                      style: OptiTextStyles.header3);
                } else if (defaultUom != null) {
                  return Text(
                      defaultUom.unitOfMeasureTextDisplayWithQuantity ?? "",
                      style: OptiTextStyles.header3);
                } else {
                  return const SizedBox.shrink();
                }
              }(),
      ],
    );
  }
}

class ProductDetailsAddCartTtitleSubTitleColumn extends StatelessWidget {
  final String title;
  final String value;

  ProductDetailsAddCartTtitleSubTitleColumn(this.title, this.value,
      {super.key});

  String getFormattedValue(String value) {
    if (value.isEmpty) {
      return 'N/A';
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(
          height: 5.0,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            getFormattedValue(value),
            style: OptiTextStyles.titleLargeHighLight,
          ),
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
          ? LocalizationConstants.signInForAddToCart.localized()
          : LocalizationConstants.signInForPricing.localized(),
      onPressed: () {
        AppRoute.login.navigateBackStack(context);
      },
    );
  }
}
