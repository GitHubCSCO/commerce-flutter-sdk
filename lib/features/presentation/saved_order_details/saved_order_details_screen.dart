import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/components/two_texts_row.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order_details/saved_order_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SavedOrderDetailsScreen extends StatelessWidget {
  final String cartId;
  final void Function() refreshSavedOrders;

  const SavedOrderDetailsScreen({
    super.key,
    required this.cartId,
    required this.refreshSavedOrders,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<SavedOrderDetailsCubit>()..loadCart(cartId: cartId),
      child: OrderDetailsPage(refreshSavedOrders: refreshSavedOrders),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  final void Function() refreshSavedOrders;

  const OrderDetailsPage({super.key, required this.refreshSavedOrders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        centerTitle: false,
        actions: const [
          _OptionsMenu(),
        ],
        title: const Text(LocalizationConstants.savedOrderDetails),
      ),
      body: BlocConsumer<SavedOrderDetailsCubit, SavedOrderDetailsState>(
        listener: (context, state) {
          if (state.status == OrderStatus.addToCartLoading ||
              state.status == OrderStatus.deleteCartLoading) {
            showPleaseWait(context);
          }

          if (state.status == OrderStatus.addToCartSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            context.read<CartCountCubit>().onCartItemChange();
            refreshSavedOrders();
            CustomSnackBar.showSnackBarMessage(
              context,
              SiteMessageConstants.defaultValueAddToCartSuccess,
            );
            context.pop();
          }

          if (state.status == OrderStatus.addToCartFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomSnackBar.showSnackBarMessage(
              context,
              SiteMessageConstants.defaultValueAddToCartFail,
            );
          }

          if (state.status == OrderStatus.deleteCartSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            refreshSavedOrders();
            context.pop();
          }

          if (state.status == OrderStatus.deleteCartFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomSnackBar.showSnackBarMessage(
              context,
              SiteMessageConstants.defaultValueDeleteCartFail,
            );
          }
        },
        builder: (context, state) {
          if (state.status == OrderStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == OrderStatus.failure) {
            return const Center(
              child: Text('Failed to load saved order details'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _SavedOrderInfoWidget(
                          shipToText: context
                              .watch<SavedOrderDetailsCubit>()
                              .shipToLabel,
                          orderDateText:
                              context.watch<SavedOrderDetailsCubit>().orderDate,
                          subTotalCount: state.cart.cartLines?.length ?? 0,
                          subtotalText: context
                              .watch<SavedOrderDetailsCubit>()
                              .orderSubTotalDisplay,
                        ),
                        _SavedOrderProductsSectionWidget(
                          cartLines: state.cart.cartLines ?? [],
                        ),
                      ],
                    ),
                  ),
                ),
                OrderBottomSectionWidget(
                  actions: [
                    SecondaryButton(
                      child: const Text(LocalizationConstants.deleteSavedOrder),
                      onPressed: () {
                        confirmDialog(
                          context: context,
                          message: LocalizationConstants
                              .deleteSavedOrderConfirmMessage,
                          onConfirm: () async {
                            await context
                                .read<SavedOrderDetailsCubit>()
                                .deleteSavedOrders();
                          },
                        );
                      },
                    ),
                    PrimaryButton(
                      text: LocalizationConstants.placeSavedOrder,
                      onPressed: () async {
                        await context
                            .read<SavedOrderDetailsCubit>()
                            .placeOrder();
                      },
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _OptionsMenu extends StatelessWidget {
  const _OptionsMenu();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedOrderDetailsCubit, SavedOrderDetailsState>(
      builder: (context, state) {
        final websitePath =
            'redirectto/SavedOrderDetailPage?cartid=${state.cart.id ?? ''}';
        return BottomMenuWidget(
          websitePath: websitePath,
        );
      },
    );
  }
}

class _SavedOrderInfoWidget extends StatelessWidget {
  final String? shipToText;
  final String? orderDateText;
  final int? subTotalCount;
  final String? subtotalText;

  const _SavedOrderInfoWidget({
    this.shipToText,
    this.orderDateText,
    this.subTotalCount,
    this.subtotalText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OptiAppColors.backgroundWhite,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!orderDateText.isNullOrEmpty) ...[
            TwoTextsRow(
              label: LocalizationConstants.orderDate,
              value: orderDateText!,
              textStyle: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 20),
          ],
          if (!subtotalText.isNullOrEmpty) ...[
            TwoTextsRow(
              label:
                  '${LocalizationConstants.subtotal} (${subTotalCount ?? 0})',
              value: subtotalText!,
              textStyle: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 20)
          ],
          BillingAddressWidget(
            companyName:
                context.watch<SavedOrderDetailsCubit>().billingCompanyName,
            fullAddress:
                '${context.watch<SavedOrderDetailsCubit>().billingFullAddress ?? ''}\n${context.watch<SavedOrderDetailsCubit>().billingCityStatePostalCode ?? ''}',
          ),
          const SizedBox(height: 20),
          ShippingAddressWidget(
            companyName:
                context.watch<SavedOrderDetailsCubit>().shippingCompanyName,
            fullAddress:
                '${context.watch<SavedOrderDetailsCubit>().shippingFullAddress ?? ''}\n${context.watch<SavedOrderDetailsCubit>().shippingCityStatePostalCode ?? ''}',
          ),
        ],
      ),
    );
  }
}

class _SavedOrderProductsSectionWidget extends StatelessWidget {
  final List<CartLine> cartLines;

  const _SavedOrderProductsSectionWidget({
    required this.cartLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
              .copyWith(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocalizationConstants.products,
                style: OptiTextStyles.titleLarge,
              ),
              const SizedBox(width: 8),
              Text(
                '(${cartLines.length} item)',
                style: OptiTextStyles.body,
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final cartLine = cartLines[index];
            final cartLineEntity = CartLineEntityMapper().toEntity(cartLine);
            return LineItemWidget(
              productId: cartLineEntity.id,
              imagePath: cartLineEntity.smallImagePath,
              shortDescription: cartLineEntity.shortDescription,
              manufacturerItem: cartLineEntity.manufacturerItem,
              productNumber: cartLineEntity.getProductNumber(),
              discountMessage:
                  cartLineEntity.pricing?.getDiscountValue(),
              priceValueText: cartLineEntity.updatePriceValueText(),
              unitOfMeasureValueText:
                  cartLineEntity.updateUnitOfMeasureValueText(),
              qtyOrdered: cartLineEntity.qtyOrdered?.toInt().toString(),
              subtotalPriceText: cartLineEntity.updateSubtotalPriceValueText(),
              canEditQty: false,
              showViewAvailabilityByWarehouse: false,
              showViewQuantityPricing: false,
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: cartLines.length,
        )
      ],
    );
  }
}
