import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
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
import 'package:commerce_flutter_app/features/presentation/cubit/order_approval_details/order_approval_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/cart_order_products_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderApprovalDetailsScreen extends StatelessWidget {
  final String cartId;
  final void Function() refreshOrderApprovals;
  const OrderApprovalDetailsScreen({
    super.key,
    required this.cartId,
    required this.refreshOrderApprovals,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<OrderApprovalDetailsCubit>()..loadCart(cartId: cartId),
      child: OrderApprovalDetailsPage(
        refreshOrderApprovals: refreshOrderApprovals,
      ),
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
            : const Text(LocalizationConstants.orderApproval),
      ),
      body: BlocConsumer<OrderApprovalDetailsCubit, OrderApprovalDetailsState>(
        listener: (context, state) {
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
              LocalizationConstants.orderApproved,
            );
            context.pop();
          }

          if (state.status == OrderStatus.addToCartFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            CustomSnackBar.showSnackBarMessage(
              context,
              SiteMessageConstants.defaultVaLueOrderApprovalBadRequest,
            );
          }

          if (state.status == OrderStatus.deleteCartSuccess) {
            Navigator.of(context, rootNavigator: true).pop();
            refreshOrderApprovals();
            CustomSnackBar.showSnackBarMessage(
              context,
              LocalizationConstants.orderDeleted,
            );
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
              child: Text('Failed to load order approval details'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                          estimatedShippingTitleLabel:
                              LocalizationConstants.shippingHandling,
                          estimatedShippingValueLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .shippingValue,
                          estiamatedTotalTitleLabel:
                              LocalizationConstants.total,
                          estimatedTotalValueLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .totalValue,
                          estitamatedTaxTitleLabel: LocalizationConstants.tax,
                        ),
                        _OrderApprovalInfoWidget(
                          orderStatusLabel: LocalizationConstants.status,
                          orderStatusValueLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .statusValue,
                          poTitleLabel: LocalizationConstants.pONumberSign,
                          poValueLabel: context
                              .watch<OrderApprovalDetailsCubit>()
                              .poValue,
                          orderDateValueLabel: LocalizationConstants.orderDate,
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
                        ),
                        CartOrderProductsSectionWidget(
                          cartLines: state.cart.cartLines ?? [],
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
                        child: const Text(LocalizationConstants.deleteOrder),
                        onPressed: () {
                          confirmDialog(
                            context: context,
                            message: '${LocalizationConstants.deleteOrder}?',
                            onConfirm: () async {
                              await context
                                  .read<OrderApprovalDetailsCubit>()
                                  .deleteOrder();
                            },
                          );
                        },
                      ),
                      PrimaryButton(
                        text: LocalizationConstants.approveOrder,
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

  const _OrderApprovalInfoWidget({
    required this.orderStatusValueLabel,
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
  });

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
            LocalizationConstants.orderInformation,
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
              ShippingAddressWidget(
                companyName: stCompanyNameLabel,
                fullAddress: '$stAddressLabel\n$stPostalCodeLabel',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
