import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/barcode_scan/barcode_scan_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quick_order/auto_complete/quick_order_auto_complete_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quick_order/order_list/order_list_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/style_trait/style_trait_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/barcode_scanner/barcode_scanner_view.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/quick_order_list/quick_order_list_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/auto_complete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/style_trait_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BarcodeScanBloc>(create: (context) => sl<BarcodeScanBloc>()),
      BlocProvider<StyleTraitCubit>(
        create: (context) => sl<StyleTraitCubit>(),
      ),
      BlocProvider<OrderListBloc>(
          create: (context) => sl<OrderListBloc>()..add(OrderListLoadEvent())),
      BlocProvider<QuickOrderAutoCompleteBloc>(
        create: (context) {
          return QuickOrderAutoCompleteBloc(
            searchUseCase: sl(),
            scanningMode: ScanningMode.quick,
          );
        },
      )
    ], child: QuickOrderPage());
  }
}

class QuickOrderPage extends StatefulWidget {
  @override
  State<QuickOrderPage> createState() => _QuickOrderPageState();
}

class _QuickOrderPageState extends State<QuickOrderPage> {

  late void Function(bool) callBack;

  bool cameraFlash = false;
  bool canProcess = false;
  String subTotal = '';
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        title: const Text(LocalizationConstants.quickOrder),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  cameraFlash = !cameraFlash;
                });
                context.read<BarcodeScanBloc>().add(ScannerFlashOnOffEvent(cameraFlash));
              },
              icon: Icon(
                cameraFlash ? Icons.flash_on : Icons.flash_off,
                color: Colors.black,
              )),
          BottomMenuWidget(
              toolMenuList: _buildToolMenu(context), websitePath: 'websitePath', isViewOnWebsiteEnable: false)
        ],
      ),
      body: BlocConsumer<QuickOrderAutoCompleteBloc, QuickOrderAutoCompleteState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case QuickOrderInitialState:
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
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(AppStyle.borderRadius),
                                  color: AppStyle.neutral100,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    context
                                        .read<QuickOrderAutoCompleteBloc>()
                                        .add(QuickOrderStartSearchEvent());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          LocalizationConstants.search,
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
                                context.read<CartCountCubit>().onCartItemChange();
                                context.read<CartCountCubit>().onSelectCartTab();
                                AppRoute.cart.navigate(context);
                              } else if (state is OrderListAddToListSuccessState) {
                                WishListCallbackHelper.addItemsToWishList(
                                  context, 
                                  addToCartCollection: state.wishListLines,
                                  onAddedToCart: () {
                                    context
                                    .read<OrderListBloc>()
                                    .add(OrderListRemoveEvent());
                                  }
                                );
                                CustomSnackBar.showSnackBarMessage(
                                    context,
                                    SiteMessageConstants
                                        .defaultValueQuickOrderInstructions);
                                
                              } else if (state is OrderListAddToListFailedState) {
                                _showAlert(
                                    context,
                                    '',
                                    LocalizationConstants
                                        .pleaseSignInBeforeAddingToList);
                              } else if (state is OrderListAddFailedState) {
                                _showAlert(context, '', state.message);
                              } else if (state is OrderListStyleProductAddState) {
                                handleStyleProductAdd(state.productEntity);
                              } else if (state is OrderListVmiProductAddState) {
                                handleVmiBinAdd(state.vmiBin);
                              }
                            },
                            buildWhen: (previous, current) =>
                            current is OrderListInitialState ||
                                current is OrderListLoadingState ||
                                current is OrderListLoadedState ||
                                current is OrderListFailedState,
                            builder: (context, state) {
                              subTotal = context.read<OrderListBloc>().calculateSubtotal();
                              return Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                    const EdgeInsets.only(right: 8),
                                                    child: Text(
                                                      LocalizationConstants
                                                          .quickOrderContents,
                                                      textAlign: TextAlign.start,
                                                      style: OptiTextStyles.titleSmall,
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible:
                                                  state is OrderListLoadedState &&
                                                      state.quickOrderItemList
                                                          .isNotEmpty,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      _clearAllCart(context);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Text(
                                                          LocalizationConstants.clear,
                                                          style:
                                                          OptiTextStyles.bodyFade,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Expanded(
                                              child: QuickOrderListWidget(
                                                  callback:
                                                  _handleQuickOrderListCallback),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 16),
                                      clipBehavior: Clip.antiAlias,
                                      decoration:
                                      const BoxDecoration(color: Colors.white),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.only(right: 8),
                                                  child: Text(
                                                    (state is OrderListLoadedState &&
                                                        state.quickOrderItemList
                                                            .isNotEmpty)
                                                        ? LocalizationConstants
                                                        .listTotalProducts
                                                        .format([
                                                      state.quickOrderItemList
                                                          .length
                                                    ])
                                                        : LocalizationConstants
                                                        .listTotal,
                                                    textAlign: TextAlign.start,
                                                    style: OptiTextStyles.subtitle,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                subTotal,
                                                textAlign: TextAlign.start,
                                                style: OptiTextStyles.subtitle,
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          PrimaryButton(
                                            isEnabled: (state is OrderListLoadedState &&
                                                state.quickOrderItemList.isNotEmpty)
                                                ? true
                                                : false,
                                            onPressed: () {
                                              _addToCart(context);
                                            },
                                            text: LocalizationConstants
                                                .addToCartAndCheckout,
                                          ),
                                          const SizedBox(height: 4),
                                          PrimaryButton(
                                            onPressed: () {
                                              setState(() {
                                                canProcess = !canProcess;
                                              });
                                              context.read<BarcodeScanBloc>().add(ScannerScanEvent(canProcess));
                                            },
                                            backgroundColor: canProcess
                                                ? OptiAppColors.buttonDarkRedBackgroudColor
                                                : AppStyle.primary500,
                                            text: canProcess
                                                ? LocalizationConstants.cancel
                                                : LocalizationConstants.tapToScan,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    child: Input(
                      hintText: LocalizationConstants.search,
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          AssetConstants.iconClear,
                          semanticsLabel: 'search query clear icon',
                          fit: BoxFit.fitWidth,
                        ),
                        onPressed: () {
                          context
                              .read<QuickOrderAutoCompleteBloc>()
                              .add(QuickOrderEndSearchEvent());
                          textEditingController.clear();
                          context
                              .read<QuickOrderAutoCompleteBloc>()
                              .add(QuickOrderTypingEvent(''));
                          context.closeKeyboard();
                        },
                      ),
                      onTapOutside: (p0) => context.closeKeyboard(),
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
                      // onSubmitted: (String query) {
                      //   context.read<QuickOrderAutoCompleteBloc>().add(SearchSearchEvent());
                      // },
                      controller: textEditingController,
                    ),
                  ),
                  if (state is QuickOrderAutoCompleteInitialState)
                    Expanded(
                      child: Center(
                        child: Text(
                          LocalizationConstants.searchPrompt,
                          style: OptiTextStyles.body,
                        ),
                      ),
                    )
                  else if (state is QuickOrderAutoCompleteLoadingState)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (state is QuickOrderAutoCompleteLoadedState)
                    AutoCompleteWidget(
                      callback: _handleAutoCompleteCallback,
                      autocompleteResult: (state as QuickOrderAutoCompleteLoadedState).result!,
                    )
                  else if (state is QuickOrderAutoCompleteFailureState)
                    Center(
                      child: Text(
                        (state as QuickOrderAutoCompleteFailureState).error,
                        style: OptiTextStyles.body,
                      ),
                    ),
                ],
              );
          }
        },
      ),
    );
  }

  Future<void> _addToCart(BuildContext context) async {
    var reversedQuickOrderProductsList =
        context.read<OrderListBloc>().getReversedQuickOrderItemEntityList();
    Set<String> currentCartProducts = <String>{};

    List<AddCartLine> addCartLines = context
        .read<OrderListBloc>()
        .getAddCartLines(reversedQuickOrderProductsList, currentCartProducts);

    if (addCartLines.any((x) => x.qtyOrdered == null || x.qtyOrdered == 0)) {
      displayDialogWidget(
          context: context,
          title: LocalizationConstants.removeItem,
          message: LocalizationConstants.removeItemInfoMessage,
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
              child: const Text(LocalizationConstants.remove),
            ),
            DialogPlainButton(
              onPressed: () {
                for (var quickOrderItemEntity
                    in context.read<OrderListBloc>().quickOrderItemList) {
                  if (quickOrderItemEntity.quantityOrdered == 0) {
                    quickOrderItemEntity.quantityOrdered = quickOrderItemEntity.previousQty;
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text(LocalizationConstants.cancel),
            ),
          ]);
    }

    context.read<OrderListBloc>().deleteExistingCartLine(currentCartProducts);

    var addToCartCartLineList =
        await context.read<OrderListBloc>().addCartLineCollection(addCartLines);
    if (addToCartCartLineList != null) {
      if (addToCartCartLineList.isEmpty) {
        _showAlert(context, LocalizationConstants.quickOrder,
            SiteMessageConstants.defaultValueProductOutOfStock);
      }
      if (addToCartCartLineList.length == addCartLines.length) {
        CustomSnackBar.showSnackBarMessage(context,
            SiteMessageConstants.defaultValueAddToCartAllProductsFromList);
      } else {
        CustomSnackBar.showSnackBarMessage(
            context, SiteMessageConstants.defaultValueProductOutOfStock);
      }
      context.read<OrderListBloc>().add(OrderListAddToCartEvent());
    } else {
      CustomSnackBar.showSnackBarMessage(
          context, SiteMessageConstants.defaultValueAddToCartFail);
    }
  }

  void _showAlert(BuildContext context, String title, String message) {
    displayDialogWidget(
        context: context,
        title: title,
        message: message,
        actions: [
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.oK),
          ),
        ]);
  }

  void _clearAllCart(BuildContext context) {
    displayDialogWidget(
        context: context,
        title: "",
        message: LocalizationConstants.removeAllProducts,
        actions: [
          DialogPlainButton(
            onPressed: () {
              context.read<OrderListBloc>().add(OrderListRemoveEvent());
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.remove),
          ),
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.cancel),
          ),
        ]);
  }

  void _addToList(BuildContext context) {
    if (context.read<OrderListBloc>().quickOrderItemList.isEmpty) {
      CustomSnackBar.showSnackBarMessage(context,
          SiteMessageConstants.defaultValueAddToCartAllProductsFromList);
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

  List<ToolMenu> _buildToolMenu(BuildContext context) {
    List<ToolMenu> list = [];
    list.add(ToolMenu(
        title: LocalizationConstants.addToList,
        action: () {
          _addToList(context);
        }));
    list.add(ToolMenu(
        title: LocalizationConstants.removeAllProducts,
        action: () {
          _clearAllCart(context);
        }));
    return list;
  }

  _handleBarcodeValue(BuildContext context, String rawValue) {
    cameraFlash = false;
    canProcess = false;
    context.read<BarcodeScanBloc>().add(ScannerFlashOnOffEvent(cameraFlash));
    context.read<BarcodeScanBloc>().add(ScannerScanEvent(canProcess));
    context.read<OrderListBloc>().add(OrderListItemScanAddEvent(rawValue));
  }

  void handleStyleProductAdd(ProductEntity productEntity) {
    showStyleTraitFilter(productEntity, context, ongetProduct: (StyledProductEntity? styleProduct) {
      context.read<OrderListBloc>().add(OrderListAddStyleProductEvent(styleProduct!));
    });
  }

  void handleVmiBinAdd(VmiBinModel vmiBin) { {
    //Navigate to count page

    context.read<OrderListBloc>().add(OrderListAddVmiBinEvent(vmiBin, 0));
  }}

}

enum OrderCallBackType { quantityChange, itemDelete, calculateSubtotal }
