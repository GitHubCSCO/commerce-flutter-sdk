part of 'billto_shipto_address_selection_bloc.dart';

abstract class BilltoShiptoAddressSelectionEvent {}

class BilltoShiptoAddressLoadEvent extends BilltoShiptoAddressSelectionEvent {
  final String searchQuery;
  final int currentPage;
  final BillToShipToAddressSelectionEntity selectionEntity;

  BilltoShiptoAddressLoadEvent(
      {required this.searchQuery,
      required this.currentPage,
      required this.selectionEntity});
}
