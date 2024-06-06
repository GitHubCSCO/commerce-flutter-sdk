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
  Warehouse? pickUpWarehouse;
  bool? hasWillCall;

  BillToShipToBloc({required BillToShipToUseCase billToShipToUseCase})
      : _billToShipToUseCase = billToShipToUseCase,
        super(BillToShipToInitial()) {
    on<BillToShipToLoadEvent>(
        (event, emit) => _onBillToShipToLoadEvent(event, emit));
  }

  Future<void> _onBillToShipToLoadEvent(
      BillToShipToLoadEvent event, Emitter<BillToShipToState> emit) async {
    emit(BillToShipToLoading());

    final session = await _billToShipToUseCase.getCurrentSession();
    billToAddress = session.billTo;
    pickUpWarehouse = session.pickUpWarehouse;

    hasWillCall = await _billToShipToUseCase.hasWillCall();

    if (hasWillCall != null &&
        hasWillCall! &&
        session.fulfillmentMethod == FulfillmentMethodType.PickUp.name) {
      recipientAddress = session.shipTo;
    } else {
      shipToAddress = session.shipTo;
    }

    emit(BillToShipToLoaded(
        billToAddress: billToAddress,
        shipToAddress: shipToAddress,
        recipientAddress: recipientAddress,
        pickUpWarehouse: pickUpWarehouse,
        hasWillCall: hasWillCall!));
  }
}
