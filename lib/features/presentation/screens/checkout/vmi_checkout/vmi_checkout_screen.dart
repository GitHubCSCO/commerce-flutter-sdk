import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/promo_code_cubit/promo_code_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/cart/cart_line_list.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/checkout/base_checkout.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/checkout/checkout_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/checkout/checkout_success_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/checkout/payment_details/checkout_payment_details.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VmiCheckoutEntity {
  final Cart cart;
  final ScanningMode scanningMode;

  VmiCheckoutEntity(this.cart, this.scanningMode);

  factory VmiCheckoutEntity.fromJson(Map<String, dynamic> json) {
    return VmiCheckoutEntity(
      Cart.fromJson(json['cart']),
      ScanningMode.fromJson(json['scanningMode']),
    );
  }

  Map<String, dynamic> toJson() => {
        'cart': cart.toJson(),
        'scanningMode': scanningMode.toJson(),
      };
}

class VmiCheckoutScreen extends StatelessWidget {
  final VmiCheckoutEntity vmiCheckoutEntity;

  const VmiCheckoutScreen({super.key, required this.vmiCheckoutEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutBloc>(
            create: (context) => sl<CheckoutBloc>()
              ..add(LoadCheckoutEvent(cart: vmiCheckoutEntity.cart))),
        BlocProvider<PromoCodeCubit>(create: (context) => sl<PromoCodeCubit>()),
        BlocProvider<ReviewOrderCubit>(
            create: (context) => sl<ReviewOrderCubit>()),
        BlocProvider<PaymentDetailsBloc>(
          create: (context) => sl<PaymentDetailsBloc>()
            ..add(LoadPaymentDetailsEvent(cart: vmiCheckoutEntity.cart)),
        ),
      ],
      child: VmiCheckoutPage(
          scanningMode: vmiCheckoutEntity.scanningMode,
          vmiCheckoutEntity: vmiCheckoutEntity),
    );
  }
}

class VmiCheckoutPage extends StatelessWidget with BaseCheckout {
  final ScanningMode scanningMode;
  final VmiCheckoutEntity vmiCheckoutEntity;

