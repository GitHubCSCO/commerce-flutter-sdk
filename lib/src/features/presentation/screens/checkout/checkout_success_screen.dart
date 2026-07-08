import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/custom_dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/checkout/checkout_confirmation/checkout_confirmation_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/checkout/review_order/review_order_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/order_details_body_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class CheckoutSuccessEntity {
  final Cart cart;
  final String orderNumber;
  final bool isVmiCheckout;
  final bool isOrderApproval;
  final ReviewOrderEntity? reviewOrderEntity;
  final String? message;
  final bool showSavingsAmount;
  final bool showSavingsPercent;

  const CheckoutSuccessEntity({
    required this.orderNumber,
    required this.isVmiCheckout,
    required this.cart,
    this.reviewOrderEntity,
    this.isOrderApproval = false,
    this.message,
    this.showSavingsAmount = true,
    this.showSavingsPercent = true,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'orderNumber': orderNumber,
      'isVmiCheckout': isVmiCheckout,
      'isOrderApproval': isOrderApproval,
      'cart': cart.toJson(),
      'reviewOrderEntity': reviewOrderEntity?.toJson(),
      'message': message,
      'showSavingsAmount': showSavingsAmount,
      'showSavingsPercent': showSavingsPercent,
    };
  }

  factory CheckoutSuccessEntity.fromJson(Map<String, dynamic> json) {
    return CheckoutSuccessEntity(
      orderNumber: json['orderNumber'],
      isVmiCheckout: json['isVmiCheckout'],
      isOrderApproval: json['isOrderApproval'],
      cart: Cart.fromJson(json['cart']),
      reviewOrderEntity: json['reviewOrderEntity'] != null
          ? ReviewOrderEntity.fromJson(json['reviewOrderEntity'])
          : null,
      message: json['message'],
      showSavingsAmount: json['showSavingsAmount'] ?? true,
      showSavingsPercent: json['showSavingsPercent'] ?? true,
    );
  }
}

class CheckoutSuccessScreen extends StatelessWidget {
  final CheckoutSuccessEntity checkoutSuccessEntity;

  const CheckoutSuccessScreen({super.key, required this.checkoutSuccessEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocalizationConstants.orderConfirmation.localized()),
        ),
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ReviewOrderCubit>(
                  create: (context) => sl<ReviewOrderCubit>()),
              BlocProvider<CheckoutConfirmationCubit>(
                  create: (context) => sl<CheckoutConfirmationCubit>()
                    ..loadOrderStatusMappings(
                        checkoutSuccessEntity.cart.status)),
            ],
            child: CheckoutSuccessPage(
              checkoutSuccessEntity: checkoutSuccessEntity,
            ),
          ),
        ));
  }
}

class CheckoutSuccessPage extends StatelessWidget {
  final CheckoutSuccessEntity checkoutSuccessEntity;

