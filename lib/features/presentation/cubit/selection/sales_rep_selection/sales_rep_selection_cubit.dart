import 'package:commerce_flutter_app/features/domain/usecases/selection_usecase/selection_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/widget/selection_item_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'sales_rep_selection_state.dart';

class SalesRepSelectionCubit extends Cubit<SalesRepSelectionState> {
  final SelectionUsecase _selectionUsecase;

  SalesRepSelectionCubit({
    required SelectionUsecase selectionUsecase,
  })  : _selectionUsecase = selectionUsecase,
        super(const SalesRepSelectionState());

  Future<void> initialize({
    required CatalogTypeSelectingParameter parameter,
  }) async {
    emit(
      SalesRepSelectionState(
        status: SalesRepStatus.loading,
        selectedId: parameter.currentItem?.id,
      ),
    );

    final result = await _selectionUsecase.getSalesRepList(
      page: 1,
    );

    if (result == null) {
      emit(state.copyWith(status: SalesRepStatus.failiure));
      return;
    }

    emit(
      state.copyWith(
        status: SalesRepStatus.success,
        quoteResult: result,
        salesRepList: (result.salespersonList ?? [])
            .map(
              (salesRep) => CatalogTypeDto(
                id: salesRep.salespersonNumber,
                title: salesRep.name,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.quoteResult?.pagination?.page == null ||
        state.quoteResult!.pagination!.page! + 1 >
            state.quoteResult!.pagination!.numberOfPages!) {
      return;
    }

    emit(state.copyWith(status: SalesRepStatus.moreLoading));

    final result = await _selectionUsecase.getSalesRepList(
      page: state.quoteResult!.pagination!.page! + 1,
    );

    if (result == null) {
      emit(state.copyWith(status: SalesRepStatus.moreLoadingFailure));
      return;
    }

    final newSalesReps = state.quoteResult?.salespersonList;
    newSalesReps?.addAll(result.salespersonList ?? []);

    emit(
      state.copyWith(
        page: state.quoteResult!.pagination!.page! + 1,
        status: SalesRepStatus.moreLoadingSuccess,
        quoteResult: QuoteResult(
          salespersonList: newSalesReps,
          pagination: result.pagination,
        ),
        salesRepList: (newSalesReps ?? [])
            .map(
              (salesRep) => CatalogTypeDto(
                id: salesRep.salespersonNumber,
                title: salesRep.name,
              ),
            )
            .toList(),
      ),
    );
  }

  void setSelectedSalesRep({
    required CatalogTypeDto selectedSalesRep,
  }) {
    emit(
      state.copyWith(
        selectedId: selectedSalesRep.id,
      ),
    );
  }
}
