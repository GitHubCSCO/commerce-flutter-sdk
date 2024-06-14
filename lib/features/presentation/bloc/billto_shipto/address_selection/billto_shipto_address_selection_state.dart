part of 'billto_shipto_address_selection_bloc.dart';

abstract class BilltoShiptoAddressSelectionState {}

class BilltoShiptoAddressSelectionInitial extends BilltoShiptoAddressSelectionState {}

class BilltoShiptoAddressSelectionLoading extends BilltoShiptoAddressSelectionState {}

class BilltoShiptoAddressSelectionLoaded extends BilltoShiptoAddressSelectionState {

  final List<Address>? list;

  BilltoShiptoAddressSelectionLoaded({required this.list});

}

class BilltoShiptoAddressSelectionFailed extends BilltoShiptoAddressSelectionState {}