  const CheckoutSuccessPage({super.key, required this.checkoutSuccessEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.backgroundGray,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: _buildOrderSuccessInfoWidget(
                      context,
                      isOrderApproval: checkoutSuccessEntity.isOrderApproval,
                    ),
                  ),
                  _buildOrderItemSummaryWidget(context),
                  if (checkoutSuccessEntity.reviewOrderEntity != null)
                    ReviewOrderWidget(
                      reviewOrderEntity:
                          checkoutSuccessEntity.reviewOrderEntity!,
                      isOrderApproval: checkoutSuccessEntity.isOrderApproval,
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          OrderBottomSectionWidget(actions: [
            BlocConsumer<CheckoutConfirmationCubit, CheckoutConfirmationState>(
              listener: (context, state) {
                if (state is CheckoutConfirmationSuccess) {
                  CustomSnackBar.showSnackBarMessage(
                    context,
                    LocalizationConstants
                        .orderCancellationRequestSentSuccessfully
                        .localized(),
                  );
                } else if (state is CheckoutConfirmationFailure) {
                  CustomSnackBar.showSnackBarMessage(
                    context,
                    LocalizationConstants.somethingWentWrong.localized(),
                  );
                }
              },
              builder: (context, state) {
                var isEnabled = false;

                switch (state) {
                  case CheckoutConfirmationInitial():
                  case CheckoutConfirmationLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case CheckoutConfirmationLoaded():
                    isEnabled = state.isCancelEnabled;
                  case CheckoutConfirmationSuccess():
                    isEnabled = false;
                  case CheckoutConfirmationFailure():
                    isEnabled = state.isCancelEnabled;
                }

                return Visibility(
                  visible: isEnabled,
                  child: TertiaryBlackButton(
                    isEnabled: isEnabled,
                    text: LocalizationConstants.cancelOrder.localized(),
                    onPressed: () {
                      showCancelOrderAlert(context, onDismissAlert: () {
                        unawaited(context
                            .read<CheckoutConfirmationCubit>()
                            .cancelOrder(checkoutSuccessEntity.orderNumber));
                      });
                    },
                  ),
                );
              },
            ),
            PrimaryButton(
              text: checkoutSuccessEntity.isVmiCheckout
                  ? LocalizationConstants.backToVmiHome.localized()
                  : LocalizationConstants.continueShopping.localized(),
              onPressed: () async {
                if (checkoutSuccessEntity.isVmiCheckout) {
                  AppRoute.vmi.navigate(context);
                } else {
                  AppRoute.shop.navigate(context);
                }
              },
            ),
          ])
        ],
      ),
    );
  }

  Widget _buildOrderItemSummaryWidget(BuildContext context) {
    var itemCount = checkoutSuccessEntity.cart.cartLines?.length ?? 0;
    var itemText = itemCount == 1 ? 'Item' : 'Items';

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Text(
              "${LocalizationConstants.orderSummary.localized()} ($itemCount $itemText)",
              textAlign: TextAlign.start,
              style: context.text.subtitle,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final orderLine = checkoutSuccessEntity.cart.cartLines?[index];
              return LineItemWidget(
                productId: orderLine?.productId,
                imagePath: orderLine?.smallImagePath,
                shortDescription: orderLine?.shortDescription,
                manufacturerItem: orderLine?.manufacturerItem,
                productNumber: orderLine?.erpNumber,
                discountMessage: (orderLine?.pricing?.unitNetPrice == 0)
                    ? ''
                    : (DiscountValueConverter().convert(
                              orderLine,
                              showSavingsAmount:
                                  checkoutSuccessEntity.showSavingsAmount,
                              showSavingsPercent:
                                  checkoutSuccessEntity.showSavingsPercent,
                            ) ??
                            '')
                        .toString(),
                priceValueText: orderLine?.pricing?.unitNetPriceDisplay ?? '',
                unitOfMeasureValueText:
                    orderLine?.unitOfMeasureDisplay.isNullOrEmpty == false
                        ? ' / ${orderLine?.unitOfMeasureDisplay}'
                        : null,
                qtyOrdered: orderLine?.qtyOrdered?.round().toString(),
                subtotalPriceText:
                    orderLine?.pricing?.extendedUnitNetPriceDisplay,
                canEditQty: false,
                showViewAvailabilityByWarehouse: false,
                showViewQuantityPricing: false,
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: checkoutSuccessEntity.cart.cartLines?.length ?? 0,
          ),
<<<<<<< HEAD
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          )
        ],
      ),
=======
        ],
      )
>>>>>>> 459e4bd0 (merge conflicts)
    );
  }

  Widget _buildOrderSuccessInfoWidget(BuildContext context,
      {bool isOrderApproval = false}) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.successBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgAssetImage(
                  assetName: AssetConstants.iconMark,
                  semanticsLabel: 'success icon',
                  fit: BoxFit.fitWidth,
                  color: context.colors.successColor,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              checkoutSuccessEntity.message ?? '',
              style: context.text.subtitle,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    checkoutSuccessEntity.orderNumber,
                    style: context.text.titleLarge,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(width: 8.0),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.backgroundInput,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () async {
                        try {
                          await Clipboard.setData(
                            ClipboardData(
                              text: checkoutSuccessEntity.orderNumber,
                            ),
                          );
                          await HapticFeedback.mediumImpact();
                          CustomSnackBar.showSnackBarMessage(
                            context,
                            LocalizationConstants.orderNumberCopiedToClipboard
                                .localized(),
                          );
                        } catch (e) {
                          CustomSnackBar.showSnackBarMessage(
                            context,
                            LocalizationConstants
                                .failedToCopyOrderNumberToClipboard
                                .localized(),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgAssetImage(
                          assetName: AssetConstants.iconCopy,
                          semanticsLabel: 'copy icon',
                          fit: BoxFit.fitWidth,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (!isOrderApproval) ...{
              const SizedBox(height: 16.0),
              Text(
                "We have sent you an email confirmation to ${checkoutSuccessEntity.cart.shipTo?.email}",
                style: context.text.bodySmall,
                textAlign: TextAlign.center,
              ),
            },
            if (isOrderApproval &&
                !checkoutSuccessEntity.cart.status.isNullOrEmpty) ...[
              const SizedBox(height: 16.0),
              Text(
                "${LocalizationConstants.status.localized()}: ${checkoutSuccessEntity.cart.status ?? ''}",
              ),
            ],
            const SizedBox(height: 16.0),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
