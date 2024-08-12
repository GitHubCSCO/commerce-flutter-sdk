import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/components/two_texts_row.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order_details/saved_order_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order_handler/saved_order_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/cart_order_products_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SavedOrderDetailsScreen extends StatelessWidget {
  final String cartId;

  const SavedOrderDetailsScreen({
    super.key,
    required this.cartId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<SavedOrderDetailsCubit>()..loadCart(cartId: cartId),
      child: const OrderDetailsPage(),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

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
        title: Text(LocalizationConstants.savedOrderDetails.localized()),
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
            context.read<SavedOrderHandlerCubit>().shouldRefreshSavedOrder();
            CustomSnackBar.showSnackBarMessage(
              context,
              state.errorMessage ?? '',
            );
            context.pop();
          }

          if (state.status == OrderStatus.addToCartFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomSnackBar.showSnackBarMessage(
              context,
              state.errorMessage ?? '',
            );
          }

          if (state.status == OrderStatus.deleteCartSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            context.read<SavedOrderHandlerCubit>().shouldRefreshSavedOrder();
            context.pop();
          }

          if (state.status == OrderStatus.deleteCartFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomSnackBar.showSnackBarMessage(
              context,
              state.errorMessage ?? '',
            );
          }

          if (state.status == OrderStatus.lineItemAddToCartComplete) {
            context.read<CartCountCubit>().onCartItemChange();
            _displaySnackBarMessageFromCubit(context);
          }

          if (state.status == OrderStatus.lineItemAddToCartQtyAdjusted) {
            context.read<CartCountCubit>().onCartItemChange();
            confirmDialog(
              context: context,
              message: context
                  .read<SavedOrderDetailsCubit>()
                  .quantityAdjustedMessage,
              onConfirm: () {
                _displaySnackBarMessageFromCubit(context);
              },
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
                          hidePricingEnable: state.hidePricingEnable,
                        ),
                        CartOrderProductsSectionWidget(
                          cartLines: context
                              .read<SavedOrderDetailsCubit>()
                              .getCartLines(),
                          hidePricingEnable: state.hidePricingEnable,
                          hideInventoryEnable: state.hideInventoryEnable,
                          onAddToList: ({required cartLineEntity}) {
                            WishListCallbackHelper.addItemsToWishList(
                              context,
                              addToCartCollection: WishListAddToCartCollection(
                                wishListLines: [
                                  AddCartLine(
                                    productId: cartLineEntity.productId,
                                    qtyOrdered: 1,
                                    unitOfMeasure: cartLineEntity.unitOfMeasure,
                                  ),
                                ],
                              ),
                              onAddedToCart: null,
                            );
                          },
                          onAddToCart: ({required cartLineEntity}) {
                            void doAddToCart() {
                              final addCartLine = AddCartLine(
                                productId: cartLineEntity.productId,
                                qtyOrdered: 1,
                                sectionOptions: [],
                                unitOfMeasure: cartLineEntity.unitOfMeasure,
                              );

                              context
                                  .read<SavedOrderDetailsCubit>()
                                  .addToCart(addCartLine: addCartLine);
                            }

                            if (cartLineEntity.canAddToCart != true) {
                              confirmDialog(
                                context: context,
                                title: LocalizationConstants.productsOutOfStock
                                    .localized(),
                                message: LocalizationConstants
                                    .productsOutOfStockMessage
                                    .localized(),
                                onConfirm: doAddToCart,
                              );
                              return;
                            }

                            doAddToCart();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                OrderBottomSectionWidget(
                  actions: [
                    SecondaryButton(
                      text: LocalizationConstants.deleteSavedOrder.localized(),
                      onPressed: () {
                        confirmDialog(
                          context: context,
                          message: LocalizationConstants
                              .deleteSavedOrderConfirmMessage
                              .localized(),
                          onConfirm: () async {
                            await context
                                .read<SavedOrderDetailsCubit>()
                                .deleteSavedOrders();
                          },
                        );
                      },
                    ),
                    PrimaryButton(
                      text: LocalizationConstants.placeSavedOrder.localized(),
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
        final websitePath = WebsitePaths.savedOrderDetailsWebsitePath
            .format([state.cart.id ?? '']);
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
  final bool? hidePricingEnable;

  const _SavedOrderInfoWidget({
    this.shipToText,
    this.orderDateText,
    this.subTotalCount,
    this.subtotalText,
    this.hidePricingEnable,
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
              label: LocalizationConstants.orderDate.localized(),
              value: orderDateText!,
              textStyle: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 20),
          ],
          if (!(hidePricingEnable ?? false) && !subtotalText.isNullOrEmpty) ...[
            TwoTextsRow(
              label:
                  '${LocalizationConstants.subtotal.localized()} (${subTotalCount ?? 0})',
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

void _displaySnackBarMessageFromCubit(BuildContext context) {
  CustomSnackBar.showSnackBarMessage(
    context,
    context.read<SavedOrderDetailsCubit>().addCartLineToCartMessage,
  );
}
