import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quick_order/auto_complete/quick_order_auto_complete_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/quick_order/order_list/order_list_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/style_trait/style_trait_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/barcode_scanner/barcode_scanner_view.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/checkout/vmi_checkout/vmi_checkout_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/quick_order/count_inventory/count_input_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/quick_order/quick_order_list/quick_order_list_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/auto_complete_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/style_trait_select_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderScreen extends BaseStatelessWidget {
  final ScanningMode _scanningMode;

  const QuickOrderScreen({super.key, required ScanningMode scanningMode})
      : _scanningMode = scanningMode;

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BarcodeScanBloc>(create: (context) => sl<BarcodeScanBloc>()),
      BlocProvider<StyleTraitCubit>(
        create: (context) => sl<StyleTraitCubit>(),
      ),
      BlocProvider<OrderListBloc>(
        create: (context) {
          return OrderListBloc(
            quickOrderUseCase: sl(),
            searchUseCase: sl(),
            pricingInventoryUseCase: sl(),
            scanningMode: _scanningMode,
          )..add(OrderListInitialEvent());
        },
      ),
      BlocProvider<QuickOrderAutoCompleteBloc>(
        create: (context) {
          return QuickOrderAutoCompleteBloc(
            searchUseCase: sl(),
            scanningMode: _scanningMode,
          );
        },
      )
    ], child: QuickOrderPage(scanningMode: _scanningMode));
  }

  @override
  AnalyticsEvent getAnalyticsEvent() {
    String screenName;
    switch (_scanningMode) {
      case ScanningMode.quick:
        screenName = AnalyticsConstants.screenNameQuickOrder;
      case ScanningMode.create:
        screenName = AnalyticsConstants.screenNameVmiCreateOrder;
      case ScanningMode.count:
        screenName = AnalyticsConstants.screenNameCountInventory;
    }
    return AnalyticsEvent(
      AnalyticsConstants.eventViewScreen,
      screenName,
    );
  }

  @override
  TelemetryEvent getTelemetryScreenEvent() {
    String screenName;
    switch (_scanningMode) {
      case ScanningMode.quick:
        screenName = AnalyticsConstants.screenNameQuickOrder;
      case ScanningMode.create:
        screenName = AnalyticsConstants.screenNameVmiCreateOrder;
      case ScanningMode.count:
        screenName = AnalyticsConstants.screenNameCountInventory;
    }
    return TelemetryEvent(
      screenName: screenName,
    );
  }
}

class QuickOrderPage extends StatefulWidget {
  final ScanningMode scanningMode;

  const QuickOrderPage({super.key, required this.scanningMode});

  @override
  State<QuickOrderPage> createState() => _QuickOrderPageState();
}

class _QuickOrderPageState extends State<QuickOrderPage> {
  late void Function(bool) callBack;
  FocusNode? autoFocusNode;

