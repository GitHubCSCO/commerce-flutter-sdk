import 'package:commerce_flutter_app/features/domain/enums/address_type.dart';
import 'package:commerce_flutter_app/features/domain/enums/state_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/billto_shipto_usecase/address_selection/billto_shipto_address_selection_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/billto_shipto/billto_shipto_address_selection_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'billto_shipto_address_selection_event.dart';

part 'billto_shipto_address_selection_state.dart';

class BilltoShiptoAddressSelectionBloc extends Bloc<
    BilltoShiptoAddressSelectionEvent, BilltoShiptoAddressSelectionState> {
  final BillToShipToAddressSelectionUseCase
      _billToShipToAddressSelectionUseCase;

  BilltoShiptoAddressSelectionBloc(
      {required BillToShipToAddressSelectionUseCase
          billToShipToAddressSelectionUseCase})
      : _billToShipToAddressSelectionUseCase =
            billToShipToAddressSelectionUseCase,
        super(BilltoShiptoAddressSelectionState(
            list: null, pagination: null, status: StateStatus.initial)) {
    on<BilltoShiptoAddressLoadEvent>(
        (event, emit) => _onBilltoShiptoAddressLoadEvent(event, emit));
    on<BilltoShiptoAddressLoadMoreEvent>(
        (event, emit) => _onBilltoShiptoAddressLoadMoreEvent(event, emit));
  }

  Future<void> _onBilltoShiptoAddressLoadEvent(
      BilltoShiptoAddressLoadEvent event,
      Emitter<BilltoShiptoAddressSelectionState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    if (event.selectionEntity.addressType == AddressType.billTo) {
      await _loadBillToAddress(event.searchQuery, event.currentPage, emit);
    } else {
      await _loadShipToAddress(event.selectionEntity.selectedBillTo?.id ?? '',
          event.searchQuery, event.currentPage, emit);
    }
  }

  Future<void> _onBilltoShiptoAddressLoadMoreEvent(
      BilltoShiptoAddressLoadMoreEvent event,
      Emitter<BilltoShiptoAddressSelectionState> emit) async {
    if (event.selectionEntity.addressType == AddressType.billTo) {
      await _loadMoreBillToAddress(event.searchQuery, emit);
    } else {
      await _loadMoreShipToAddress(
          event.selectionEntity.selectedBillTo?.id ?? '',
          event.searchQuery,
          emit);
    }
  }

  Future<void> _loadBillToAddress(String query, int currentPage,
      Emitter<BilltoShiptoAddressSelectionState> emit) async {
    final result = await _billToShipToAddressSelectionUseCase
        .getBillToAddresses(query, currentPage);

    switch (result) {
      case Success(value: final data):
        emit(state.copyWith(
            list: data?.billTos,
            pagination: data?.pagination,
            status: StateStatus.success));
      case Failure(errorResponse: final error):
        _billToShipToAddressSelectionUseCase.trackError(error);
        emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> _loadMoreBillToAddress(
      String query, Emitter<BilltoShiptoAddressSelectionState> emit) async {
    if (state.pagination?.page == null ||
        (state.pagination?.page ?? 0) + 1 >
            (state.pagination?.numberOfPages ?? 0) ||
        state.status == StateStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(status: StateStatus.moreLoading));
    final result = await _billToShipToAddressSelectionUseCase
        .getBillToAddresses(query, (state.pagination?.page ?? 0) + 1);

    switch (result) {
      case Success(value: final data):
        state.list?.addAll(data?.billTos ?? []);
        emit(state.copyWith(
            list: data?.billTos,
            pagination: data?.pagination,
            status: StateStatus.success));
      case Failure(errorResponse: final error):
        _billToShipToAddressSelectionUseCase.trackError(error);
        emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> _loadShipToAddress(String billToId, String query,
      int currentPage, Emitter<BilltoShiptoAddressSelectionState> emit) async {
    final result = await _billToShipToAddressSelectionUseCase
        .getShipToAddresses(billToId, query, currentPage);

    switch (result) {
      case Success(value: final data):
        emit(state.copyWith(
            list: data?.shipTos,
            pagination: data?.pagination,
            status: StateStatus.success));
      case Failure(errorResponse: final error):
        _billToShipToAddressSelectionUseCase.trackError(error);
        emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> _loadMoreShipToAddress(String billToId, String query,
      Emitter<BilltoShiptoAddressSelectionState> emit) async {
    if (state.pagination?.page == null ||
        (state.pagination?.page ?? 0) + 1 >
            (state.pagination?.numberOfPages ?? 0) ||
        state.status == StateStatus.moreLoading) {
      return;
    }
    emit(state.copyWith(status: StateStatus.moreLoading));
    final result = await _billToShipToAddressSelectionUseCase
        .getShipToAddresses(billToId, query, (state.pagination?.page ?? 0) + 1);

    switch (result) {
      case Success(value: final data):
        state.list?.addAll(data?.shipTos ?? []);
        emit(state.copyWith(
            list: state.list,
            pagination: data?.pagination,
            status: StateStatus.success));
      case Failure(errorResponse: final error):
        _billToShipToAddressSelectionUseCase.trackError(error);
        emit(state.copyWith(status: StateStatus.moreLoadingFailure));
    }
  }
}