  VmiCheckoutPage(
      {super.key, required this.scanningMode, required this.vmiCheckoutEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (_, state) {
          if (state is CheckoutPlaceOrder) {
            AppRoute.checkoutSuccess.navigate(context,
                extra: CheckoutSuccessEntity(
                    orderNumber: state.orderNumber,
                    reviewOrderEntity: state.reviewOrderEntity,
                    isVmiCheckout: true,
                    cart: context.read<CheckoutBloc>().cart!));
          } else if (state is CheckoutPlaceOrderFailed) {
            showAlert(context,
                message: LocalizationConstants.orderFailed.localized());
          }
        },
        buildWhen: (previous, current) =>
            current is CheckoutInitial ||
            current is CheckoutLoading ||
            current is CheckoutDataLoaded,
        builder: (_, state) {
          return BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (_, state) {
              switch (state) {
                case CheckoutInitial():
                case CheckoutLoading():
                  return const Center(child: CircularProgressIndicator());
                case CheckoutDataLoaded():
                  final billingShippingEntity = BillingShippingEntity(
                    billTo: state.billToAddress,
                    shipTo: state.shipToAddress,
                    warehouse: state.wareHouse,
                    shippingMethod: (state.shippingMethod
                            .equalsIgnoreCase(ShippingOption.pickUp.name)
                        ? ShippingOption.pickUp
                        : ShippingOption.ship),
                    carriers: state.cart.carriers,
                    cartSettings: state.cartSettings,
                    selectedCarrier: state.selectedCarrier,
                    selectedService: state.selectedService,
                    requestDeliveryDate: state.requestDeliveryDate,
                    allowCreateNewShipToAddress:
                        state.allowCreateNewShipToAddress,
                  );

                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                if (state.cartWarningMsg.isNotEmpty)
                                  BuildCartErrorWidget(
                                      cartErrorMsg: state.cartWarningMsg),
                                buildSummary(state.cart, state.promotions),
                                BillingShippingWidget(
                                  billingShippingEntity: billingShippingEntity,
                                  onCallBack: _handleAddressSelectionCallBack,
                                  isVmiCheckout: true,
                                ),
                                CheckoutPaymentDetails(
                                    cart: context.read<CheckoutBloc>().cart!,
                                    isVmiCheckout: true,
                                    onCompleteCheckoutPaymentSection: () {
                                      context.read<CheckoutBloc>().add(
                                          SelectPaymentEvent(context
                                              .read<PaymentDetailsBloc>()
                                              .cart!
                                              .paymentOptions!));
                                      // context
                                      //     .read<ExpansionPanelCubit>()
                                      //     .onContinueClick();
                                    }),
                                buildOrderNote(),
                                const SizedBox(height: 8),
                                BlocProvider<CartContentBloc>(
                                  create: (context) => sl<CartContentBloc>(),
                                  child: CartLineWidgetList(
                                    oderNumber: context
                                        .read<CheckoutBloc>()
                                        .cart
                                        ?.orderNumber,
                                    showClearCart: false,
                                    cartLineEntities: context
                                        .read<CheckoutBloc>()
                                        .getCartLines(),
                                    onCartChangeCallBack: (context) {
                                      context.read<CheckoutBloc>().add(
                                          LoadCheckoutEvent(
                                              cart: vmiCheckoutEntity.cart));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            children: [
                              TertiaryButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                text: scanningMode == ScanningMode.count
                                    ? LocalizationConstants.backToCountInventory
                                        .localized()
                                    : LocalizationConstants.backToCreateOrder
                                        .localized(),
                              ),
                              const SizedBox(height: 4.0),
                              Visibility(
                                visible: context
                                    .watch<CheckoutBloc>()
                                    .checkoutButtonVisible,
                                child: PrimaryButton(
                                  onPressed: () {
                                    _handleSubmitOrderClick(context, state);
                                  },
                                  isEnabled: context
                                      .watch<CheckoutBloc>()
                                      .isCheckoutButtonEnabled,
                                  text: LocalizationConstants.submitOrder
                                      .localized(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                case CheckoutNoDataState():
                  return CustomScrollView(slivers: <Widget>[
                    SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            child: SvgAssetImage(
                              assetName: AssetConstants.iconCart,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(state.message ?? ''),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            child: TertiaryButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: scanningMode == ScanningMode.count
                                  ? LocalizationConstants.backToCountInventory
                                      .localized()
                                  : LocalizationConstants.backToCreateOrder
                                      .localized(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                default:
                  return const Center();
              }
            },
          );
        },
      ),
    );
  }

  void _handleAddressSelectionCallBack(BuildContext context, Object result) {
    if (result is ShipTo) {
      context.read<CheckoutBloc>().add(AddShiptoAddressEvent(result));
    }
  }

  void _handleSubmitOrderClick(BuildContext context, CheckoutDataLoaded state) {
    var isPaymentCardType =
        context.read<PaymentDetailsBloc>().selectedPaymentMethod?.cardType !=
            null;
    var isCreditCardSectionCompleted =
        context.read<PaymentDetailsBloc>().isCreditCardSectionCompleted;

    var isCVVFieldOpened = context.read<PaymentDetailsBloc>().isCVVFieldOpened;

    var isPaymentMethodSelectedInCard =
        context.read<CheckoutBloc>().cart?.paymentMethod != null;
    var isPaymentMethodSelectedasCreditCard =
        context.read<CheckoutBloc>().cart?.paymentMethod?.isCreditCard == true;

    if (!isPaymentMethodSelectedInCard || isPaymentMethodSelectedasCreditCard) {
      context.read<CheckoutBloc>().add(SelectPaymentMethodEvent(
          context.read<PaymentDetailsBloc>().selectedPaymentMethod!));
    }

    if (isPaymentCardType &&
        !isCreditCardSectionCompleted &&
        isCVVFieldOpened) {
      context.read<PaymentDetailsBloc>().add(ValidateTokenEvent());
    } else {
      var poNumber = context.read<PaymentDetailsBloc>().getPONumber();
      var cart = context.read<PaymentDetailsBloc>().cart;

      if (cart!.requiresPoNumber! && poNumber.isNullOrEmpty) {
        CustomSnackBar.showPoNumberRequired(context);
      } else {
        context.read<CheckoutBloc>().add(UpdatePONumberEvent(poNumber));
        context.read<CheckoutBloc>().add(PlaceOrderEvent(
            reviewOrderEntity: prepareReviewOrderEntity(state, context)));
      }
    }
  }
}
