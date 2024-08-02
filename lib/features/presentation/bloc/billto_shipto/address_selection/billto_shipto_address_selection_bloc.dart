import 'package:commerce_flutter_app/features/domain/enums/address_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/billto_shipto_usecase/address_selection/billto_shipto_address_selection_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/billto_shipto/billto_shipto_address_selection_screen.dart';
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
        super(BilltoShiptoAddressSelectionInitial()) {
    on<BilltoShiptoAddressLoadEvent>(
        (event, emit) => _onBilltoShiptoAddressLoadEvent(event, emit));
  }

  Future<void> _onBilltoShiptoAddressLoadEvent(
      BilltoShiptoAddressLoadEvent event,
      Emitter<BilltoShiptoAddressSelectionState> emit) async {
    emit(BilltoShiptoAddressSelectionLoading());

    if (event.selectionEntity.addressType == AddressType.billTo) {
      await _loadBillToAddress(event.searchQuery, event.currentPage, emit);
    } else {
      await _loadShipToAddress(event.selectionEntity.selectedBillTo?.id ?? '',
          event.searchQuery, event.currentPage, emit);
    }
  }

  Future<void> _loadBillToAddress(String query, int currentPage,
      Emitter<BilltoShiptoAddressSelectionState> emit) async {
    final result = await _billToShipToAddressSelectionUseCase
        .getBillToAddresses(query, currentPage);

    switch (result) {
      case Success(value: final data):
        emit(BilltoShiptoAddressSelectionLoaded(list: data?.billTos));
      case Failure(errorResponse: final error):
        emit(BilltoShiptoAddressSelectionFailed());
    }
  }

  Future<void> _loadShipToAddress(String billToId, String query,
      int currentPage, Emitter<BilltoShiptoAddressSelectionState> emit) async {
    final result = await _billToShipToAddressSelectionUseCase
        .getShipToAddresses(billToId, query, currentPage);

    switch (result) {
      case Success(value: final data):
        emit(BilltoShiptoAddressSelectionLoaded(list: data?.shipTos));
      case Failure(errorResponse: final error):
        emit(BilltoShiptoAddressSelectionFailed());
    }
  }
}
