import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/website_paths.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/two_texts_row.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_approval/order_approval_handler/order_approval_handler_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/order_approval_details/order_approval_details_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/cart_order_products_section_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderApprovalDetailsScreen extends StatelessWidget {
  final String cartId;
  const OrderApprovalDetailsScreen({
    super.key,
    required this.cartId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<OrderApprovalDetailsCubit>()..loadCart(cartId: cartId),
      child: Builder(builder: (context) {
        return BlocListener<OrderApprovalHandlerCubit,
            OrderApprovalHandlerState>(
          listener: (context, state) {
            if (state.status ==
                OrderApprovalHandlerStatus.shouldRefreshOrderApproval) {
              context
                  .read<OrderApprovalDetailsCubit>()
                  .loadCart(cartId: cartId);

              context.read<OrderApprovalHandlerCubit>().resetState();
            }
          },
          child: OrderApprovalDetailsPage(
            refreshOrderApprovals: context
                .read<OrderApprovalHandlerCubit>()
                .shouldRefreshOrderApproval,
          ),
        );
      }),
    );
  }
}

class OrderApprovalDetailsPage extends StatelessWidget {
  final void Function() refreshOrderApprovals;

  const OrderApprovalDetailsPage({
    super.key,
    required this.refreshOrderApprovals,
  });

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
        title: context.watch<OrderApprovalDetailsCubit>().state.status ==
                OrderStatus.success
            ? Text(
                context
                        .watch<OrderApprovalDetailsCubit>()
                        .state
                        .cart
                        .orderNumber ??
                    '',
              )
            : Text(LocalizationConstants.orderApproval.localized()),
      ),
      body: BlocConsumer<OrderApprovalDetailsCubit, OrderApprovalDetailsState>(
        listener: (context, state) async {
          if (state.status == OrderStatus.addToCartLoading ||
              state.status == OrderStatus.deleteCartLoading) {
            showPleaseWait(context);
          }

          if (state.status == OrderStatus.addToCartSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            context.read<CartCountCubit>().onCartItemChange();
            refreshOrderApprovals();
            CustomSnackBar.showSnackBarMessage(
              context,
              LocalizationConstants.orderApproved.localized(),
            );

            context.read<CartCountCubit>().onSelectCartTab();

            AppRoute.cart.navigate(context);
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
            refreshOrderApprovals();
            CustomSnackBar.showSnackBarMessage(
              context,
              LocalizationConstants.orderDeleted.localized(),
            );
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
                  .read<OrderApprovalDetailsCubit>()
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
              child: Text('Failed to load order approval details'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (!(state.hidePricingEnable ?? false))
                          _OrderApprovalHeaderWidget(
                            subtotalTitleLabel: context
                                .watch<OrderApprovalDetailsCubit>()
                                .subtotalTitle,
                            subtotalValueLabel: context
                                .watch<OrderApprovalDetailsCubit>()
                                .subtotalValue,
                            estimatedTaxValueLabel: context
                                .watch<OrderApprovalDetailsCubit>()
                                .taxValue,
                            estimatedShippingTitleLabel: LocalizationConstants
                                .shippingHandling
                                .localized(),
                            estimatedShippingValueLabel: context
                                .watch<OrderApprovalDetailsCubit>()
                                .shippingValue,
                            estiamatedTotalTitleLabel:
                                LocalizationConstants.total.localized(),
                            estimatedTotalValueLabel: context
                                .watch<OrderApprovalDetailsCubit>()
                                .totalValue,
                            estitamatedTaxTitleLabel:
                                LocalizationConstants.tax.localized(),
                          ),
                        _OrderApprovalInfoWidget(
                          orderStatusLabel:
                              LocalizationConstants.status.localized(),
                          orderStatusValueLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .statusValue,
                          poTitleLabel:
                              LocalizationConstants.pONumberSign.localized(),
                          poValueLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .poValue,
                          orderDateValueLabel:
                              LocalizationConstants.orderDate.localized(),
                          orderDateTitleLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .orderDateValue,
                          companyNameLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .billingCompanyTitle,
                          addressLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .billToAddressLines,
                          postalCodeLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .billToCityStatePostalCodeDisplay,
                          stCompanyNameLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .shippingCompanyTitle,
                          stAddressLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .shipToAddressLines,
                          stPostalCodeLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .shipToCityStatePostalCodeDisplay,
                          orderNotesValue: context
                                  .watch<OrderApprovalDetailsCubit>()
                                  .orderNotesValue ??
                              "",
                        ),
                        CartOrderProductsSectionWidget(
                          cartLines: context
                              .read<OrderApprovalDetailsCubit>()
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
                                  .read<OrderApprovalDetailsCubit>()
                                  .addToCart(
                                      addCartLine: addCartLine,
                                      productNumber:
                                          cartLineEntity.getProductNumber());
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
                Visibility(
                  visible:
                      !context.watch<OrderApprovalDetailsCubit>().hasApprover,
                  child: OrderBottomSectionWidget(
                    actions: [
                      SecondaryButton(
                        text: LocalizationConstants.deleteOrder.localized(),
                        onPressed: () {
                          confirmDialog(
                            context: context,
                            message:
                                '${LocalizationConstants.deleteOrder.localized()}?',
                            onConfirm: () async {
                              await context
                                  .read<OrderApprovalDetailsCubit>()
                                  .deleteOrder();
                            },
                          );
                        },
                      ),
                      PrimaryButton(
                        text: LocalizationConstants.approveOrder.localized(),
                        isEnabled: context
                            .watch<OrderApprovalDetailsCubit>()
                            .isApprovedButtonEnabled,
                        onPressed: () async {
                          await context
                              .read<OrderApprovalDetailsCubit>()
                              .approveOrder();
                        },
                      ),
                    ],
                  ),
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
    return BlocBuilder<OrderApprovalDetailsCubit, OrderApprovalDetailsState>(
      builder: (context, state) {
        final websitePath = WebsitePaths.orderApprovalDetailsWebsitePath
            .format([state.cart.id ?? '']);
        return BottomMenuWidget(
          websitePath: websitePath,
        );
      },
    );
  }
}

class _OrderApprovalHeaderWidget extends StatelessWidget {
  final String subtotalTitleLabel;
  final String subtotalValueLabel;
  final String estitamatedTaxTitleLabel;
  final String estimatedTaxValueLabel;
  final String estimatedShippingTitleLabel;
  final String estimatedShippingValueLabel;
  final String estiamatedTotalTitleLabel;
  final String estimatedTotalValueLabel;

  const _OrderApprovalHeaderWidget({
    required this.subtotalTitleLabel,
    required this.subtotalValueLabel,
    required this.estimatedTaxValueLabel,
    required this.estimatedShippingTitleLabel,
    required this.estimatedShippingValueLabel,
    required this.estiamatedTotalTitleLabel,
    required this.estimatedTotalValueLabel,
    required this.estitamatedTaxTitleLabel,
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
          if (subtotalValueLabel.isNotEmpty)
            TwoTextsRow(
              label: subtotalTitleLabel,
              value: subtotalValueLabel,
              textStyle: OptiTextStyles.subtitle,
            ),
          if (estimatedShippingValueLabel.isNotEmpty)
            TwoTextsRow(
              label: estimatedShippingTitleLabel,
              value: estimatedShippingValueLabel,
              textStyle: OptiTextStyles.body,
            ),
          if (estimatedTaxValueLabel.isNotEmpty)
            TwoTextsRow(
              label: estitamatedTaxTitleLabel,
              value: estimatedTaxValueLabel,
              textStyle: OptiTextStyles.body,
            ),
          const SizedBox(height: 10),
          if (estimatedTotalValueLabel.isNotEmpty)
            TwoTextsRow(
              label: estiamatedTotalTitleLabel,
              value: estimatedTotalValueLabel,
              textStyle: OptiTextStyles.subtitle,
            ),
        ],
      ),
    );
  }
}

class _OrderApprovalInfoWidget extends StatelessWidget {
  final String orderStatusLabel;
  final String orderStatusValueLabel;
  final String poTitleLabel;
  final String poValueLabel;
  final String orderDateValueLabel;
  final String orderDateTitleLabel;

  final String companyNameLabel;
  final String addressLabel;
  final String postalCodeLabel;

  final String stCompanyNameLabel;
  final String stAddressLabel;
  final String stPostalCodeLabel;

  final String orderNotesValue;

  const _OrderApprovalInfoWidget(
      {required this.orderStatusValueLabel,
      required this.poValueLabel,
      required this.orderDateTitleLabel,
      required this.orderStatusLabel,
      required this.poTitleLabel,
      required this.orderDateValueLabel,
      required this.companyNameLabel,
      required this.addressLabel,
      required this.postalCodeLabel,
      required this.stCompanyNameLabel,
      required this.stAddressLabel,
      required this.stPostalCodeLabel,
      required this.orderNotesValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
              .copyWith(bottom: 8),
          child: Text(
            LocalizationConstants.orderInformation.localized(),
            style: OptiTextStyles.titleLarge,
          ),
        ),
        Container(
          color: OptiAppColors.backgroundWhite,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TwoTextsRow(
                label: orderStatusLabel,
                value: orderStatusValueLabel,
                textStyle: OptiTextStyles.subtitle,
              ),
              TwoTextsRow(
                label: poTitleLabel,
                value: poValueLabel,
                textStyle: OptiTextStyles.body,
              ),
              TwoTextsRow(
                label: orderDateValueLabel,
                value: orderDateTitleLabel,
                textStyle: OptiTextStyles.body,
              ),
              const SizedBox(height: 20),
              BillingAddressWidget(
                companyName: companyNameLabel,
                fullAddress: '$addressLabel\n$postalCodeLabel',
              ),
              const SizedBox(height: 20),
              if (context
                  .watch<OrderApprovalDetailsCubit>()
                  .isFulfillmentMethodShip)
                ShippingAddressWidget(
                  companyName: stCompanyNameLabel,
                  fullAddress: '$stAddressLabel\n$stPostalCodeLabel',
                ),
              if (context
                  .watch<OrderApprovalDetailsCubit>()
                  .isFulfillmentMethodPickUp)
                PickupLocationWidget(
                  address: stCompanyNameLabel,
                  city: '$stAddressLabel\n$stPostalCodeLabel',
                ),
              const SizedBox(height: 20),
              if (orderNotesValue.isNotEmpty)
                OrderNotesWidget(orderNoteValue: orderNotesValue)
            ],
          ),
        ),
      ],
    );
  }
}

class OrderNotesWidget extends StatelessWidget {
  final String? orderNoteValue;

  const OrderNotesWidget({
    super.key,
    this.orderNoteValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationConstants.orderNotes.localized(),
          textAlign: TextAlign.start,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        if (!orderNoteValue.isNullOrEmpty)
          Text(
            orderNoteValue ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
      ],
    );
  }
}

void _displaySnackBarMessageFromCubit(BuildContext context) {
  CustomSnackBar.showSnackBarMessage(
    context,
    context.read<OrderApprovalDetailsCubit>().addCartLineToCartMessage,
  );
}
