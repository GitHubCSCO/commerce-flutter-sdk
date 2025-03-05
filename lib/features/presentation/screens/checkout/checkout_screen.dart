import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/payment_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/payment_details/token_ex_bloc/token_ex_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/expansion_panel/expansion_panel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_approval/order_approval_handler/order_approval_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/promo_code_cubit/promo_code_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/base_checkout.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_success_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/payment_details/checkout_payment_details.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/review_order/review_order_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_list_with_basicInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CheckoutScreen extends BaseStatelessWidget {
  final Cart cart;

  const CheckoutScreen({super.key, required this.cart});

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpansionPanelCubit>(
          create: (context) => sl<ExpansionPanelCubit>()
            ..initialize((cart.requiresApproval ?? false) ? 2 : 3),
        ),
        BlocProvider<CheckoutBloc>(
            create: (context) =>
                sl<CheckoutBloc>()..add(LoadCheckoutEvent(cart: cart))),
        BlocProvider<ReviewOrderCubit>(
            create: (context) => sl<ReviewOrderCubit>()),
        BlocProvider<PromoCodeCubit>(create: (context) => sl<PromoCodeCubit>()),
        BlocProvider<PaymentDetailsBloc>(
          create: (context) => sl<PaymentDetailsBloc>()
            ..add(LoadPaymentDetailsEvent(cart: cart)),
        ),
      ],
      child: CheckoutPage(cart: cart),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameCheckout,
      );
}

class CheckoutPage extends StatelessWidget with BaseCheckout {
  final Cart cart;

  CheckoutPage({super.key, required this.cart});

  bool get hasOnlyQuoteRequiredProducts {
    return (cart.cartLines != null && (cart.cartLines ?? []).isNotEmpty) &&
        (cart.cartLines ?? []).every((x) => x.quoteRequired ?? false);
  }

  bool get isCartCheckoutDisabled {
    return (!(cart.canCheckOut ?? true) && !(cart.canRequisition ?? true)) ||
        isCartEmpty ||
        hasRestrictedCartLines;
  }

  bool get isCartEmpty {
    return cart.cartLines == null || (cart.cartLines ?? []).isEmpty;
  }

  bool get hasRestrictedCartLines {
    return cart.cartLines != null &&
        (cart.cartLines ?? []).any((x) => x.isRestricted ?? false);
  }

  bool get isCheckoutButtonEnabled {
    return !isCartCheckoutDisabled || !hasOnlyQuoteRequiredProducts;
  }

