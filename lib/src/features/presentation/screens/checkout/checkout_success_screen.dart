import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/core/utils/date_provider_utils.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/checkout/review_order/review_order_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/line_item/line_item_widget.dart';
import 'package:flutter/material.dart';
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
    int itemCount = checkoutSuccessEntity.cart.cartLines?.length ?? 0;
    String itemText = itemCount == 1 ? 'Item' : 'Items';

    return Column(
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
            // XNG-Change: Convert API model to domain entity for consistent business logic
            final cartLineEntity = orderLine != null
                ? CartLineEntityMapper.toEntity(orderLine)
                : null;

            return LineItemWidget(
              productId: cartLineEntity?.productId,
              imagePath: cartLineEntity?.smallImagePath,
              shortDescription: cartLineEntity?.shortDescription,
              manufacturerItem: cartLineEntity?.manufacturerItem,
              productNumber: cartLineEntity?.erpNumber,
              discountMessage: cartLineEntity?.getDiscountMessage() ?? '',
              priceValueText: cartLineEntity?.getPriceValueText() ?? '',
              unitOfMeasureValueText: cartLineEntity?.getUnitOfMeasureText(),
              qtyOrdered: cartLineEntity?.qtyOrdered?.round().toString(),
              subtotalPriceText:
                  cartLineEntity?.pricing?.extendedUnitNetPriceDisplay,
              canEditQty: false,
              showViewAvailabilityByWarehouse: false,
              showViewQuantityPricing: false,
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: checkoutSuccessEntity.cart.cartLines?.length ?? 0,
        ),
      ],
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
              checkoutSuccessEntity.message ?? '',
              style: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 8.0),
            if (!isOrderApproval)
              Text(
                "We have received your order and have sent you an email confirmation to ${checkoutSuccessEntity.cart.shipTo?.email}",
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
                "${isOrderApproval ? '${LocalizationConstants.orderDate.localized()}:' : 'Order Placed:'} ${formatDateByLocale(checkoutSuccessEntity.cart.orderDate!)}",
                style: OptiTextStyles.body,
              ),
            if (checkoutSuccessEntity.cart.orderDate != null)
              const SizedBox(height: 8.0),
            if (checkoutSuccessEntity.cart.fulfillmentMethod
                .equalsIgnoreCase(ShippingOption.ship.name))
              Text(
                "Delivery Method: ${checkoutSuccessEntity.cart.carrier?.description}   ${checkoutSuccessEntity.cart.shipVia?.description}",
                style: OptiTextStyles.body,
              ),
            if (isOrderApproval &&
                !checkoutSuccessEntity.cart.status.isNullOrEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                "${LocalizationConstants.status.localized()}: ${checkoutSuccessEntity.cart.status ?? ''}",
              ),
            ],
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
