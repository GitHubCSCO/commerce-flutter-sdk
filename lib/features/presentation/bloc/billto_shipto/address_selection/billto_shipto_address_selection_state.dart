part of 'billto_shipto_address_selection_bloc.dart';

class BilltoShiptoAddressSelectionState extends Equatable {
  final List<Address>? list;
  final Pagination? pagination;
  final StateStatus status;

  BilltoShiptoAddressSelectionState({
    required this.list,
    required this.pagination,
    required this.status,
  });

  BilltoShiptoAddressSelectionState copyWith({
    List<Address>? list,
    Pagination? pagination,
    StateStatus? status,
  }) {
    return BilltoShiptoAddressSelectionState(
      list: list ?? this.list,
      pagination: pagination ?? this.pagination,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [list, pagination, status];
}
