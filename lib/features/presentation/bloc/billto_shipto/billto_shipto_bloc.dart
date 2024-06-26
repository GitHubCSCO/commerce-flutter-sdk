import 'package:commerce_flutter_app/features/domain/enums/fullfillment_method_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/billto_shipto_usecase/billto_shipto_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'billto_shipto_event.dart';

part 'billto_shipto_state.dart';

class BillToShipToBloc extends Bloc<BillToShipToEvent, BillToShipToState> {
  final BillToShipToUseCase _billToShipToUseCase;
  BillTo? billToAddress;
  ShipTo? shipToAddress;
  ShipTo? recipientAddress;
  ShipTo? shipToRecipientAddress;
  Warehouse? pickUpWarehouse;
  FulfillmentMethodType? selectedShippingMethod;
  bool hasWillCall = false;
  bool wasShipToUpdated = false;
  bool isDefaultCustomerSelected = false;
  bool? isDefaultSwitchEnable = false;

  BillToShipToBloc({required BillToShipToUseCase billToShipToUseCase})
      : _billToShipToUseCase = billToShipToUseCase,
        super(BillToShipToInitial()) {
    on<BillToShipToLoadEvent>(
        (event, emit) => _onBillToShipToLoadEvent(event, emit));
    on<BillToUpdateEvent>((event, emit) => _onBillToUpdateEvent(event, emit));
    on<ShipToUpdateEvent>((event, emit) => _onShipToUpdateEvent(event, emit));
    on<PickUpUpdateEvent>((event, emit) => _onPickUpUpdateEvent(event, emit));
    on<FulfillmentMethodUpdateEvent>((event, emit) => _onFulfillmentMethodUpdateEvent(event, emit));
    on<SaveBillToShipToEvent>(
        (event, emit) => _onSaveBillToShipToEvent(event, emit));
  }

  Future<void> _onBillToUpdateEvent(
      BillToUpdateEvent event, Emitter<BillToShipToState> emit) async {
    emit(BillToShipToLoading());
    wasShipToUpdated = true;
    billToAddress = event.billToAddress;
    shipToAddress = null;
    recipientAddress = null;
    emit(BillToShipToLoaded(
        billToAddress: billToAddress,
        shipToAddress: shipToAddress,
        recipientAddress: recipientAddress,
        pickUpWarehouse: pickUpWarehouse,
        selectedShippingMethod: selectedShippingMethod,
        hasWillCall: hasWillCall));
  }

  Future<void> _onShipToUpdateEvent(
      ShipToUpdateEvent event, Emitter<BillToShipToState> emit) async {
    emit(BillToShipToLoading());
    wasShipToUpdated = true;
    if (selectedShippingMethod == FulfillmentMethodType.PickUp) {
      recipientAddress = event.shipToAddress;
    } else if (selectedShippingMethod == FulfillmentMethodType.Ship) {
      shipToAddress = event.shipToAddress;
    }
    emit(BillToShipToLoaded(
        billToAddress: billToAddress,
        shipToAddress: shipToAddress,
        recipientAddress: recipientAddress,
        pickUpWarehouse: pickUpWarehouse,
        selectedShippingMethod: selectedShippingMethod,
        hasWillCall: hasWillCall));
  }

  Future<void> _onPickUpUpdateEvent(
      PickUpUpdateEvent event, Emitter<BillToShipToState> emit) async {
    emit(BillToShipToLoading());
    pickUpWarehouse = event.warehouse;
    selectedShippingMethod = FulfillmentMethodType.PickUp;
    emit(BillToShipToLoaded(
        billToAddress: billToAddress,
        shipToAddress: shipToAddress,
        recipientAddress: recipientAddress,
        pickUpWarehouse: pickUpWarehouse,
        selectedShippingMethod: selectedShippingMethod,
        hasWillCall: hasWillCall));
  }

  Future<void> _onBillToShipToLoadEvent(
      BillToShipToLoadEvent event, Emitter<BillToShipToState> emit) async {
    emit(BillToShipToLoading());
    final session = await _billToShipToUseCase.getCurrentSession();
    if(session==null){
      emit(BillToShipToFailed());
    }else{
      billToAddress = session.billTo;
      pickUpWarehouse = session.pickUpWarehouse;

      hasWillCall = await _billToShipToUseCase.hasWillCall();
      isDefaultCustomerSelected =
          await _billToShipToUseCase.isDefaultCustomerSelected(
              selectedShippingMethod ?? FulfillmentMethodType.Ship,
              wasShipToUpdated);
      isDefaultSwitchEnable = isDefaultCustomerSelected;

      if (hasWillCall && session.fulfillmentMethod == FulfillmentMethodType.PickUp.name) {
        recipientAddress = session.shipTo;
        selectedShippingMethod = FulfillmentMethodType.PickUp;
      } else {
        shipToAddress = session.shipTo;
        selectedShippingMethod = FulfillmentMethodType.Ship;
      }

      emit(BillToShipToLoaded(
        billToAddress: billToAddress,
        shipToAddress: shipToAddress,
        recipientAddress: recipientAddress,
        pickUpWarehouse: pickUpWarehouse,
        selectedShippingMethod: selectedShippingMethod,
        hasWillCall: hasWillCall,
        isDefaultCustomerSelected: isDefaultCustomerSelected,
      ));
    }
  }

  void _onFulfillmentMethodUpdateEvent(
      FulfillmentMethodUpdateEvent event, Emitter<BillToShipToState> emit) {
    selectedShippingMethod = event.fulfillmentMethodType;
  }

  Future<void> _onSaveBillToShipToEvent(
      SaveBillToShipToEvent event, Emitter<BillToShipToState> emit) async {
    emit(BillToShipToLoading());

    if (selectedShippingMethod == FulfillmentMethodType.PickUp) {
      shipToRecipientAddress = recipientAddress;
    } else if (selectedShippingMethod == FulfillmentMethodType.Ship) {
      shipToRecipientAddress = shipToAddress;
    }

    var patchedSession = await _billToShipToUseCase.updateCurrentSession(
      billToAddress: billToAddress, 
      shipToRecipientAddress:  shipToRecipientAddress,
      pickUpWarehouse: pickUpWarehouse, 
      selectedShippingMethod: selectedShippingMethod);

    if (event.isDefaultEnable) {
      await _billToShipToUseCase.updateDefaultCustomerIfNeeded(
          event.isDefaultEnable,
          isDefaultCustomerSelected,
          selectedShippingMethod ?? FulfillmentMethodType.Ship,
          wasShipToUpdated);
    }

    if (patchedSession != null) {
      emit(SaveBillToShipToSuccess());
    } else {
      emit(SaveBillToShipToFailed());
    }
  }

  bool saveButtonEnable({FulfillmentMethodType? fulfillmentMethodType}) {
    final type = fulfillmentMethodType ?? selectedShippingMethod;

    if (type == FulfillmentMethodType.PickUp) {
      return recipientAddress != null && pickUpWarehouse != null;
    } else {
      return shipToAddress != null;
    }
  }

  bool defaultEnable(bool isSwitch) {
    if (isDefaultSwitchEnable != null) {
      bool isEnable = isDefaultSwitchEnable ?? false;
      isDefaultSwitchEnable = null;
      return isEnable;
    } else {
      return isSwitch;
    }
  }

}
