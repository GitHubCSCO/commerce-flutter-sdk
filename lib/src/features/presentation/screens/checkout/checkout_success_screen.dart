import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/checkout/review_order/review_order_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutSuccessEntity {
  final Cart cart;
  final String orderNumber;
  final bool isVmiCheckout;
  final bool isOrderApproval;
  final ReviewOrderEntity? reviewOrderEntity;
  final String? message;

  const CheckoutSuccessEntity({
    required this.orderNumber,
    required this.isVmiCheckout,
    required this.cart,
    this.reviewOrderEntity,
    this.isOrderApproval = false,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'orderNumber': orderNumber,
      'isVmiCheckout': isVmiCheckout,
      'isOrderApproval': isOrderApproval,
      'cart': cart.toJson(),
      'reviewOrderEntity': reviewOrderEntity?.toJson(),
      'message': message,
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider<ReviewOrderCubit>(
                create: (context) => sl<ReviewOrderCubit>()),
          ],
          child: CheckoutSuccessPage(
            checkoutSuccessEntity: checkoutSuccessEntity,
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
      color: OptiAppColors.backgroundGray,
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
                  _buildOrderItemSummaryWidget(),
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
          ListInformationBottomSubmitWidget(actions: [
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

  Widget _buildOrderItemSummaryWidget() {
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
              style: OptiTextStyles.subtitle,
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
                    : (DiscountValueConverter().convert(orderLine) ?? '')
                        .toString(),
                priceValueText: orderLine?.pricing?.unitNetPriceDisplay ?? '',
                unitOfMeasureValueText: orderLine?.unitOfMeasureDisplay != null
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          )
        ],
      ),
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: OptiAppColors.successBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgAssetImage(
                  assetName: AssetConstants.iconMark,
                  semanticsLabel: 'success icon',
                  fit: BoxFit.fitWidth,
                  color: OptiAppColors.successColor,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              checkoutSuccessEntity.message ?? '',
              style: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    checkoutSuccessEntity.orderNumber,
                    style: OptiTextStyles.titleLarge,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(width: 8.0),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: OptiAppColors.backgroundInput,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        unawaited(Clipboard.setData(
                          ClipboardData(
                              text: checkoutSuccessEntity.orderNumber),
                        ).then((_) {
                          HapticFeedback.mediumImpact();
                          CustomSnackBar.showSnackBarMessage(
                            context,
                            LocalizationConstants.orderNumberCopiedToClipboard
                                .localized(),
                          );
                        }));
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
                style: OptiTextStyles.bodySmall,
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
