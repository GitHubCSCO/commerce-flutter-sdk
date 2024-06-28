import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quick_order_usecase/quick_order_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  List<QuickOrderItemEntity> quickOrderItemList = [];
  final QuickOrderUseCase _quickOrderUseCase;
  final ScanningMode scanningMode;
  bool isPreviouslyScannedItem = false;
  ProductSettings? productSettings;

  OrderListBloc(
      {required QuickOrderUseCase quickOrderUseCase,
      required this.scanningMode})
      : _quickOrderUseCase = quickOrderUseCase,
        super(OrderListInitialState()) {
    _createAlternateCart();
    on<OrderListLoadEvent>(_onOrderListLoadEvent);
    on<OrderListItemAddEvent>(_onOrderLisItemAddEvent);
    on<OrderListItemScanAddEvent>(_onOrderLisScanItemAddEvent);
    on<OrderListItemRemoveEvent>(_onOrderListItemRemoveEvent);
    on<OrderListAddToCartEvent>(_onOrderListAddToCartEvent);
    on<OrderListRemoveEvent>(_onOrderListRemoveEvent);
    on<OrderListAddToListEvent>(_onOrderListAddToListEvent);
    on<OrderListAddStyleProductEvent>(_onOrderListAddStyleProductEvent);
    on<OrderListAddVmiStyleProductEvent>(_onOrderListAddVmiStyleProductEvent);
    on<OrderListAddVmiBinEvent>(_onOrderListAddVmiBinEvent);
  }

  void _createAlternateCart() {
    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      _quickOrderUseCase.createAlternateCart();
    }
  }

  @override
  Future<void> close() async {
    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      _quickOrderUseCase.removeAlternateCart();
    }
    super.close();
  }

  Future<void> _onOrderListLoadEvent(
      OrderListLoadEvent event, Emitter<OrderListState> emit) async {
    if (productSettings == null) {
      var result = await _quickOrderUseCase.getProductSetting();
      productSettings = result is Success ? (result as Success).value : null;
    }

    if (quickOrderItemList.isNotEmpty) {
      emit(OrderListLoadedState(quickOrderItemList, productSettings));
    } else {
      emit(OrderListInitialState());
    }
  }

  Future<void> _onOrderLisItemAddEvent(
      OrderListItemAddEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());

    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      final result = await _quickOrderUseCase
          .getVmiBin(event.autocompleteProduct.binNumber);

      await _addVmiOrderItem(result, emit);
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
      final result = await _quickOrderUseCase.getVmiBin(event.name);

      await _addVmiOrderItem(result, emit);
    } else {
      final result = await _quickOrderUseCase.getScanProduct(event.name);

      await _addOrderItem(result, emit);
    }
  }

  Future<void> _onOrderListItemRemoveEvent(
      OrderListItemRemoveEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    quickOrderItemList
        .removeWhere((e) => e.productEntity == event.productEntity);
    if (productSettings == null) {
      var result = await _quickOrderUseCase.getProductSetting();
      productSettings = result is Success ? (result as Success).value : null;
    }

    if (quickOrderItemList.isNotEmpty) {
      emit(OrderListLoadedState(quickOrderItemList, productSettings));
    } else {
      emit(OrderListInitialState());
    }
  }

  Future<void> _onOrderListRemoveEvent(
      OrderListRemoveEvent event, Emitter<OrderListState> emit) async {
    quickOrderItemList.clear();
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

      emit(OrderListAddToListSuccessState(wishListLines));
    }
  }

  Future<void> _onOrderListAddStyleProductEvent(
      OrderListAddStyleProductEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    final result = await _quickOrderUseCase
        .getStyleProduct(event.styledProductEntity.productId!);
    switch (result) {
      case Success(value: final product):
        if (product == null) {
          emit(OrderListAddFailedState(SiteMessageConstants
              .defaultValueQuickOrderCannotOrderUnavailable));
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
    final result = await _quickOrderUseCase
        .getStyleProduct(event.styledProductEntity.productId!);
    switch (result) {
      case Success(value: final product):
        if (product == null) {
          emit(OrderListAddFailedState(SiteMessageConstants
              .defaultValueQuickOrderCannotOrderUnavailable));
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
      case Failure():
        emit(OrderListLoadedState(quickOrderItemList, productSettings));
    }
  }

  Future<void> _onOrderListAddVmiBinEvent(
      OrderListAddVmiBinEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());

    var newItem = _convertVmiBinProductToQuickOrderItemEntity(
        event.vmiBinEntity, event.quantity);
    _insertItemIntoQuickOrderList(newItem);

    emit(OrderListLoadedState(quickOrderItemList, productSettings));
  }

  Future<void> _addOrderItem(Result<ProductEntity, ErrorResponse> result,
      Emitter<OrderListState> emit) async {
    switch (result) {
      case Success(value: final product):
        if (product == null) {
          emit(OrderListAddFailedState(SiteMessageConstants
              .defaultValueQuickOrderCannotOrderUnavailable));
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
          return;
        }

        var quantity =
            (product.minimumOrderQty! > 0) ? product.minimumOrderQty : 1;

        if (product.isStyleProductParent!) {
          emit(OrderListStyleProductAddState(product));
        } else if (product.isConfigured! ||
            (product.isConfigured! && !product.isFixedConfiguration!)) {
          emit(OrderListAddFailedState(SiteMessageConstants
              .defaultValueQuickOrderCannotOrderConfigurable));
        } else if (!product.canAddToCart!) {
          emit(OrderListAddFailedState(SiteMessageConstants
              .defaultValueQuickOrderCannotOrderUnavailable));
        } else {
          var newItem =
              _convertProductToQuickOrderItemEntity(product, quantity!);
          _insertItemIntoQuickOrderList(newItem);
        }

        emit(OrderListLoadedState(quickOrderItemList, productSettings));
      case Failure(errorResponse: final errorResponse):
        emit(OrderListLoadedState(quickOrderItemList, productSettings));
    }
  }

  Future<void> _addVmiOrderItem(Result<VmiBinModelEntity, ErrorResponse> result,
      Emitter<OrderListState> emit) async {
    switch (result) {
      case Success(value: final vmiBin):
        if (vmiBin == null || vmiBin.productEntity == null) {
          emit(OrderListAddFailedState(SiteMessageConstants
              .defaultValueQuickOrderCannotOrderUnavailable));
          emit(OrderListLoadedState(quickOrderItemList, productSettings));
          return;
        }

        if (scanningMode == ScanningMode.count) {
          final result = await _quickOrderUseCase.getPreviousOrder(vmiBin.id);
          final previousOrder =
              (result is Success) ? (result as Success).value : null;

          emit(OrderListVmiProductAddState(vmiBin, previousOrder));
          return;
        } else {
          var quantity = (vmiBin.productEntity!.minimumOrderQty! > 0)
              ? vmiBin.productEntity!.minimumOrderQty
              : 1;

          if (vmiBin.productEntity!.isStyleProductParent!) {
            emit(OrderListVmiStyleProductAddState(vmiBin));
          } else if (vmiBin.productEntity!.isConfigured! ||
              (vmiBin.productEntity!.isConfigured! &&
                  !vmiBin.productEntity!.isFixedConfiguration!)) {
            emit(OrderListAddFailedState(SiteMessageConstants
                .defaultValueQuickOrderCannotOrderConfigurable));
          } else if (!vmiBin.productEntity!.canAddToCart!) {
            emit(OrderListAddFailedState(SiteMessageConstants
                .defaultValueQuickOrderCannotOrderUnavailable));
          } else {
            var newItem =
                _convertVmiBinProductToQuickOrderItemEntity(vmiBin, quantity!);
            _insertItemIntoQuickOrderList(newItem);
          }

          emit(OrderListLoadedState(quickOrderItemList, productSettings));
        }
      case Failure(errorResponse: final errorResponse):
        emit(OrderListLoadedState(quickOrderItemList, productSettings));
    }
  }

  List<QuickOrderItemEntity> getReversedQuickOrderItemEntityList() {
    List<QuickOrderItemEntity> reversedQuickOrderProductsList =
        List.from(quickOrderItemList);
    reversedQuickOrderProductsList =
        reversedQuickOrderProductsList.reversed.toList();
    return reversedQuickOrderProductsList;
  }

  List<AddCartLine> getAddCartLines({
    required ScanningMode scanningMode,
    required List<QuickOrderItemEntity> reversedQuickOrderProductsList,
    required Set<String> allCountCartProducts, 
    required Set<String> currentCartProducts
  }) {
    List<AddCartLine> addCartLines = [];
    
    for (var x in reversedQuickOrderProductsList) {
      if (scanningMode == ScanningMode.count) {
        allCountCartProducts.add(x.productEntity.id.toString());
        var orderCount = (x.vmiBinEntity?.maximumQty ?? 0) - x.quantityOrdered;
        if(orderCount > 0){
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
          ? ((cartLinesResponse as Success).value as GetCartLinesResult).cartLines
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
    return result is Success ? (result as Success).value : null;
  }

  Future<void> _onOrderListAddToCartEvent(
      OrderListAddToCartEvent event, Emitter<OrderListState> emit) async {
    emit(OrderListLoadingState());
    if (scanningMode == ScanningMode.count ||
        scanningMode == ScanningMode.create) {
      final result = await _quickOrderUseCase.getCart();
      final cartResult = result.getResultSuccessValue();
      if(cartResult!=null){
          quickOrderItemList.clear();
          emit(OrderListNavigateToVmiCheckoutState(
            cart: cartResult
          ));
      }else{
          emit(OrderListFailedState());
      }
    } else {
      emit(OrderListNavigateToCartState());
    }
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
      } else {
        isPreviouslyScannedItem = true;
        // scrollToItemIndex = itemIndexToFocus;
        // existingItem.shouldFocusOnQuantity = true;
      }
    } else {
      if (scanned) {
        quickOrderItemList.insert(0, item);
        // item.shouldFocusOnQuantity = true;
      } else {
        quickOrderItemList.add(item);
      }
    }
  }

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
