import 'dart:async';

import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/vmi_bin_model_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quick_order_usecase/quick_order_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  List<QuickOrderItemEntity> quickOrderItemList = [];
  final QuickOrderUseCase _quickOrderUseCase;
  final SearchUseCase _searchUseCase;
  final PricingInventoryUseCase _pricingInventoryUseCase;
  final ScanningMode scanningMode;
  bool isPreviouslyScannedItem = false;
  ProductSettings? productSettings;
  String? instructionsMessage;

  OrderListBloc({
    required QuickOrderUseCase quickOrderUseCase,
    required SearchUseCase searchUseCase,
    required PricingInventoryUseCase pricingInventoryUseCase,
    required this.scanningMode,
  })  : _quickOrderUseCase = quickOrderUseCase,
        _searchUseCase = searchUseCase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(OrderListInitialState()) {
    on<OrderListInitialEvent>(_onOrderListInitialEvent);
    on<OrderListLoadEvent>(_onOrderListLoadEvent);
    on<OrderListReLoadEvent>(_onOrderListReLoadEvent);
    on<OrderListItemAddEvent>(_onOrderLisItemAddEvent);
    on<OrderListItemScanAddEvent>(_onOrderLisScanItemAddEvent);
    on<OrderListItemQuantityChangeEvent>(_onOrderListItemQuantityChangeEvent);
    on<OrderListItemUomChangeEvent>(_onOrderListItemUomChangeEvent);
    on<OrderListItemRemoveEvent>(_onOrderListItemRemoveEvent);
    on<OrderListAddToCartEvent>(_onOrderListAddToCartEvent);
    on<OrderListRemoveEvent>(_onOrderListRemoveEvent);
    on<OrderListAddToListEvent>(_onOrderListAddToListEvent);
    on<OrderListAddStyleProductEvent>(_onOrderListAddStyleProductEvent);
    on<OrderListAddVmiStyleProductEvent>(_onOrderListAddVmiStyleProductEvent);
    on<OrderListAddVmiBinEvent>(_onOrderListAddVmiBinEvent);
  }

  Future<void> _createAlternateCart() async {
    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      await _quickOrderUseCase.createAlternateCart();
    }
  }

  @override
  Future<void> close() async {
    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      await _quickOrderUseCase.removeAlternateCart();
    }
    await super.close();
  }

  Future<void> _getProductSetting() async {
    if (productSettings == null) {
      var result = await _quickOrderUseCase.getProductSetting();
      productSettings = result.getResultSuccessValue(trackError: true);
    }
  }

  Future<void> _onOrderListInitialEvent(
      OrderListInitialEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    instructionsMessage = await _quickOrderUseCase.getSiteMessage(
        SiteMessageConstants.nameQuickOrderInstructions,
        SiteMessageConstants.defaultValueQuickOrderInstructions);
    await _createAlternateCart();
    _quickOrderUseCase.setScanningMode(scanningMode);
    final list = await _quickOrderUseCase.getPersistedData();
    quickOrderItemList = list;
    add(OrderListLoadEvent());
  }

  Future<void> _onOrderListLoadEvent(
      OrderListLoadEvent event, Emitter<OrderListState> emit) async {
    await _getProductSetting();

    if (quickOrderItemList.isNotEmpty) {
      emit(OrderListLoadedState(quickOrderItemList, productSettings));
    } else {
      emit(OrderListInitialState());
    }
  }

  Future<void> _onOrderListReLoadEvent(
      OrderListReLoadEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    final list = await _quickOrderUseCase.getPersistedData();
    quickOrderItemList = list;
    add(OrderListLoadEvent());
  }

  Future<void> _onOrderLisItemAddEvent(
      OrderListItemAddEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());

    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      final result = await _quickOrderUseCase
          .getVmiBin(event.autocompleteProduct.binNumber);

      await _addVmiOrderItem(result, emit, event.autocompleteProduct.binNumber);
    } else {
      final result = await _quickOrderUseCase.getProduct(
          event.autocompleteProduct.id!, event.autocompleteProduct);

      await _addOrderItem(result, emit);
    }
  }

  Future<void> _onOrderLisScanItemAddEvent(
      OrderListItemScanAddEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      final result = await _quickOrderUseCase.getVmiBin(event.resultText);
      await _addVmiOrderItem(result, emit, event.resultText);
    } else {
      final result = await _quickOrderUseCase.getScanProduct(
          event.resultText, event.barcodeFormat);
      if (result.getResultSuccessValue(trackError: true) != null) {
        await _addOrderItem(result, emit);
      } else {
        await _findProductWithRegularSearch(
            event.resultText, event.barcodeFormat, emit);
      }
    }
  }

  void _onOrderListItemQuantityChangeEvent(
      OrderListItemQuantityChangeEvent event, Emitter<OrderListState> emit) {
    _quickOrderUseCase.updateQuantityOfPersistedData(
        event.productId, event.quantityOrdered);
  }

  void _onOrderListItemUomChangeEvent(
      OrderListItemUomChangeEvent event, Emitter<OrderListState> emit) {
    _quickOrderUseCase.updateUomOfPersistedData(event.item);
  }

  Future<void> _findProductWithRegularSearch(String? searchQuery,
      BarcodeFormat? barcodeFormat, Emitter<OrderListState> emit) async {
    if (searchQuery == null) {
      emit(OrderListAddFailedState("No product found"));
    } else {
      var result =
          await _searchUseCase.loadSearchProductsResults(searchQuery, 1);
      int totalItemCount =
          result?.getResultSuccessValue()?.pagination?.totalItemCount ?? 0;
      //This is a workaround for ICM-4422 where leading 0 in EAN-13 code gets dropped by the MLKit
      if (totalItemCount == 0 && barcodeFormat != null) {
        /*
        For example we have a product: 012546011099
        It's UPC-A will be: 0-12546-01109-9
        It's EAN-13 will be: 0-125460-110998
        When we scan UPC-A, it return successfully and we get 012546011099 and barcode format is BarcodeFormat.upca
        But, when we scan EAN-13, it returns 125460110998 and barcode format is BarcodeFormat.upca
        */
        if ((barcodeFormat == BarcodeFormat.ean13 ||
                barcodeFormat == BarcodeFormat.upca) &&
            searchQuery.length == 12) {
          //since in both cases result text is 12 digit it's difficult to know whether it's upc-a or ean13
          //upc-a can also have non-zero leading digit, since we didn't find any result with that
          //let's assume it's ean-13
          if (searchQuery[0] != '0') {
            var modifiedSearchQuery = "0$searchQuery";
            result = await _searchUseCase.loadSearchProductsResults(
                modifiedSearchQuery, 1);
          }
        }
      }
      var data = result?.getResultSuccessValue();
      final products = data?.products ?? [];
      if (products.isNotEmpty) {
        final product = products[0];
        if (product.isStyleProductParent ?? false) {
          var parameters = ProductQueryParameters(expand: "styledproducts");

          var result = (await _searchUseCase.commerceAPIServiceProvider
                  .getProductService()
                  .getProduct(product.id ?? '', parameters: parameters))
              .getResultSuccessValue(trackError: true);

          if (result?.product != null) {
            final productEntity =
                ProductEntityMapper.toEntity(result!.product!);
            await _addOrderItem(Success(productEntity), emit);
          }
        } else {
          final productEntity = ProductEntityMapper.toEntity(product);
          await _addOrderItem(Success(productEntity), emit);
        }
      } else {
        await _addOrderItem(const Success(null), emit);
      }
    }
  }

  Future<void> _onOrderListItemRemoveEvent(
      OrderListItemRemoveEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    quickOrderItemList
        .removeWhere((e) => e.productEntity == event.productEntity);
    await _quickOrderUseCase.removePersistedData(event.productEntity);
    await _getProductSetting();

    if (quickOrderItemList.isNotEmpty) {
      emit(OrderListLoadedState(quickOrderItemList, productSettings));
    } else {
      emit(OrderListInitialState());
    }
  }

  Future<void> _onOrderListRemoveEvent(
      OrderListRemoveEvent event, Emitter<OrderListState> emit) async {
    quickOrderItemList.clear();
    _quickOrderUseCase.clearAllPersistedData();
    emit(OrderListInitialState());
  }

  Future<void> _onOrderListAddToListEvent(
      OrderListAddToListEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    bool isUserAuthenticated = await _quickOrderUseCase.isAuthenticated();
    if (!isUserAuthenticated) {
      emit(OrderListAddToListFailedState());
    } else {
      List<AddCartLine> products = [];

      for (var quickOrderItemEntity in quickOrderItemList) {
        products.add(AddCartLine(
          productId: quickOrderItemEntity.productEntity.id,
          qtyOrdered: quickOrderItemEntity.quantityOrdered,
          unitOfMeasure:
              quickOrderItemEntity.productEntity.selectedUnitOfMeasureDisplay,
        ));
      }

      var wishListLines = WishListAddToCartCollection(
        wishListLines: products,
      );

      final message = await _quickOrderUseCase.getSiteMessage(
          SiteMessageConstants.nameQuickOrderInstructions,
          SiteMessageConstants.defaultValueQuickOrderInstructions);

      emit(OrderListAddToListSuccessState(wishListLines, message));
    }
  }

  Future<void> _onOrderListAddStyleProductEvent(
      OrderListAddStyleProductEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    await _getProductSetting();

    final result = await _quickOrderUseCase
        .getStyleProduct(event.styledProductEntity.productId!);
    switch (result) {
      case Success(value: final product):
        if (product == null) {
          final message = await _quickOrderUseCase.getSiteMessage(
              SiteMessageConstants.nameQuickOrderCannotOrderUnavailable,
              SiteMessageConstants
                  .defaultValueQuickOrderCannotOrderUnavailable);
          emit(OrderListAddFailedState(message));
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
          return;
        }
        var quantity =
            (product.minimumOrderQty! > 0) ? product.minimumOrderQty : 1;
        var newItem = _convertProductToQuickOrderItemEntity(product, quantity!);
        _insertItemIntoQuickOrderList(newItem);
        emit(OrderListLoadedState(quickOrderItemList, productSettings));
      case Failure():
        emit(OrderListLoadedState(quickOrderItemList, productSettings));
    }
  }

  Future<void> _onOrderListAddVmiStyleProductEvent(
      OrderListAddVmiStyleProductEvent event,
      Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    await _getProductSetting();

    final result = await _quickOrderUseCase
        .getStyleProduct(event.styledProductEntity.productId!);
    switch (result) {
      case Success(value: final product):
        if (product == null) {
          final message = await _quickOrderUseCase.getSiteMessage(
              SiteMessageConstants.nameQuickOrderCannotOrderUnavailable,
              SiteMessageConstants
                  .defaultValueQuickOrderCannotOrderUnavailable);
          emit(OrderListAddFailedState(message));
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
          return;
        }

        event.vmiBinEntity.productEntity = product;
        var quantity =
            (product.minimumOrderQty! > 0) ? product.minimumOrderQty : 1;
        var newItem = _convertVmiBinProductToQuickOrderItemEntity(
            event.vmiBinEntity, quantity!);
        _insertItemIntoQuickOrderList(newItem);
        emit(OrderListLoadedState(quickOrderItemList, productSettings));
      case Failure(errorResponse: final errorResponse):
        {
          _quickOrderUseCase.trackError(errorResponse);
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
        }
    }
  }

  Future<void> _onOrderListAddVmiBinEvent(
      OrderListAddVmiBinEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    await _getProductSetting();

    var newItem = _convertVmiBinProductToQuickOrderItemEntity(
        event.vmiBinEntity, event.quantity);
    _insertItemIntoQuickOrderList(newItem);

    emit(OrderListLoadedState(quickOrderItemList, productSettings));
  }

  Future<void> _addOrderItem(Result<ProductEntity, ErrorResponse> result,
      Emitter<OrderListState> emit) async {
    await _getProductSetting();

    switch (result) {
      case Success(value: final product):
        if (product == null) {
          final message = await _quickOrderUseCase.getSiteMessage(
              SiteMessageConstants.nameQuickOrderCannotOrderUnavailable,
              SiteMessageConstants
                  .defaultValueQuickOrderCannotOrderUnavailable);
          emit(OrderListAddFailedState(message));
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
          return;
        }

        var quantity = ((product.minimumOrderQty ?? 0) > 0)
            ? product.minimumOrderQty ?? 0
            : 1;

        if (product.isStyleProductParent == true) {
          emit(OrderListStyleProductAddState(product));
        } else if (product.canConfigure == true ||
            (product.isConfigured == true &&
                product.isFixedConfiguration == false)) {
          final message = await _quickOrderUseCase.getSiteMessage(
              SiteMessageConstants.nameQuickOrderCannotOrderConfigurable,
              SiteMessageConstants
                  .defaultValueQuickOrderCannotOrderConfigurable);
          emit(OrderListAddFailedState(message));
        } else if (product.canAddToCart == false) {
          final message = await _quickOrderUseCase.getSiteMessage(
              SiteMessageConstants.nameQuickOrderCannotOrderUnavailable,
              SiteMessageConstants
                  .defaultValueQuickOrderCannotOrderUnavailable);
          emit(OrderListAddFailedState(message));
        } else {
          var newItem =
              _convertProductToQuickOrderItemEntity(product, quantity);
          _insertItemIntoQuickOrderList(newItem);
        }

        emit(OrderListLoadedState(quickOrderItemList, productSettings));
      case Failure(errorResponse: final errorResponse):
        {
          _quickOrderUseCase.trackError(errorResponse);
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
        }
    }
  }

  Future<void> _addVmiOrderItem(Result<GetVmiBinResult, ErrorResponse> result,
      Emitter<OrderListState> emit, String? searchValue) async {
    await _getProductSetting();

    switch (result) {
      case Success(value: final data):
        if ((data?.vmiBins ?? []).isEmpty) {
          emit(OrderListAddFailedState(LocalizationConstants.notFoundForSearch
              .localized()
              .format([searchValue])));
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
        } else if ((data?.vmiBins ?? []).length == 1) {
          final vmiBin = VmiBinModelEntityMapper.toEntity(data!.vmiBins.first);

          if (vmiBin.productEntity == null) {
            final message = await _quickOrderUseCase.getSiteMessage(
                SiteMessageConstants.nameQuickOrderCannotOrderUnavailable,
                SiteMessageConstants
                    .defaultValueQuickOrderCannotOrderUnavailable);
            emit(OrderListAddFailedState(message));
            emit(OrderListLoadedState(quickOrderItemList, productSettings));
            return;
          }

          if (scanningMode == ScanningMode.count) {
            final result = await _quickOrderUseCase.getPreviousOrder(vmiBin.id);
            final previousOrder = result.getResultSuccessValue();

            emit(OrderListVmiProductAddState(vmiBin, previousOrder));
            return;
          } else {
            var quantity = (vmiBin.productEntity!.minimumOrderQty! > 0)
                ? vmiBin.productEntity!.minimumOrderQty
                : 1;

            if (vmiBin.productEntity?.isStyleProductParent == true) {
              emit(OrderListVmiStyleProductAddState(vmiBin));
            } else if (vmiBin.productEntity?.canConfigure == true ||
                (vmiBin.productEntity?.isConfigured == true &&
                    vmiBin.productEntity?.isFixedConfiguration == false)) {
              final message = await _quickOrderUseCase.getSiteMessage(
                  SiteMessageConstants.nameQuickOrderCannotOrderConfigurable,
                  SiteMessageConstants
                      .defaultValueQuickOrderCannotOrderConfigurable);
              emit(OrderListAddFailedState(message));
            } else if (vmiBin.productEntity?.canAddToCart == false) {
              final message = await _quickOrderUseCase.getSiteMessage(
                  SiteMessageConstants.nameQuickOrderCannotOrderUnavailable,
                  SiteMessageConstants
                      .defaultValueQuickOrderCannotOrderUnavailable);
              emit(OrderListAddFailedState(message));
            } else {
              var newItem = _convertVmiBinProductToQuickOrderItemEntity(
                  vmiBin, quantity!);
              _insertItemIntoQuickOrderList(newItem);
            }

            emit(OrderListLoadedState(quickOrderItemList, productSettings));
          }
        } else {
          emit(OrderListAddFailedState(LocalizationConstants
              .tooManyResultsForSearch
              .localized()
              .format([searchValue])));
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
        }
      case Failure(errorResponse: final errorResponse):
        {
          _quickOrderUseCase.trackError(errorResponse);
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
        }
    }
  }

  List<QuickOrderItemEntity> getReversedQuickOrderItemEntityList() {
    List<QuickOrderItemEntity> reversedQuickOrderProductsList =
        List.from(quickOrderItemList);
    reversedQuickOrderProductsList =
        reversedQuickOrderProductsList.reversed.toList();
    return reversedQuickOrderProductsList;
  }

  bool isOrderListEmpty() {
    return quickOrderItemList.isEmpty;
  }

  List<AddCartLine> getAddCartLines(
      {required ScanningMode scanningMode,
      required List<QuickOrderItemEntity> reversedQuickOrderProductsList,
      required Set<String> allCountCartProducts,
      required Set<String> currentCartProducts}) {
    List<AddCartLine> addCartLines = [];

    for (var x in reversedQuickOrderProductsList) {
      if (scanningMode == ScanningMode.count) {
        allCountCartProducts.add(x.productEntity.id.toString());
        var orderCount = (x.vmiBinEntity?.maximumQty ?? 0) - x.quantityOrdered;
        if (orderCount > 0) {
          currentCartProducts.add(x.productEntity.id.toString());
          addCartLines.add(AddCartLine(
            productId: x.productEntity.id,
            qtyOrdered: (x.vmiBinEntity?.maximumQty ?? 0) - x.quantityOrdered,
            unitOfMeasure: x.productEntity.selectedUnitOfMeasure,
            vmiBinId: x.vmiBinEntity!.id,
            // properties: Properties(),
          ));
        }
      } else if (scanningMode == ScanningMode.create) {
        addCartLines.add(AddCartLine(
          productId: x.productEntity.id,
          qtyOrdered: x.quantityOrdered,
          unitOfMeasure: x.selectedUnitOfMeasure?.unitOfMeasure,
          vmiBinId: x.vmiBinEntity!.id,
          // properties: Properties(),
        ));
      } else {
        addCartLines.add(AddCartLine(
          productId: x.productEntity.id,
          qtyOrdered: x.quantityOrdered,
          unitOfMeasure: x.selectedUnitOfMeasure?.unitOfMeasure,
          // properties: Properties(),
        ));
      }
    }

    return addCartLines;
  }

  Future<void> deleteExistingCartLine(Set<String> currentCartProducts) async {
    if (scanningMode == ScanningMode.count) {
      var cartLinesResponse = await _quickOrderUseCase.getCartLineCollection();
      List<CartLine>? cartLines = cartLinesResponse is Success
          ? ((cartLinesResponse as Success).value as GetCartLinesResult)
              .cartLines
          : [];
      List<Future> listOfTasks = [];
      for (var oldCartLine in cartLines ?? []) {
        if (currentCartProducts.contains(oldCartLine.productId.toString())) {
          listOfTasks.add(_quickOrderUseCase.deleteCartLine(oldCartLine));
        }
      }
      await Future.wait(listOfTasks);
    }
  }

  Future<List<CartLine>?> addCartLineCollection(
      List<AddCartLine> addCartLines) async {
    var result = await _quickOrderUseCase.addCartLineCollection(addCartLines);
    return result.getResultSuccessValue(trackError: true);
  }

  Future<void> _onOrderListAddToCartEvent(
      OrderListAddToCartEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      final result = await _quickOrderUseCase.getCart();
      final cartResult = result.getResultSuccessValue(trackError: true);
      if (cartResult != null) {
        quickOrderItemList.clear();
        _quickOrderUseCase.clearAllPersistedData();
        emit(OrderListNavigateToVmiCheckoutState(cart: cartResult));
      } else {
        emit(OrderListFailedState());
      }
    } else {
      quickOrderItemList.clear();
      _quickOrderUseCase.clearAllPersistedData();
      emit(OrderListNavigateToCartState());
    }
  }

  Future<String> getSiteMessage(
      String messageName, String defaultMessage) async {
    return await _quickOrderUseCase.getSiteMessage(messageName, defaultMessage);
  }

  QuickOrderItemEntity _convertVmiBinProductToQuickOrderItemEntity(
      VmiBinModelEntity vmiBinEntity, int quantityOrdered) {
    QuickOrderItemEntity orderItemEntity =
        QuickOrderItemEntity(vmiBinEntity.productEntity!, quantityOrdered);
    orderItemEntity.vmiBinEntity = vmiBinEntity;

    return _convertToQuickOrderItemEntity(orderItemEntity);
  }

  QuickOrderItemEntity _convertProductToQuickOrderItemEntity(
      ProductEntity productEntity, int quantityOrdered) {
    QuickOrderItemEntity orderItemEntity =
        QuickOrderItemEntity(productEntity, quantityOrdered);

    return _convertToQuickOrderItemEntity(orderItemEntity);
  }

  QuickOrderItemEntity _convertToQuickOrderItemEntity(
      QuickOrderItemEntity orderItemEntity) {
    if (orderItemEntity.productEntity.productUnitOfMeasures != null) {
      if (orderItemEntity.productEntity.selectedUnitOfMeasure != null) {
        for (var unitOfMeasure
            in orderItemEntity.productEntity.productUnitOfMeasures!) {
          if (unitOfMeasure.unitOfMeasure ==
              orderItemEntity.productEntity.selectedUnitOfMeasure) {
            orderItemEntity.updateSelectedUnitOfMeasure(unitOfMeasure);
            break;
          } else {
            orderItemEntity.selectedUnitOfMeasure = null;
          }
        }
      } else {
        orderItemEntity.selectedUnitOfMeasure = null;
      }
    }

    final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();
    final hideInventoryEnable =
        _pricingInventoryUseCase.getHideInventoryEnable();

    orderItemEntity.hidePricingEnable = hidePricingEnable;
    orderItemEntity.hideInventoryEnable = hideInventoryEnable;

    return orderItemEntity;
  }

  void _insertItemIntoQuickOrderList(QuickOrderItemEntity item,
      {bool scanned = true}) {
    var sameProducts = quickOrderItemList
        .where((x) => x.productEntity.id == item.productEntity.id);

    if (sameProducts.isNotEmpty) {
      QuickOrderItemEntity existingItem = sameProducts.first;

      var itemIndexToFocus = quickOrderItemList.indexOf(existingItem);

      if (scanningMode == ScanningMode.count) {
        quickOrderItemList[itemIndexToFocus] = item;
        _quickOrderUseCase.persistedData(item,
            index: itemIndexToFocus, replace: true);
      } else {
        isPreviouslyScannedItem = true;
        // scrollToItemIndex = itemIndexToFocus;
        // existingItem.shouldFocusOnQuantity = true;
      }
    } else {
      if (scanned) {
        quickOrderItemList.insert(0, item);
        _quickOrderUseCase.persistedData(item, index: 0);
        // item.shouldFocusOnQuantity = true;
      } else {
        quickOrderItemList.add(item);
        _quickOrderUseCase.persistedData(item);
      }
    }
  }

  bool hidePricingEnable() => _pricingInventoryUseCase.getHidePricingEnable();

  String calculateSubtotal() {
    if (productSettings == null) {
      return '';
    }
    var canSeeAllPrices = productSettings!.canSeePrices;

    if (canSeeAllPrices != null && canSeeAllPrices) {
      double subtotalDecimal = quickOrderItemList.fold(0, (subtotal, x) {
        double? unitPrice = 0.0;

        if (x.pricing != null) {
          unitPrice = x.pricing!.unitNetPrice!.toDouble();
        } else if (x.productEntity.pricing != null) {
          unitPrice = x.productEntity.pricing?.unitNetPrice?.toDouble();
        }

        return subtotal + ((unitPrice ?? 0) * x.quantityOrdered);
      });

      return "${CoreConstants.currencySymbol}${subtotalDecimal.toStringAsFixed(2)}";
    } else {
      return SiteMessageConstants.valuePricingSignInForPrice;
    }
  }
}
