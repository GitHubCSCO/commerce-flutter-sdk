part of 'billto_shipto_bloc.dart';

abstract class BillToShipToState {}

class BillToShipToInitial extends BillToShipToState {}

class BillToShipToLoading extends BillToShipToState {}

class BillToShipToLoaded extends BillToShipToState {
  BillTo? billToAddress;
  ShipTo? shipToAddress;
  ShipTo? recipientAddress;
  Warehouse? pickUpWarehouse;
  bool hasWillCall;

  BillToShipToLoaded(
      {required this.billToAddress,
      required this.shipToAddress,
      required this.recipientAddress,
      required this.pickUpWarehouse,
      required this.hasWillCall});
}

class BillToShipToFailed extends BillToShipToState {}

class SaveBillToShipToSuccess extends BillToShipToState {}

class SaveBillToShipToFailed extends BillToShipToState {}
