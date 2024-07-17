part of 'sales_rep_selection_cubit.dart';

enum SalesRepStatus {
  initial,
  loading,
  success,
  failiure,
  moreLoading,
  moreLoadingFailure,
  moreLoadingSuccess,
}

class SalesRepSelectionState extends Equatable {
  final SalesRepStatus status;
  final List<CatalogTypeDto>? salesRepList;
  final int page;
  final QuoteResult? quoteResult;
  final String? selectedId;

  const SalesRepSelectionState({
    this.status = SalesRepStatus.initial,
    this.salesRepList,
    this.page = 1,
    this.quoteResult,
    this.selectedId,
  });

  @override
  List<Object> get props => [
        status,
        salesRepList ?? [],
        page,
        quoteResult ?? QuoteResult(),
        selectedId ?? '',
      ];

  SalesRepSelectionState copyWith({
    SalesRepStatus? status,
    List<CatalogTypeDto>? salesRepList,
    int? page,
    QuoteResult? quoteResult,
    String? selectedId,
  }) {
    return SalesRepSelectionState(
      status: status ?? this.status,
      salesRepList: salesRepList ?? this.salesRepList,
      page: page ?? this.page,
      quoteResult: quoteResult ?? this.quoteResult,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
