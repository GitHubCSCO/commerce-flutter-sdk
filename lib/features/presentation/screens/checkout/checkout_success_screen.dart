import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/review_order/review_order_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutSuccessEntity {
  final Cart cart;
  final String orderNumber;
  final bool isVmiCheckout;
  final bool isOrderApproval;
  final ReviewOrderEntity? reviewOrderEntity;

  const CheckoutSuccessEntity({
    required this.orderNumber,
    required this.isVmiCheckout,
    required this.cart,
    this.reviewOrderEntity,
    this.isOrderApproval = false,
  });
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
                      isOrderApproval: checkoutSuccessEntity.isOrderApproval,
                    ),
                  ),
                  _buildOrderItemSummaryWidget(),
                  if (checkoutSuccessEntity.reviewOrderEntity != null)
                    ReviewOrderWidget(
                        reviewOrderEntity:
                            checkoutSuccessEntity.reviewOrderEntity!),
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
    int itemCount = checkoutSuccessEntity.cart.cartLines?.length ?? 0;
    String itemText = itemCount == 1 ? 'Item' : 'Items';

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
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
        ],
      ),
    );
  }

  Widget _buildOrderSuccessInfoWidget({bool isOrderApproval = false}) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isOrderApproval
                  ? SiteMessageConstants.defaultVaLueOrderApprovalOrderPlaced
                  : "Thank you for your order!",
              style: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 8.0),
            if (!isOrderApproval)
              Text(
                "We have received your order and have sent you an email confirmation to  ${checkoutSuccessEntity.cart.shipTo?.email}",
                style: OptiTextStyles.bodySmall,
                textAlign: TextAlign.left,
              ),
            if (!isOrderApproval) const SizedBox(height: 8.0),
            Text(
              "Order Number ${checkoutSuccessEntity.orderNumber}",
              style: OptiTextStyles.titleLarge,
            ),
            const SizedBox(height: 8.0),
            if (checkoutSuccessEntity.cart.orderDate != null)
              Text(
                "Order Placed: ${DateFormat(CoreConstants.dateFormatString).format(checkoutSuccessEntity.cart.orderDate!)}",
                style: OptiTextStyles.body,
              ),
            if (checkoutSuccessEntity.cart.orderDate != null)
              const SizedBox(height: 8.0),
            Text(
              "Delivery Method: ${checkoutSuccessEntity.cart.carrier?.description}   ${checkoutSuccessEntity.cart.shipVia?.description}",
              style: OptiTextStyles.body,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