  void trackEcommercePurchaseEvent(
      BuildContext context,
      String value,
      String currency,
      String shipping,
      String tax,
      String transactionId,
      String promoCode) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
            AnalyticsConstants.eventEcommercePurchase,
            AnalyticsConstants.screenNameCheckout)
        .withProperty(
            name: AnalyticsConstants.eventPropertyCurrency, strValue: currency)
        .withProperty(
            name: AnalyticsConstants.eventPropertyShipping, strValue: shipping)
        .withProperty(name: AnalyticsConstants.eventPropertyTax, strValue: tax)
        .withProperty(
            name: AnalyticsConstants.eventPropertyTransactionId,
            strValue: transactionId)
        .withProperty(
            name: AnalyticsConstants.eventPromoCode, strValue: promoCode)
        .withProperty(
            name: AnalyticsConstants.eventPropertyValue, strValue: value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (_, state) {
          if (state is CheckoutShipToAddressAddedState) {
            context.read<CheckoutBloc>().add(
                LoadCheckoutEvent(cart: context.read<CheckoutBloc>().cart!));
            context.read<RootBloc>().add(RootCartUpdateEvent());
          } else if (state is CheckoutPlaceOrder) {
            context.read<CartCountCubit>().onCartItemChange();
            context
                .read<OrderApprovalHandlerCubit>()
                .shouldRefreshOrderApproval();
            AppRoute.checkoutSuccess.navigate(context,
                extra: CheckoutSuccessEntity(
                    orderNumber: state.orderNumber,
                    isVmiCheckout: false,
                    cart: context.read<CheckoutBloc>().cart!,
                    isOrderApproval:
                        context.read<CheckoutBloc>().cart?.requiresApproval ??
                            false,
                    reviewOrderEntity: state.reviewOrderEntity,
                    message: state.message));
          } else if (state is CheckoutPlaceOrderFailed) {
            context.read<ExpansionPanelCubit>().onPanelExpansionChange(0);
            showAlert(context,
                message: LocalizationConstants.orderFailed.localized());
          }
        },
        builder: (_, state) {
          return BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (_, state) {
              switch (state) {
                case CheckoutInitial():
                case CheckoutLoading():
                  return const Center(child: CircularProgressIndicator());
                case CheckoutDataFetchFailed():
                  //Send some analytics event here from state.error so we can analyze what was the root cause
                  return Center(
                      child: Text(LocalizationConstants.somethingWentWrong
                          .localized()));
                case CheckoutDataLoaded():
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildSummary(state.cart, state.promotions),
                              BlocBuilder<ExpansionPanelCubit,
                                  ExpansionPanelState>(
                                builder: (_, panelState) {
                                  final list =
                                      panelState is ExpansionPanelChangeState
                                          ? panelState.list
                                          : null;

                                  final billingShippingEntity =
                                      prepareBillingShippingEntity(state);
                                  final paymentSummaryEntity =
                                      preparePaymentSummaryEntity(state);
                                  final reviewOrderEntity =
                                      prepareReviewOrderEntity(state, context);

                                  final checkoutBloc =
                                      context.watch<CheckoutBloc>();
                                  final requiresApproval =
                                      checkoutBloc.cart?.requiresApproval ==
                                          true;

                                  return ExpansionPanelList(
                                    expansionCallback:
                                        (int index, bool isExpanded) {
                                      context
                                          .read<ExpansionPanelCubit>()
                                          .onPanelExpansionChange(index);
                                    },
                                    children: [
                                      ExpansionPanel(
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return ListTile(
                                            title: Text(LocalizationConstants
                                                .billingShipping
                                                .localized()),
                                          );
                                        },
                                        body: BillingShippingWidget(
                                          billingShippingEntity:
                                              billingShippingEntity,
                                          onCallBack:
                                              _handleAddressSelectionCallBack,
                                        ),
                                        isExpanded: list?[0].isExpanded ?? true,
                                        canTapOnHeader: true,
                                      ),
                                      if (!requiresApproval)
                                        ExpansionPanel(
                                          headerBuilder: (BuildContext context,
                                              bool isExpanded) {
                                            return ListTile(
                                              title: Text(LocalizationConstants
                                                  .paymentDetails
                                                  .localized()),
                                            );
                                          },
                                          body: CheckoutPaymentDetails(
                                            cart: checkoutBloc.cart!,
                                            onCompleteCheckoutPaymentSection:
                                                () {
                                              final paymentDetailsBloc = context
                                                  .read<PaymentDetailsBloc>();
                                              checkoutBloc.add(
                                                SelectPaymentEvent(
                                                    paymentDetailsBloc
                                                        .cart!.paymentOptions!),
                                              );
                                            },
                                          ),
                                          isExpanded:
                                              list?[1].isExpanded ?? false,
                                          canTapOnHeader: true,
                                        ),
                                      ExpansionPanel(
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return ListTile(
                                            title: Text(LocalizationConstants
                                                .reviewOrder
                                                .localized()),
                                          );
                                        },
                                        body: ReviewOrderWidget(
                                          reviewOrderEntity: reviewOrderEntity,
                                          paymentSummaryEntity:
                                              paymentSummaryEntity,
                                        ),
                                        isExpanded:
                                            list?.last.isExpanded ?? false,
                                        canTapOnHeader: true,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              ProductListWithBasicInfo(
                                totalItemsTitle: LocalizationConstants
                                    .cartContentsItems
                                    .localized(),
                                list: CartLineListMapper.toEntity(CartLineList(
                                            cartLines:
                                                state.cart.cartLines ?? []))
                                        .cartLines ??
                                    [],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: StreamBuilder<String>(
                          stream: context
                              .read<ExpansionPanelCubit>()
                              .buttonTextStream,
                          initialData:
                              LocalizationConstants.continueText.localized(),
                          builder: (context, snapshot) {
                            final buttonText = snapshot.data ??
                                LocalizationConstants.continueText.localized();
                            final expansionPanelCubit =
                                context.read<ExpansionPanelCubit>();
                            final checkoutBloc = context.read<CheckoutBloc>();
                            final index = expansionPanelCubit.expansionIndex;
                            final requiresApproval =
                                checkoutBloc.cart?.requiresApproval == true;
                            final isCheckoutStep =
                                index == (requiresApproval ? 1 : 2);

                            return PrimaryButton(
                              onPressed: () {
                                switch (index) {
                                  case 0:
                                    handleCareerService(context, state);
                                  case 1:
                                    if (!requiresApproval) {
                                      handlePayment(context, state);
                                    } else {
                                      handleReviewOrder(context, state);
                                    }
                                  case 2:
                                    if (!requiresApproval) {
                                      handleReviewOrder(context, state);
                                    } else {
                                      expansionPanelCubit.onContinueClick();
                                    }
                                  default:
                                    expansionPanelCubit.onContinueClick();
                                }
                              },
                              text: buttonText,
                              isEnabled:
                                  !(isCheckoutStep && !isCheckoutButtonEnabled),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                default:
                  return const Center();
              }
            },
          );
        },
      ),
    );
  }

  void handleCareerService(BuildContext context, CheckoutDataLoaded state) {
    final checkoutBloc = context.read<CheckoutBloc>();
    final carrier = checkoutBloc.selectedCarrier;
    final service = checkoutBloc.selectedService;

    final isShipMethod =
        state.shippingMethod.equalsIgnoreCase(ShippingOption.ship.name);
    final isPickUpMethod =
        state.shippingMethod.equalsIgnoreCase(ShippingOption.pickUp.name);

    if ((isShipMethod && carrier != null && service != null) ||
        isPickUpMethod) {
      context.read<ExpansionPanelCubit>().onContinueClick();
    }
  }

  void handlePayment(BuildContext context, CheckoutDataLoaded state) {
    final paymentDetailsBloc = context.read<PaymentDetailsBloc>();
    final checkoutBloc = context.read<CheckoutBloc>();
    final expansionPanelCubit = context.read<ExpansionPanelCubit>();

    final selectedPaymentMethod = paymentDetailsBloc.selectedPaymentMethod;
    final isPaymentCardType = selectedPaymentMethod?.cardType != null;
    final isCreditCardSectionCompleted =
        paymentDetailsBloc.isCreditCardSectionCompleted;
    final isSelectedNewAddedCard = paymentDetailsBloc.isSelectedNewAddedCard;
    final isCVVFieldOpened = paymentDetailsBloc.isCVVFieldOpened;

    final cart = checkoutBloc.cart;
    final isPaymentMethodSelectedInCard = cart?.paymentMethod != null;
    final isPaymentMethodSelectedAsCreditCard =
        cart?.paymentMethod?.isCreditCard == true;

    if (!isPaymentMethodSelectedInCard || isPaymentMethodSelectedAsCreditCard) {
      if (selectedPaymentMethod != null) {
        checkoutBloc.add(SelectPaymentMethodEvent(selectedPaymentMethod));
      }
    }

    if (isPaymentCardType &&
        !isCreditCardSectionCompleted &&
        isCVVFieldOpened) {
      paymentDetailsBloc.add(ValidateTokenEvent());
    } else {
      final poNumber = paymentDetailsBloc.getPONumber();
      final requiresPoNumber = cart?.requiresPoNumber ?? false;

      if (requiresPoNumber && (poNumber.isEmpty)) {
        CustomSnackBar.showPoNumberRequired(context);
      } else {
        checkoutBloc.add(UpdatePONumberEvent(poNumber));
        checkoutBloc.add(UpdatePaymentInfoEvent());
        expansionPanelCubit.onContinueClick();
      }
    }
  }

  void handleReviewOrder(BuildContext context, CheckoutDataLoaded state) {
    final reviewOrderEntity = prepareReviewOrderEntity(state, context);

    trackEcommercePurchaseEvent(
        context,
        state.cart.orderGrandTotal?.toString() ?? '0',
        state.cart.currencySymbol ?? '',
        state.cart.shippingAndHandling?.toString() ?? '0',
        state.cart.totalTax?.toString() ?? '0',
        state.cart.orderNumber ?? '',
        state.cart.promotionCode ?? '');

    context
        .read<CheckoutBloc>()
        .add(PlaceOrderEvent(reviewOrderEntity: reviewOrderEntity));
  }

  void _handleAddressSelectionCallBack(BuildContext context, Object result) {
    if (result is ShipTo) {
      context.read<CheckoutBloc>().add(UpdateShiptoAddressEvent(result));
    }
  }
}