  bool isSearching = false;
  bool cameraFlash = false;
  bool canProcess = false;
  bool isProcessingOrder = false;
  String subTotal = '';
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        var quickOrderAutoCompleteState = context
            .read<QuickOrderAutoCompleteBloc>()
            .state is QuickOrderInitialState;
        final navigator = Navigator.of(context);
        if (quickOrderAutoCompleteState) {
          navigator.pop();
        } else {
          _popSearchBar();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: OptiAppColors.backgroundWhite,
        appBar: AppBar(
          title: Text(_getTitle(widget.scanningMode)),
          actions: <Widget>[
            Visibility(
              visible: !isSearching,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      cameraFlash = !cameraFlash;
                    });
                    context
                        .read<BarcodeScanBloc>()
                        .add(ScannerFlashOnOffEvent(cameraFlash));
                  },
                  icon: Icon(
                    cameraFlash ? Icons.flash_on : Icons.flash_off,
                  )),
            ),
            _buildAppBarMenu(),
          ],
        ),
        body: BlocConsumer<QuickOrderAutoCompleteBloc,
            QuickOrderAutoCompleteState>(
          listener: (context, state) {
            if (state is QuickOrderInitialState) {
              setState(() {
                isSearching = false;
              });
            } else {
              setState(() {
                isSearching = true;
              });
            }
          },
          builder: (context, state) {
            switch (state) {
              case QuickOrderInitialState():
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: Colors.black,
                      child: BarcodeScannerView(
                          callback: _handleBarcodeValue,
                          barcodeFullView: false),
                    ),
                    Positioned.fill(
                      top: CoreConstants.barcodeRectangleSize,
                      child: ColoredBox(
                        color: OptiAppColors.backgroundGray,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppStyle.borderRadius),
                                    color: AppStyle.neutral100,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      autoFocusNode = FocusNode();
                                      context
                                          .read<QuickOrderAutoCompleteBloc>()
                                          .add(QuickOrderStartSearchEvent(
                                              autoFocus: true));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: OptiAppColors.primaryColor,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            LocalizationConstants.search
                                                .localized(),
                                            style: OptiTextStyles.bodyFade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            BlocConsumer<OrderListBloc, OrderListState>(
                              listener: (context, state) {
                                if (state is OrderListNavigateToCartState) {
                                  context
                                      .read<CartCountCubit>()
                                      .onCartItemChange();
                                  context
                                      .read<CartCountCubit>()
                                      .onSelectCartTab();
                                  AppRoute.cart.navigate(context);
                                } else if (state
                                    is OrderListNavigateToVmiCheckoutState) {
                                  _handleVmiCheckout(state.cart);
                                } else if (state
                                    is OrderListAddToListSuccessState) {
                                  WishListCallbackHelper.addItemsToWishList(
                                      context,
                                      addToCartCollection: state.wishListLines,
                                      onAddedToCart: () {
                                    context
                                        .read<OrderListBloc>()
                                        .add(OrderListRemoveEvent());
                                  });
                                  CustomSnackBar.showSnackBarMessage(
                                      context, state.message ?? '');
                                } else if (state
                                    is OrderListAddToListFailedState) {
                                  showSignInDialog(context,
                                      message: LocalizationConstants
                                          .pleaseSignInBeforeAddingToList
                                          .localized());
                                } else if (state is OrderListAddFailedState) {
                                  context
                                      .read<BarcodeScanBloc>()
                                      .add(ScannerProductNotFoundEvent());
                                  _showAlert(context, message: state.message,
                                      onDismissAlert: () {
                                    context
                                        .read<BarcodeScanBloc>()
                                        .add(ScannerScanEvent(canProcess));
                                  });
                                } else if (state
                                        is OrderListQuickOrderProductAddState ||
                                    state
                                        is OrderListVmiQuickOrderProductAddState) {
                                  context
                                      .read<BarcodeScanBloc>()
                                      .add(ScannerProductFoundEvent());
                                } else if (state
                                    is OrderListStyleProductAddState) {
                                  context
                                      .read<BarcodeScanBloc>()
                                      .add(ScannerProductFoundEvent());
                                  handleStyleProductAdd(state.productEntity);
                                } else if (state
                                    is OrderListVmiStyleProductAddState) {
                                  context
                                      .read<BarcodeScanBloc>()
                                      .add(ScannerProductFoundEvent());
                                  handleVmiStyleProductAdd(state.vmiBinEntity);
                                } else if (state
                                    is OrderListVmiProductAddState) {
                                  context
                                      .read<BarcodeScanBloc>()
                                      .add(ScannerProductFoundEvent());
                                  handleVmiBinAdd(state.vmiBinEntity,
                                      state.previousOrderEntity);
                                }
                              },
                              buildWhen: (previous, current) =>
                                  current is OrderListInitialState ||
                                  current is OrderListLoadingState ||
                                  current is OrderListLoadedState ||
                                  current is OrderListFailedState,
                              builder: (context, state) {
                                subTotal = context
                                    .read<OrderListBloc>()
                                    .calculateSubtotal();
                                final hidePricingEnable = context
                                    .read<OrderListBloc>()
                                    .hidePricingEnable();
                                return Expanded(
                                  child: isProcessingOrder
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8),
                                                            child: Text(
                                                              _getContentTitle(
                                                                  widget
                                                                      .scanningMode),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style:
                                                                  OptiTextStyles
                                                                      .titleSmall,
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: state
                                                                  is OrderListLoadedState &&
                                                              state
                                                                  .quickOrderItemList
                                                                  .isNotEmpty,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              _clearAllCart(
                                                                  context);
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                const SizedBox(
                                                                    width: 8),
                                                                Text(
                                                                  LocalizationConstants
                                                                      .clear
                                                                      .localized(),
                                                                  style: OptiTextStyles
                                                                      .bodyFade,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: QuickOrderListWidget(
                                                          scanningMode: widget
                                                              .scanningMode,
                                                          callback:
                                                              _handleQuickOrderListCallback),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 32,
                                                      vertical: 8),
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white),
                                              child: Column(
                                                children: [
                                                  Visibility(
                                                    visible:
                                                        widget.scanningMode !=
                                                            ScanningMode.count,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8),
                                                            child: Text(
                                                              (state is OrderListLoadedState &&
                                                                      state
                                                                          .quickOrderItemList
                                                                          .isNotEmpty)
                                                                  ? LocalizationConstants
                                                                      .listTotalProducts
                                                                      .localized()
                                                                      .format([
                                                                      state
                                                                          .quickOrderItemList
                                                                          .length
                                                                    ])
                                                                  : LocalizationConstants
                                                                      .listTotal
                                                                      .localized(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style:
                                                                  OptiTextStyles
                                                                      .subtitle,
                                                            ),
                                                          ),
                                                        ),
                                                        if (!hidePricingEnable)
                                                          Expanded(
                                                            child: Text(
                                                              subTotal,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style:
                                                                  OptiTextStyles
                                                                      .subtitle,
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  TertiaryButton(
                                                    isEnabled: (state
                                                                is OrderListLoadedState &&
                                                            state
                                                                .quickOrderItemList
                                                                .isNotEmpty)
                                                        ? true
                                                        : false,
                                                    onPressed: () {
                                                      _addToCart(context,
                                                          widget.scanningMode);
                                                    },
                                                    text:
                                                        _getCheckoutButtonTitle(
                                                            widget
                                                                .scanningMode),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  PrimaryButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        canProcess =
                                                            !canProcess;
                                                      });
                                                      context
                                                          .read<
                                                              BarcodeScanBloc>()
                                                          .add(ScannerScanEvent(
                                                              canProcess));
                                                    },
                                                    backgroundColor: canProcess
                                                        ? OptiAppColors
                                                            .buttonDarkRedBackgroudColor
                                                        : OptiAppColors
                                                            .primaryColor,
                                                    text: canProcess
                                                        ? LocalizationConstants
                                                            .cancel
                                                            .localized()
                                                        : LocalizationConstants
                                                            .tapToScan
                                                            .localized(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              default:
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: Input(
                        hintText: LocalizationConstants.search.localized(),
                        suffixIcon: IconButton(
                          icon: SvgAssetImage(
                            assetName: AssetConstants.iconClear,
                            semanticsLabel: 'search query clear icon',
                            fit: BoxFit.fitWidth,
                          ),
                          onPressed: () {
                            textEditingController.clear();
                            context
                                .read<QuickOrderAutoCompleteBloc>()
                                .add(QuickOrderTypingEvent(''));
                          },
                        ),
                        textInputAction: TextInputAction.search,
                        focusListener: (bool hasFocus) {
                          if (hasFocus) {
                            context
                                .read<QuickOrderAutoCompleteBloc>()
                                .add(QuickOrderFocusEvent());
                          } else {
                            context
                                .read<QuickOrderAutoCompleteBloc>()
                                .add(QuickOrderUnFocusEvent());
                          }
                        },
                        onChanged: (String searchQuery) {
                          context
                              .read<QuickOrderAutoCompleteBloc>()
                              .add(QuickOrderTypingEvent(searchQuery));
                        },
                        controller: textEditingController,
                        autoFocusNode: autoFocusNode,
                      ),
                    ),
                    Expanded(child: _buildAutoCompleteContainer(state)),
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  void _popSearchBar() {
    textEditingController.clear();
    context.closeKeyboard();
    context.read<QuickOrderAutoCompleteBloc>().add(QuickOrderTypingEvent(''));
    context.read<QuickOrderAutoCompleteBloc>().add(QuickOrderEndSearchEvent());
  }

  Widget _buildAutoCompleteContainer(QuickOrderAutoCompleteState state) {
    if (state is QuickOrderAutoCompleteInitialState) {
      if (state.autoFocus) {
        autoFocusNode?.requestFocus();
      }
      return Center(
        child: Text(
          LocalizationConstants.searchPrompt.localized(),
          style: OptiTextStyles.body,
        ),
      );
    } else if (state is QuickOrderAutoCompleteLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is QuickOrderAutoCompleteLoadedState) {
      final autoCompleteProductList = state.result?.products;
      return AutoCompleteWidget(
        callback: _handleAutoCompleteCallback,
        autoCompleteProductList: autoCompleteProductList,
      );
    } else if (state is QuickOrderAutoCompleteFailureState) {
      return Center(
        child: Text(
          state.error,
          style: OptiTextStyles.body,
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> _addToCart(
      BuildContext context, ScanningMode scanningMode) async {
    _processingOrder(true);

    var reversedQuickOrderProductsList =
        context.read<OrderListBloc>().getReversedQuickOrderItemEntityList();
    var currentCartProducts = <String>{};
    var allCountCartProducts = <String>{};

    var addCartLines = context.read<OrderListBloc>().getAddCartLines(
        scanningMode: scanningMode,
        reversedQuickOrderProductsList: reversedQuickOrderProductsList,
        allCountCartProducts: allCountCartProducts,
        currentCartProducts: currentCartProducts);

    if (addCartLines.any((x) => x.qtyOrdered == null || x.qtyOrdered == 0)) {
      _processingOrder(false);
      displayDialogWidget(
          context: context,
          title: LocalizationConstants.removeItem.localized(),
          message: LocalizationConstants.removeItemInfoMessage.localized(),
          actions: [
            DialogPlainButton(
              onPressed: () {
                addCartLines.removeWhere(
                    (x) => x.qtyOrdered == null || x.qtyOrdered == 0);
                if (addCartLines.isEmpty) {
                  context.read<OrderListBloc>().add(OrderListRemoveEvent());
                }
                Navigator.of(context).pop();
              },
              child: Text(LocalizationConstants.remove.localized()),
            ),
            DialogPlainButton(
              onPressed: () {
                for (var quickOrderItemEntity
                    in context.read<OrderListBloc>().quickOrderItemList) {
                  if (quickOrderItemEntity.quantityOrdered == 0) {
                    quickOrderItemEntity.quantityOrdered =
                        quickOrderItemEntity.previousQty;
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text(LocalizationConstants.cancel.localized()),
            ),
          ]);
      return;
    }

    if (allCountCartProducts.isNotEmpty && currentCartProducts.isEmpty) {
      _processingOrder(false);
      final icon = _buildWarningIcon();
      _showAlert(context,
          icon: icon,
          title: LocalizationConstants.productCanNotBeReOrdered.localized(),
          message: SiteMessageConstants.defaultAllProductCountExceed);
      return;
    }

    await context
        .read<OrderListBloc>()
        .deleteExistingCartLine(currentCartProducts);

    var addToCartCartLineList =
        await context.read<OrderListBloc>().addCartLineCollection(addCartLines);
    if (addToCartCartLineList != null) {
      if (addToCartCartLineList.isEmpty) {
        _showAlert(context,
            title: LocalizationConstants.quickOrder.localized(),
            message: SiteMessageConstants.defaultValueProductOutOfStock);
        return;
      }
      if (addToCartCartLineList.length == addCartLines.length) {
        final message = await context.read<OrderListBloc>().getSiteMessage(
            SiteMessageConstants.nameAddToCartAllProductsSuccess,
            SiteMessageConstants.defaultValueAddToCartAllProductsFromList);
        CustomSnackBar.showSnackBarMessage(context, message);
      } else {
        CustomSnackBar.showSnackBarMessage(
            context, SiteMessageConstants.defaultValueProductOutOfStock);
      }

      if (scanningMode == ScanningMode.count ||
          scanningMode == ScanningMode.create) {
        if (allCountCartProducts.isNotEmpty &&
            currentCartProducts.isNotEmpty &&
            allCountCartProducts.length != currentCartProducts.length) {
          CustomSnackBar.showSnackBarMessage(
              context, SiteMessageConstants.defaultSomeProductCountExceed,
              seconds: 3);
        }
      }

      context.read<OrderListBloc>().add(OrderListAddToCartEvent());
    } else {
      final message = await context.read<OrderListBloc>().getSiteMessage(
          SiteMessageConstants.nameAddToCartFail,
          SiteMessageConstants.defaultValueAddToCartFail);
      CustomSnackBar.showSnackBarMessage(context, message);
    }
    _processingOrder(false);
  }

  void _processingOrder(bool isEnabled) {
    setState(() {
      isProcessingOrder = isEnabled;
    });
  }

  void _showAlert(BuildContext context,
      {Widget? icon,
      String? title,
      String? message,
      void Function()? onDismissAlert}) {
    displayDialogWidget(
        context: context,
        icon: icon,
        title: title,
        message: message,
        actions: [
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDismissAlert?.call();
            },
            child: Text(LocalizationConstants.oK.localized()),
          ),
        ]);
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

  void _clearAllCart(BuildContext context) {
    displayDialogWidget(
        context: context,
        title: "",
        message: LocalizationConstants.removeAllProducts.localized(),
        actions: [
          DialogPlainButton(
            onPressed: () {
              context.read<OrderListBloc>().add(OrderListRemoveEvent());
              Navigator.of(context).pop();
            },
            child: Text(LocalizationConstants.remove.localized()),
          ),
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(LocalizationConstants.cancel.localized()),
          ),
        ]);
  }

  void _addToList(BuildContext context) {
    if (context.read<OrderListBloc>().quickOrderItemList.isEmpty) {
      CustomSnackBar.showSnackBarMessage(
          context, LocalizationConstants.quickOrderBasketEmpty.localized());
    } else {
      context.read<OrderListBloc>().add(OrderListAddToListEvent());
    }
  }

  void _handleQuickOrderListCallback(
      BuildContext context,
      QuickOrderItemEntity quickOrderItemEntity,
      OrderCallBackType orderCallBackType) {
    if (orderCallBackType == OrderCallBackType.quantityChange) {
      context.read<OrderListBloc>().add(OrderListLoadEvent());
    } else if (orderCallBackType == OrderCallBackType.newCount) {
      context.read<OrderListBloc>().add(OrderListItemScanAddEvent(
          resultText: quickOrderItemEntity.vmiBinEntity?.binNumber ?? ''));
    } else if (orderCallBackType == OrderCallBackType.itemDelete) {
      context
          .read<OrderListBloc>()
          .add(OrderListItemRemoveEvent(quickOrderItemEntity.productEntity));
    } else if (orderCallBackType == OrderCallBackType.calculateSubtotal) {
      setState(() {
        subTotal = context.read<OrderListBloc>().calculateSubtotal();
      });
    }
  }

  void _handleAutoCompleteCallback(
      BuildContext context, AutocompleteProduct product) {
    context.closeKeyboard();
    textEditingController.clear();
    context.read<QuickOrderAutoCompleteBloc>().add(QuickOrderEndSearchEvent());
    context.read<OrderListBloc>().add(OrderListItemAddEvent(product));
  }

  Widget _buildAppBarMenu() {
    return Visibility(
      visible: widget.scanningMode != ScanningMode.create,
      child: BottomMenuWidget(
          toolMenuList: _buildToolMenu(context), isViewOnWebsiteEnable: false),
    );
  }

  List<ToolMenu> _buildToolMenu(BuildContext context) {
    var isOrderListEmpty = context.watch<OrderListBloc>().isOrderListEmpty();
    var list = <ToolMenu>[];
    if (widget.scanningMode == ScanningMode.count &&
        isOrderListEmpty == false) {
      list.add(ToolMenu(
          title: LocalizationConstants.clearHistory.localized(),
          action: () {
            _clearAllCart(context);
          }));
    } else if (widget.scanningMode == ScanningMode.quick) {
      list.add(ToolMenu(
          title: LocalizationConstants.addToList.localized(),
          action: () {
            _addToList(context);
          }));
      if (isOrderListEmpty == false) {
        list.add(ToolMenu(
            title: LocalizationConstants.removeAllProducts.localized(),
            action: () {
              _clearAllCart(context);
            }));
      }
    }

    return list;
  }

  Widget _buildWarningIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: OptiAppColors.invalidColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999999),
        ),
      ),
      child: const Icon(
        Icons.warning_amber, // Icon to display
        color: OptiAppColors.backgroundWhite, // Icon color
        size: 20, // Icon size
      ),
    );
  }

  _handleBarcodeValue(BuildContext context,
      {String? resultText, BarcodeFormat? format}) {
    setState(() {
      cameraFlash = false;
      canProcess = false;
    });
    context.read<BarcodeScanBloc>().add(ScannerFlashOnOffEvent(cameraFlash));
    context.read<BarcodeScanBloc>().add(ScannerScanEvent(canProcess));
    if (resultText != null) {
      context.read<OrderListBloc>().add(OrderListItemScanAddEvent(
            resultText: resultText,
            barcodeFormat: format,
          ));
    }
  }

  void handleStyleProductAdd(ProductEntity productEntity) {
    showStyleTraitFilter(productEntity, context,
        onGetProduct: (StyledProductEntity? styleProduct) {
      context
          .read<OrderListBloc>()
          .add(OrderListAddStyleProductEvent(styleProduct!));
    });
  }

  void handleVmiStyleProductAdd(VmiBinModelEntity vmiBinEntity) {
    showStyleTraitFilter(vmiBinEntity.productEntity!, context,
        onGetProduct: (StyledProductEntity? styleProduct) {
      context
          .read<OrderListBloc>()
          .add(OrderListAddVmiStyleProductEvent(vmiBinEntity, styleProduct!));
    });
  }

  void handleVmiBinAdd(
      VmiBinModelEntity vmiBinEntity, OrderEntity? previousOrder) async {
    final result = await context.pushNamed<CountInventoryEntity>(
      AppRoute.countInventory.name,
      extra: CountInventoryEntity(
          vmiBinEntity: vmiBinEntity, previousOrder: previousOrder),
    );

    if (!context.mounted) {
      return;
    }

    if (result != null) {
      context
          .read<OrderListBloc>()
          .add(OrderListAddVmiBinEvent(result.vmiBinEntity, result.qty ?? 0));
    } else {
      context.read<OrderListBloc>().add(OrderListLoadEvent());
    }
  }

  void _handleVmiCheckout(Cart cart) async {
    final vmiCheckoutEntity = VmiCheckoutEntity(cart, widget.scanningMode);
    await context.pushNamed(
      AppRoute.vmiCheckout.name,
      extra: vmiCheckoutEntity,
    );

    context.read<OrderListBloc>().add(OrderListReLoadEvent());
  }

  String _getTitle(ScanningMode scanningMode) {
    if (scanningMode == ScanningMode.count) {
      return LocalizationConstants.countInventory.localized();
    } else if (scanningMode == ScanningMode.create) {
      return LocalizationConstants.createOrder.localized();
    } else {
      return LocalizationConstants.quickOrder.localized();
    }
  }

  String _getContentTitle(ScanningMode scanningMode) {
    if (scanningMode == ScanningMode.count) {
      return LocalizationConstants.countHistory.localized();
    } else if (scanningMode == ScanningMode.create) {
      return LocalizationConstants.orderContents.localized();
    } else {
      return LocalizationConstants.quickOrderContents.localized();
    }
  }

  String _getCheckoutButtonTitle(ScanningMode scanningMode) {
    if (scanningMode == ScanningMode.count) {
      return LocalizationConstants.checkout.localized();
    } else if (scanningMode == ScanningMode.create) {
      return LocalizationConstants.checkout.localized();
    } else {
      return LocalizationConstants.addToCartAndCheckout.localized();
    }
  }
}

enum OrderCallBackType {
  quantityChange,
  newCount,
  itemDelete,
  calculateSubtotal
}
