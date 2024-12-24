import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/models/expansion_panel_item.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/review_order_entity.dart';
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

ReviewOrderEntity prepareReviewOrderEntiity(
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
        BlocProvider<TokenExBloc>(create: (context) => sl<TokenExBloc>()),
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
      String transcationId,
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
            strValue: transcationId)
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
                                  List<ExpansionPanelItem>? list;
                                  switch (panelState) {
                                    case ExpansionPanelChangeState():
                                      list = panelState.list;
                                  }

                                  final billingShippingEntity =
                                      BillingShippingEntity(
                                    billTo: state.billToAddress,
                                    shipTo: state.shipToAddress,
                                    warehouse: state.wareHouse,
                                    shippingMethod: (state.shippingMethod
                                            .equalsIgnoreCase(
                                                ShippingOption.pickUp.name)
                                        ? ShippingOption.pickUp
                                        : ShippingOption.ship),
                                    carriers: state.cart.carriers,
                                    cartSettings: state.cartSettings,
                                    selectedCarrier: state.selectedCarrier,
                                    selectedService: state.selectedService,
                                    requestDeliveryDate:
                                        state.requestDeliveryDate,
                                    allowCreateNewShipToAddress:
                                        state.allowCreateNewShipToAddress,
                                    requestDateWarningMessage:
                                        state.requestDateWarningMessage,
                                  );

                                  final paymentSummaryEntity =
                                      PaymentSummaryEntity(
                                          cart: state.cart,
                                          cartSettings: state.cartSettings,
                                          promotions: state.promotions,
                                          isCustomerOrderApproval: false);

                                  final reviewOrderEntity =
                                      prepareReviewOrderEntiity(state, context);

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
                                          isExpanded:
                                              list?[0].isExpanded ?? true,
                                          canTapOnHeader: true),
                                      if (context
                                              .watch<CheckoutBloc>()
                                              .cart
                                              ?.requiresApproval !=
                                          true)
                                        ExpansionPanel(
                                            headerBuilder:
                                                (BuildContext context,
                                                    bool isExpanded) {
                                              return ListTile(
                                                title: Text(
                                                    LocalizationConstants
                                                        .paymentDetails
                                                        .localized()),
                                              );
                                            },
                                            body: CheckoutPaymentDetails(
                                                cart: context
                                                    .read<CheckoutBloc>()
                                                    .cart!,
                                                onCompleteCheckoutPaymentSection:
                                                    () {
                                                  context.read<CheckoutBloc>().add(
                                                      SelectPaymentEvent(context
                                                          .read<
                                                              PaymentDetailsBloc>()
                                                          .cart!
                                                          .paymentOptions!));
                                                }),
                                            isExpanded:
                                                list?[1].isExpanded ?? false,
                                            canTapOnHeader: true),
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
                                              reviewOrderEntity:
                                                  reviewOrderEntity,
                                              paymentSummaryEntity:
                                                  paymentSummaryEntity),
                                          isExpanded:
                                              list?.last.isExpanded ?? false,
                                          canTapOnHeader: true),
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
                            var buttonText = snapshot.data!;
                            var index = context
                                .read<ExpansionPanelCubit>()
                                .expansionIndex;
                            return PrimaryButton(
                              onPressed: () {
                                void handleCareerService() {
                                  final carrier = context
                                      .read<CheckoutBloc>()
                                      .selectedCarrier;
                                  final service = context
                                      .read<CheckoutBloc>()
                                      .selectedService;

                                  if ((state.shippingMethod.equalsIgnoreCase(
                                              ShippingOption.ship.name) &&
                                          carrier != null &&
                                          service != null) ||
                                      state.shippingMethod.equalsIgnoreCase(
                                          ShippingOption.pickUp.name)) {
                                    context
                                        .read<ExpansionPanelCubit>()
                                        .onContinueClick();
                                  }
                                }

                                void handlePayment() {
                                  var isPaymentCardType = context
                                          .read<PaymentDetailsBloc>()
                                          .selectedPaymentMethod
                                          ?.cardType !=
                                      null;
                                  var isCreditCardSectionCompleted = context
                                      .read<PaymentDetailsBloc>()
                                      .isCreditCardSectionCompleted;
                                  var isSelectedNewAddedCard = context
                                      .read<PaymentDetailsBloc>()
                                      .isSelectedNewAddedCard;
                                  var isCVVFieldOpened = context
                                      .read<PaymentDetailsBloc>()
                                      .isCVVFieldOpened;

                                  var isPaymentMethodSelectedInCard = context
                                          .read<CheckoutBloc>()
                                          .cart
                                          ?.paymentMethod !=
                                      null;
                                  var isPaymentMethodSelectedAsCreditCard =
                                      context
                                              .read<CheckoutBloc>()
                                              .cart
                                              ?.paymentMethod
                                              ?.isCreditCard ==
                                          true;

                                  var isOrderNotesShowed = context
                                      .read<PaymentDetailsBloc>()
                                      .shouldShowOrderNotes;
                                  var orderNotes = context
                                      .read<PaymentDetailsBloc>()
                                      .getOrderNotes();

                                  if (isOrderNotesShowed) {
                                    context
                                        .read<CheckoutBloc>()
                                        .add(UpdateOrderNotesEvent(orderNotes));
                                  }

                                  if (!isPaymentMethodSelectedInCard ||
                                      isPaymentMethodSelectedAsCreditCard) {
                                    context.read<CheckoutBloc>().add(
                                        SelectPaymentMethodEvent(context
                                            .read<PaymentDetailsBloc>()
                                            .selectedPaymentMethod!));
                                  }

                                  if (isSelectedNewAddedCard) {
                                    context
                                        .read<ExpansionPanelCubit>()
                                        .onContinueClick();
                                  } else if (isPaymentCardType &&
                                      !isCreditCardSectionCompleted &&
                                      !isSelectedNewAddedCard &&
                                      isCVVFieldOpened) {
                                    context
                                        .read<TokenExBloc>()
                                        .add(TokenExValidateEvent());
                                  } else {
                                    var poNumber = context
                                        .read<PaymentDetailsBloc>()
                                        .getPONumber();
                                    var cart =
                                        context.read<PaymentDetailsBloc>().cart;

                                    if (cart!.requiresPoNumber! &&
                                        poNumber.isNullOrEmpty) {
                                      CustomSnackBar.showPoNumberRequired(
                                          context);
                                    } else {
                                      context
                                          .read<CheckoutBloc>()
                                          .add(UpdatePONumberEvent(poNumber));

                                      context
                                          .read<ExpansionPanelCubit>()
                                          .onContinueClick();
                                    }
                                  }
                                }

                                void handleReviewOrder() {
                                  final reviewOrderEntity =
                                      prepareReviewOrderEntiity(state, context);

                                  trackEcommercePurchaseEvent(
                                      context,
                                      state.cart.orderGrandTotal?.toString() ??
                                          '0',
                                      state.cart.currencySymbol ?? '',
                                      state.cart.shippingAndHandling
                                              ?.toString() ??
                                          '0',
                                      state.cart.totalTax?.toString() ?? '0',
                                      state.cart.orderNumber ?? '',
                                      state.cart.promotionCode ?? '');

                                  context.read<CheckoutBloc>().add(
                                      PlaceOrderEvent(
                                          reviewOrderEntity:
                                              reviewOrderEntity));
                                }

                                switch (index) {
                                  case 0:
                                    handleCareerService();
                                  case 1:
                                    if (context
                                            .read<CheckoutBloc>()
                                            .cart
                                            ?.requiresApproval !=
                                        true) {
                                      handlePayment();
                                    } else {
                                      handleReviewOrder();
                                    }
                                  case 2:
                                    if (context
                                            .read<CheckoutBloc>()
                                            .cart
                                            ?.requiresApproval !=
                                        true) {
                                      handleReviewOrder();
                                    } else {
                                      context
                                          .read<ExpansionPanelCubit>()
                                          .onContinueClick();
                                    }
                                  default:
                                    context
                                        .read<ExpansionPanelCubit>()
                                        .onContinueClick();
                                }
                              },
                              text: buttonText,
                              isEnabled: (index ==
                                          (context
                                                      .read<CheckoutBloc>()
                                                      .cart
                                                      ?.requiresApproval !=
                                                  true
                                              ? 2
                                              : 1) &&
                                      isCheckoutButtonEnabled == false)
                                  ? false
                                  : true,
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

  void _handleAddressSelectionCallBack(BuildContext context, Object result) {
    if (result is ShipTo) {
      context.read<CheckoutBloc>().add(UpdateShiptoAddressEvent(result));
    }
  }
}
