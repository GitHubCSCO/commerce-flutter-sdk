import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/promotion_type.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin BaseCheckout {
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(LocalizationConstants.checkout.localized()),
      backgroundColor: Colors.white,
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocalizationConstants.cancel.localized(),
              style: OptiTextStyles.subtitleHighlight,
            ),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  BillingShippingEntity prepareBillingShippingEntity(CheckoutDataLoaded state) {
    return BillingShippingEntity(
      billTo: state.billToAddress,
      shipTo: state.shipToAddress,
      warehouse: state.wareHouse,
      shippingMethod:
          (state.shippingMethod.equalsIgnoreCase(ShippingOption.pickUp.name)
              ? ShippingOption.pickUp
              : ShippingOption.ship),
      carriers: state.cart.carriers,
      cartSettings: state.cartSettings,
      selectedCarrier: state.selectedCarrier,
      selectedService: state.selectedService,
      requestDeliveryDate: state.requestDeliveryDate,
      allowCreateNewShipToAddress: state.allowCreateNewShipToAddress,
      requestDateWarningMessage: state.requestDateWarningMessage,
    );
  }

  BillingShippingEntity prepareVmiBillingShippingEntity(
      CheckoutDataLoaded state) {
    return BillingShippingEntity(
      billTo: state.billToAddress,
      shipTo: state.shipToAddress,
      warehouse: state.wareHouse,
      shippingMethod:
          (state.shippingMethod.equalsIgnoreCase(ShippingOption.pickUp.name)
              ? ShippingOption.pickUp
              : ShippingOption.ship),
      carriers: state.cart.carriers,
      cartSettings: state.cartSettings,
      selectedCarrier: state.selectedCarrier,
      selectedService: state.selectedService,
      requestDeliveryDate: state.requestDeliveryDate,
      allowCreateNewShipToAddress: state.allowCreateNewShipToAddress,
    );
  }

  PaymentSummaryEntity preparePaymentSummaryEntity(CheckoutDataLoaded state) {
    return PaymentSummaryEntity(
        cart: state.cart,
        cartSettings: state.cartSettings,
        promotions: state.promotions,
        isCustomerOrderApproval: false);
  }

  ReviewOrderEntity prepareReviewOrderEntity(
      CheckoutDataLoaded state, BuildContext context) {
    return ReviewOrderEntity(
        billTo: state.billToAddress,
        shipTo: state.shipToAddress,
        warehouse: state.wareHouse,
        shippingMethod:
            (state.shippingMethod.equalsIgnoreCase(ShippingOption.pickUp.name)
                ? ShippingOption.pickUp
                : ShippingOption.ship),
        carriers: state.cart.carriers,
        cartSettings: state.cartSettings,
        paymentMethod: context.read<CheckoutBloc>().cart!.paymentMethod,
        selectedCarrier: state.selectedCarrier,
        selectedService: state.selectedService,
        requestDeliveryDate: state.requestDeliveryDate,
        allowCreateNewShipToAddress: state.allowCreateNewShipToAddress,
        orderNotes: context.read<CheckoutBloc>().getOrderNote());
  }

  Widget buildSummary(
      Cart cart, PromotionCollectionModel? promotionCollectionModel) {
    String promotionInfo;
    String promotionValue;
    Promotion? lastPromotion;
    Promotion? promotion;

    var promotions = promotionCollectionModel?.promotions
        ?.where((x) =>
            (x.promotionResultType?.toLowerCase() ==
                    PromotionType.amountofforder.name ||
                x.promotionResultType?.toLowerCase() ==
                    PromotionType.percentofforder.name) &&
            x.amount != 0)
        .toList();

    if (promotions == null || promotions.isEmpty) {
      promotionInfo = '';
      promotionValue = '';
    } else {
      lastPromotion = promotions.last;
      promotion = promotions.first;
    }

    var info = '';

    if (promotions != null && promotions.length > 1) {
      info = LocalizationConstants.promoCodesMore
          .localized()
          .format([lastPromotion?.name, promotions.length - 1]);
    } else {
      info = LocalizationConstants.promoCodes
          .localized()
          .format([lastPromotion?.name]);
    }

    var amount = promotions?.fold(
      0.0, // Start with a double value
      (previousValue, element) =>
          previousValue + (element.amount?.toDouble() ?? 0.0),
    );

    var currencySymbol = '';

    if (promotion != null &&
        promotion.amountDisplay != null &&
        promotion.amountDisplay!.isNotEmpty) {
      currencySymbol = promotion.amountDisplay!.substring(0, 1);
    }

    promotionInfo = info;
    promotionValue = '- $currencySymbol${amount ?? 0.toStringAsFixed(2)}';

    List<Widget> list = [];

    if (promotion != null && lastPromotion != null) {
      list.add(
          _buildRow(promotionInfo, promotionValue, OptiTextStyles.bodyFade)!);
    }

    list.add(_buildRow(LocalizationConstants.subtotal.localized(),
        cart.orderGrandTotalDisplay ?? '', OptiTextStyles.subtitleHighlight)!);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: list),
    );
  }

  final _notesController = TextEditingController();

  Widget buildOrderNote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Input(
        label: LocalizationConstants.orderNotes.localized(),
        controller: _notesController,
      ),
    );
  }

  Widget? _buildRow(String title, String body, TextStyle textStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: textStyle,
              ),
            ),
          ),
          Text(
            body,
            textAlign: TextAlign.start,
            style: textStyle,
          )
        ],
      );
    }
  }

  void showAlert(BuildContext context,
      {String? title, String? message, bool? isPaymentFailed, String? cartId}) {
    displayDialogWidget(
        context: context,
        title: title,
        message: message,
        actions: [
          DialogPlainButton(
            onPressed: () {
              final id = cartId ?? context.read<CheckoutBloc>().cart?.id;
              if (isPaymentFailed == true) {
                context
                    .read<CheckoutBloc>()
                    .add(UpdateCartPaymentFailedEvent(id ?? ''));
                context
                    .read<PaymentDetailsBloc>()
                    .add(LoadPaymentDetailsEvent(cartId: id ?? ''));
              } else {
                context
                    .read<CheckoutBloc>()
                    .add(LoadCheckoutEvent(cartId: id ?? ''));
              }
              Navigator.of(context).pop();
            },
            child: Text(
              LocalizationConstants.oK.localized(),
              textAlign: TextAlign.start,
            ),
          ),
        ]);
  }
}
