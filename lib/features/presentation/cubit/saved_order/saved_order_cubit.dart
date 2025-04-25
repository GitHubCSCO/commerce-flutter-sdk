import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/saved_order/saved_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'saved_order_state.dart';

class SavedOrderCubit extends Cubit<SavedOrderState> {
  final SavedOrderUsecase _savedOrderUsecase;
  final PricingInventoryUseCase _pricingInventoryUseCase;

  SavedOrderCubit(
      {required SavedOrderUsecase savedOrderUsecase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _savedOrderUsecase = savedOrderUsecase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(
          SavedOrderState(
            status: OrderStatus.initial,
            sortOrder: CartSortOrder.orderDateDescending,
            cartSettings: CartSettings(),
            cartCollectionModel: CartCollectionModel(
              pagination: null,
              carts: null,
            ),
          ),
        );

  Future<void> initialize() async {
    emit(state.copyWith(status: OrderStatus.loading));
    final settings = await _savedOrderUsecase.loadSettings();

    if (settings == null) {
      final message = await _savedOrderUsecase.getSiteMessage(
          SiteMessageConstants.nameMobileAppAlertCommunicationError,
          SiteMessageConstants.defaultMobileAppAlertCommunicationError);
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: message));
      return;
    }

    emit(state.copyWith(cartSettings: settings));
    await loadSavedOrders();
  }

  Future<void> loadSavedOrders() async {
    if (state.status != OrderStatus.loading) {
      emit(state.copyWith(status: OrderStatus.loading));
    }

    final result = await _savedOrderUsecase.loadSavedOrders(
      sortOrder: state.sortOrder,
      page: 1,
    );

    if (result == null) {
      final message = await _savedOrderUsecase.getSiteMessage(
          SiteMessageConstants.nameMobileAppAlertCommunicationError,
          SiteMessageConstants.defaultMobileAppAlertCommunicationError);
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: message));
      return;
    }

    final hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();

    emit(
      state.copyWith(
        status: OrderStatus.success,
        cartCollectionModel: result,
        hidePricingEnable: hidePricingEnable,
      ),
    );
  }

  Future<void> changeSortOrder(CartSortOrder sortOrder) async {
    emit(
      state.copyWith(
        sortOrder: sortOrder,
      ),
    );

    await loadSavedOrders();
  }

  Future<void> loadMoreSavedOrders() async {
    if (state.cartCollectionModel.pagination?.page == null ||
        state.cartCollectionModel.pagination!.page! + 1 >
            state.cartCollectionModel.pagination!.numberOfPages! ||
        state.status == OrderStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(status: OrderStatus.moreLoading));
    final result = await _savedOrderUsecase.loadSavedOrders(
      sortOrder: state.sortOrder,
      page: state.cartCollectionModel.pagination!.page! + 1,
    );

    if (result == null) {
      emit(state.copyWith(status: OrderStatus.moreLoadingFailure));
      return;
    }

    final newCarts = state.cartCollectionModel.carts;
    newCarts?.addAll(result.carts ?? []);

    emit(
      state.copyWith(
        status: OrderStatus.success,
        cartCollectionModel: CartCollectionModel(
          carts: newCarts,
          pagination: result.pagination,
        ),
      ),
    );
  }
}
