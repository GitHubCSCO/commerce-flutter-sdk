import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/cart_buttons_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/warehouse_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart_cms/cart_cms_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart_cms/cart_cms_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart_cms/cart_cms_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/promo_code_cubit/promo_code_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_order_handler/saved_order_handler_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line_list.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_payment_summary_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/error_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void _reloadCartPage(BuildContext context) {
  context.read<CartCountCubit>().loadCurrentCartCount();
  // context.read<CartPageBloc>().add(CartPageLoadEvent());
  context.read<CartCmsPageBloc>().add(const CartCmsPageLoadEvent());
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider<CartCmsPageBloc>(
        create: (context) =>
            sl<CartCmsPageBloc>()..add(const CartCmsPageLoadEvent()),
      ),
      BlocProvider<CartPageBloc>(create: (context) => sl<CartPageBloc>()),
      BlocProvider<PromoCodeCubit>(create: (context) => sl<PromoCodeCubit>()),
    ], child: const CartPage());
  }
}

class CartPage extends StatelessWidget with BaseDynamicContentScreen {
  const CartPage({super.key});

  final websitePath = WebsitePaths.cartWebsitePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        title: Text(LocalizationConstants.cart.localized()),
        backgroundColor: Colors.white,
        actions: [
          BottomMenuWidget(
              websitePath: websitePath,
              screenName: AnalyticsConstants.screenNameCart)
        ],
      ),
      bottomNavigationBar: _buildFooterWidget(context),
      body: MultiBlocListener(
          listeners: [
            BlocListener<RootBloc, RootState>(
              listener: (context, state) async {
                if (state is RootConfigReload ||
                    state is RootCartReload ||
                    state is RootPricingInventoryReload) {
                  _reloadCartPage(context);
                }
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listenWhen: (previous, current) =>
                  authCubitChangeTrigger(previous, current),
              listener: (context, state) {
                _reloadCartPage(context);
              },
            ),
            BlocListener<DomainCubit, DomainState>(
              listener: (context, state) {
                if (state is DomainLoaded) {
                  _reloadCartPage(context);
                }
              },
            ),
            BlocListener<CartCountCubit, CountState>(
              listener: (context, state) {
                if (state is CartTabReloadState) {
                  bool isCartItemChanged =
                      context.read<CartCountCubit>().cartItemChanged();
                  if (isCartItemChanged) {
                    context.read<CartCountCubit>().setCartItemChange(false);
                    _reloadCartPage(context);
                  }
                }
              },
            ),
            BlocListener<CartCmsPageBloc, CartCmsPageState>(
              listener: (context, state) {
                switch (state) {
                  case CartCmsPageLoadingState():
                    context.read<CmsCubit>().loading();
                  case CartCmsPageLoadedState():
                    context.read<CmsCubit>().buildCMSWidgets(state.pageWidgets);
                    context.read<CartPageBloc>().add(CartPageLoadEvent());
                  case CartCmsPageFailureState():
                    context.read<CmsCubit>().failedLoading();
                }
              },
            ),
            BlocListener<CartPageBloc, CartPageState>(
              listener: (_, state) {
                if (state is CartPageWarningDialogShowState) {
                  showRequestQuoteWarningDialog(context,
                      message: state.warningMsg);
                } else if (state is CartProceedToCheckoutState) {
                  var cartPageBloc = context.read<CartPageBloc>();
                  navigateToCheckout(context, cartPageBloc);
                }
              },
            )
          ],
          child: BlocBuilder<CmsCubit, CmsState>(
            builder: (context, cmsState) {
              switch (cmsState) {
                case CmsInitialState():
                case CmsLoadingState():
                  return const Center(child: CircularProgressIndicator());
                case CmsLoadedState():
                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        RefreshIndicator(
                          onRefresh: () async {
                            _reloadCartPage(context);
                          },
                          child: BlocBuilder<CartPageBloc, CartPageState>(
                            buildWhen: (previous, current) {
                              if (current is CartPageWarningDialogShowState ||
                                  current is CartProceedToCheckoutState ||
                                  current
                                      is CartPageCheckoutButtonLoadingState) {
                                return false;
                              }
                              return true;
                            },
                            builder: (_, state) {
                              switch (state) {
                                case CartPageInitialState():
                                case CartPageLoadingState():
                                  return const Center(
                                      child: CircularProgressIndicator());
                                case CartPageLoadedState():
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom:
                                            70), // Add space for the bottom panel
                                    child: Column(
                                      children: [
                                        if (state.cartWarningMsg.isNotEmpty)
                                          BuildCartErrorWidget(
                                              cartErrorMsg:
                                                  state.cartWarningMsg),
                                        Expanded(
                                          child: ListView(
                                            children: _buildCartWidgets(
                                                cmsState.widgetEntities,
                                                state.cart,
                                                state.cartSettings,
                                                state.warehouse,
                                                state.promotions,
                                                state.isCustomerOrderApproval,
                                                state.hasWillCall,
                                                state.shippingMethod,
                                                state.hidePricingEnable,
                                                state.hideInventoryEnable,
                                                context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                case CartPageNoDataState():
                                  return CustomScrollView(slivers: <Widget>[
                                    SliverFillRemaining(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(10),
                                            child: const SvgAssetImage(
                                              assetName:
                                                  AssetConstants.iconCart,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Text(state.message),
                                          Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: TertiaryButton(
                                              onPressed: () {
                                                _trackContinueShoppingEvent(
                                                    context,
                                                    context
                                                            .read<
                                                                CartPageBloc>()
                                                            .cart
                                                            ?.orderNumber ??
                                                        '');
                                                AppRoute.shop.navigate(context);
                                              },
                                              text: LocalizationConstants
                                                  .continueShopping
                                                  .localized(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ]);
                                default:
                                  return CustomScrollView(
                                    slivers: <Widget>[
                                      SliverFillRemaining(
                                          child: OptiErrorWidget(
                                        onRetry: () {
                                          _reloadCartPage(context);
                                        },
                                        errorText: LocalizationConstants
                                            .errorLoadingCart
                                            .localized(),
                                      )),
                                    ],
                                  );
                              }
                            },
                          ),
                        ),
                        // Bottom Draggable Panel
                        BlocBuilder<CartPageBloc, CartPageState>(
                          buildWhen: (previous, current) {
                            if (current is CartPageWarningDialogShowState ||
                                current is CartProceedToCheckoutState ||
                                current is CartPageCheckoutButtonLoadingState) {
                              return false;
                            }
                            return true;
                          },
                          builder: (context, state) {
                            if (state is CartPageLoadedState) {
                              var isQuoteAndCheckoutVisible = context
                                      .watch<CartPageBloc>()
                                      .canSubmitForQuote &&
                                  context
                                      .watch<CartPageBloc>()
                                      .checkoutButtonVisible;

                              var isAddToListVisible =
                                  isAddToListEnabled(cmsState.widgetEntities);
                              var isSavedOrderVisible =
                                  isSavedOrderEnabled(cmsState.widgetEntities);

                              var initialSize = getInitialBottomSheetSize(
                                  constraints.maxHeight);
                              var maxSize = getExpandedBottomSheetSize(
                                  constraints.maxHeight,
                                  isQuoteAndCheckoutVisible,
                                  isAddToListVisible,
                                  isSavedOrderVisible);

                              return DraggableScrollableSheet(
                                initialChildSize:
                                    initialSize, // Initial size (Only Checkout button visible)
                                minChildSize:
                                    initialSize, // Minimum collapsed size
                                maxChildSize: maxSize, // Maximum expanded size
                                builder: (context, scrollController) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Drag Handle
                                            Container(
                                              width: 50,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            _buildSubTotal(state),
                                            const SizedBox(height: 10),
                                            Visibility(
                                              visible: isAddToListVisible,
                                              child: TertiaryBlackButton(
                                                text: LocalizationConstants
                                                    .addAllToList
                                                    .localized(),
                                                onPressed: () {
                                                  final currentState = context
                                                      .read<AuthCubit>()
                                                      .state;
                                                  handleAuthStatusForAddToWishList(
                                                      context,
                                                      currentState.status);
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: isSavedOrderVisible,
                                              child: TertiaryBlackButton(
                                                text: LocalizationConstants
                                                    .saveOrder
                                                    .localized(),
                                                onPressed: () {
                                                  final currentState = context
                                                      .read<AuthCubit>()
                                                      .state;
                                                  handleAuthStatusForSaveOrder(
                                                      context,
                                                      currentState.status,
                                                      state);
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  isQuoteAndCheckoutVisible,
                                              child: SecondaryButton(
                                                onPressed: () {
                                                  final currentState = context
                                                      .read<AuthCubit>()
                                                      .state;
                                                  handleAuthStatusForSubmitQuote(
                                                      context,
                                                      currentState.status,
                                                      state);
                                                },
                                                text: context
                                                    .watch<CartPageBloc>()
                                                    .submitForQuoteTitle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center();
                            }
                          },
                        ),
                      ],
                    );
                  });
                default:
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverFillRemaining(
                          child: OptiErrorWidget(
                        onRetry: () {
                          _reloadCartPage(context);
                        },
                        errorText:
                            LocalizationConstants.errorLoadingCart.localized(),
                      )),
                    ],
                  );
              }
            },
          )),
    );
  }

  bool isAddToListEnabled(List<WidgetEntity> widgetEntities) {
    return widgetEntities
            .whereType<CartButtonsWidgetEntity>()
            .firstOrNull
            ?.isAddToListEnabled ==
        true;
  }

  bool isSavedOrderEnabled(List<WidgetEntity> widgetEntities) {
    return widgetEntities
            .whereType<CartButtonsWidgetEntity>()
            .firstOrNull
            ?.isSavedOrderEnabled ==
        true;
  }

  double getInitialBottomSheetSize(double height) {
    var initialHeight = CoreConstants.cartBottomSheetInitialSize;
    return initialHeight / height;
  }

  /// Calculates the expanded size of the bottom sheet as a fraction of the screen height.
  ///
  /// The bottom sheet contains fixed and dynamic buttons:
  /// - There are always two fixed buttons (e.g., "Add to List" and "Save Order").
  /// - If `isQuoteVisible` is `true`, an additional "Request a Quote" button is included.
  /// - The total height is then adjusted by `cartBottomSheetInitialSize`.
  double getExpandedBottomSheetSize(double height, bool isQuoteVisible,
      bool isAddToListVisible, bool isSavedOrderVisible) {
    var visibleButtonCount = [
      isQuoteVisible,
      isAddToListVisible,
      isSavedOrderVisible
    ].where((isVisible) => isVisible).length;

    var initialHeight =
        (CoreConstants.cartBottomPerButtonSize * visibleButtonCount) +
            CoreConstants.cartBottomSheetInitialSize;

    return initialHeight / height;
  }

  Widget _buildSubTotal(CartPageLoadedState state) {
    var title = state.cart == null
        ? LocalizationConstants.subtotal.localized()
        : LocalizationConstants.subtotalItems
            .localized()
            .format([state.cart?.totalCountDisplay ?? '']);
    var body = state.cart?.orderSubTotalDisplay ?? '';
    var textStyle = OptiTextStyles.subtitle;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              title,
              maxLines: 1,
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

  void _trackContinueShoppingEvent(BuildContext context, String orderNumber) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
            AnalyticsConstants.eventContinueShopping,
            AnalyticsConstants.screenNameCart)
        .withProperty(
            name: AnalyticsConstants.eventPropertyOrderNumber,
            strValue: orderNumber)));
  }

  void _trackAddToListEvent(BuildContext context, String orderNumber) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
                AnalyticsConstants.eventCartToListSelected,
                AnalyticsConstants.screenNameCart)
            .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber,
        )));
  }

  void _trackAddToListSuccessfulEvent(
      BuildContext context, String orderNumber) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
                AnalyticsConstants.eventCartToListSuccessful,
                AnalyticsConstants.screenNameCart)
            .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: orderNumber,
        )));
  }

  void _trackBeginCheckoutEvent(BuildContext context, String grandTotal) {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
            AnalyticsConstants.eventBeginCheckout,
            AnalyticsConstants.screenNameCheckout)
        .withProperty(
            name: AnalyticsConstants.eventPropertyValue,
            strValue: grandTotal)));
  }

  Widget _buildFooterWidget(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BlocBuilder<CartPageBloc, CartPageState>(
        buildWhen: (previous, current) {
          if (current is CartPageWarningDialogShowState ||
              current is CartProceedToCheckoutState ||
              current is CartPageCheckoutButtonLoadingState) {
            return false;
          }
          return true;
        },
        builder: (_, state) {
          if (state is CartPageCheckoutButtonLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is! CartPageLoadedState) {
            return const Center();
          }

          return Container(
            color: Colors.white,
            padding:
                const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
            child: _buildFooterButton(context, state),
          );
        },
      ),
    );
  }

  Widget _buildFooterButton(BuildContext context, CartPageLoadedState state) {
    var cartPageBloc = context.watch<CartPageBloc>();
    var authCubit = context.read<AuthCubit>();

    if (cartPageBloc.checkoutButtonVisible) {
      return PrimaryButton(
        isEnabled: cartPageBloc.isCheckoutButtonEnabled,
        onPressed: () {
          final currentState = authCubit.state;
          handleAuthStatusForCheckout(
              context, currentState.status, context.read<CartPageBloc>());
        },
        text: cartPageBloc.approvalButtonVisible
            ? LocalizationConstants.checkoutForApproval.localized()
            : LocalizationConstants.checkout.localized(),
      );
    } else if (cartPageBloc.canSubmitForQuote) {
      return SecondaryButton(
        onPressed: () {
          final currentState = authCubit.state;
          handleAuthStatusForSubmitQuote(context, currentState.status, state);
        },
        text: cartPageBloc.submitForQuoteTitle,
      );
    } else {
      return const Center();
    }
  }

  void handleAuthStatusForCheckout(
      BuildContext context, AuthStatus status, CartPageBloc cartPageBloc) {
    if (status == AuthStatus.authenticated) {
      cartPageBloc.add(CartPageCheckoutEvent());
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeCheckout.localized());
    }
  }

  void handleAuthStatusForSubmitQuote(
      BuildContext context, AuthStatus status, CartPageLoadedState state) {
    if (status == AuthStatus.authenticated) {
      AppRoute.requestQuote.navigateBackStack(context, extra: state.cart);
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeSubmitQuote.localized());
    }
  }

  void handleAuthStatusForAddToWishList(
      BuildContext context, AuthStatus status) {
    if (status == AuthStatus.authenticated) {
      _trackAddToListEvent(
          context, context.read<CartPageBloc>().cart?.orderNumber ?? '');
      final addCartLines = context.read<CartPageBloc>().getAddCartLines();
      WishListCallbackHelper.addItemsToWishList(
        context,
        addToCartCollection: WishListAddToCartCollection(
          wishListLines: addCartLines,
        ),
        onAddedToCart: () {
          _trackAddToListSuccessfulEvent(
              context, context.read<CartPageBloc>().cart?.orderNumber ?? '');
        },
      );
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeList.localized());
    }
  }

  void handleAuthStatusForSaveOrder(
      BuildContext context, AuthStatus status, CartPageLoadedState state) {
    if (status == AuthStatus.authenticated) {
      context
          .read<SavedOrderHandlerCubit>()
          .addCartToSavedOrders(cart: state.cart);
    } else {
      showSignInDialog(context,
          message: LocalizationConstants.signInBeforeSaveOrder.localized());
    }
  }

  void navigateToCheckout(BuildContext context, CartPageBloc cartPageBloc) {
    _trackBeginCheckoutEvent(context,
        context.read<CartPageBloc>().cart?.orderGrandTotalDisplay ?? '');
    AppRoute.checkout.navigateBackStack(context, extra: cartPageBloc.cart);
  }

  void showRequestQuoteWarningDialog(BuildContext context, {String? message}) {
    displayDialogWidget(
      context: context,
      message: message,
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
            var cartPageBloc = context.read<CartPageBloc>();
            navigateToCheckout(context, cartPageBloc);
          },
          child: Text(LocalizationConstants.oK.localized()),
        ),
      ],
    );
  }

  void showSignInDialog(BuildContext context, {String? message}) {
    displayDialogWidget(
      context: context,
      title: LocalizationConstants.notSignedIn.localized(),
      message: message,
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
            AppRoute.login.navigateBackStack(context);
          },
          child: Text(LocalizationConstants.signIn.localized()),
        ),
      ],
    );
  }

  List<Widget> _buildCartWidgets(
      List<WidgetEntity> widgetEntities,
      Cart? cart,
      CartSettings? settings,
      Warehouse? warehouse,
      PromotionCollectionModel? promotions,
      bool isCustomerOrderApproval,
      bool hasWillCall,
      String shippingMethod,
      bool? hidePricingEnable,
      bool? hideInventoryEnable,
      BuildContext context) {
    List<Widget> list = [];

    final paymentSummaryEntity = PaymentSummaryEntity(
        cart: cart,
        cartSettings: settings,
        promotions: promotions,
        isCustomerOrderApproval: isCustomerOrderApproval);
    final shippingEntity = ShippingEntity(
        hasWillCall: hasWillCall,
        warehouse: warehouse,
        shippingMethod:
            (shippingMethod.equalsIgnoreCase(ShippingOption.pickUp.name)
                ? ShippingOption.pickUp
                : ShippingOption.ship));

    list.add(BlocProvider<CartContentBloc>(
      create: (context) => sl<CartContentBloc>(),
      child: Builder(
        builder: (context) {
          var items = context.read<CartPageBloc>().getCartLines();

          return BlocListener<SavedOrderHandlerCubit, SavedOrderHandlerState>(
            listener: (context, state) {
              if (state.status == SavedOrderHandlerStatus.shouldClearCart) {
                context.read<CartContentBloc>().add(CartContentClearAllEvent());

                AppRoute.savedOrderDetails.navigate(
                  context,
                  pathParameters: {
                    'cartId': context
                            .read<SavedOrderHandlerCubit>()
                            .state
                            .savedCart
                            .id ??
                        '',
                  },
                );
              }
            },
            child: Column(
              children: [
                CartLineWidgetList(
                  oderNumber:
                      context.read<CartPageBloc>().cart?.orderNumber ?? '',
                  cartLineEntities: items
                      .take(CoreConstants.maximumItemDisplayInCart)
                      .toList(),
                  onCartChangeCallBack: (context) {
                    context.read<CartCountCubit>().loadCurrentCartCount();
                    context.read<CartPageBloc>().add(CartPageLoadEvent());
                  },
                  hidePricingEnable: hidePricingEnable,
                  hideInventoryEnable: hideInventoryEnable,
                ),
                if (items.length > CoreConstants.maximumItemDisplayInCart) ...{
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: TertiaryBlackButton(
                      text: LocalizationConstants.viewMoreCartItems.localized(),
                      onPressed: () {},
                    ),
                  ),
                }
              ],
            ),
          );
        },
      ),
    ));

    list.addAll(buildContentWidgets(widgetEntities));

    if (!(hidePricingEnable ?? false)) {
      list.add(
          CartPaymentSummaryWidget(paymentSummaryEntity: paymentSummaryEntity));
    }
    list.add(BlocProvider<CartShippingSelectionBloc>(
      create: (context) => sl<CartShippingSelectionBloc>()
        ..add(CartShippingOptionDefaultEvent(shippingEntity.shippingMethod!)),
      child: CartShippingWidget(
        shippingEntity: shippingEntity,
        onCallBack: _handlePickUpLocationCallBack,
      ),
    ));

    list.add(const SizedBox(height: 8));

    return list;
  }

  void _handlePickUpLocationCallBack(
      BuildContext context, WarehouseEntity wareHouse) {
    context.read<CartPageBloc>().add(CartPagePickUpLocationChangeEvent(
        WarehouseEntityMapper.toModel(wareHouse)));
  }
}

class BuildCartErrorWidget extends StatelessWidget {
  final String cartErrorMsg;
  const BuildCartErrorWidget({
    required this.cartErrorMsg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: OptiAppColors.invalidColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(10),
              child: const SvgAssetImage(
                assetName: AssetConstants.cartErrorIcon,
                fit: BoxFit.fitWidth,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  maxLines: null,
                  cartErrorMsg,
                  style: OptiTextStyles.errorTextStyles,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
