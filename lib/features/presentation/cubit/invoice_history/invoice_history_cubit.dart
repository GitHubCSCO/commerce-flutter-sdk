import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/invoice_sort_order.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/invoice_status.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/invoice_usecase/invoice_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'invoice_history_state.dart';

class InvoiceHistoryCubit extends Cubit<InvoiceHistoryState> {
  final InvoiceUseCase _invoiceUseCase;

  InvoiceHistoryCubit({required InvoiceUseCase invoiceUseCase})
      : _invoiceUseCase = invoiceUseCase,
        super(
          InvoiceHistoryState(
            status: InvoiceStatus.initial,
            invoiceCollectionModel: GetInvoiceResult(),
            invoiceQueryParameters: InvoiceQueryParameters(
              page: 1,
              pageSize: CoreConstants.defaultPageSize,
              customerSequence: '-1',
            ),
            invoiceSortOrder: InvoiceSortOrder.invoiceDateDescending,
          ),
        );

  Future<void> changeSortOrder(InvoiceSortOrder invoiceSortOrder) async {
    final newQueryParameters = state.invoiceQueryParameters;
    newQueryParameters.sort = invoiceSortOrder.value;

    emit(
      state.copyWith(
        invoiceSortOrder: invoiceSortOrder,
        invoiceQueryParameters: newQueryParameters,
      ),
    );

    await loadInvoiceHistory();
  }

  Future<void> loadInvoiceHistory() async {
    final newQueryParameters = state.invoiceQueryParameters;
    newQueryParameters.page = 1;

    emit(
      state.copyWith(
        status: InvoiceStatus.loading,
      ),
    );

    final result = await _invoiceUseCase.loadInvoiceHistory(
      invoiceQueryParameters: newQueryParameters,
    );

    if (result == null) {
      final message = await _invoiceUseCase.getSiteMessage(
          SiteMessageConstants.nameMobileAppAlertCommunicationError,
          SiteMessageConstants.defaultMobileAppAlertCommunicationError);
      emit(
          state.copyWith(status: InvoiceStatus.failure, errorMessage: message));
      return;
    }

    final message = await _invoiceUseCase.getSiteMessage(
        SiteMessageConstants.nameInvoiceNoResultsMessage,
        SiteMessageConstants.defaultInvoiceNoResultsMessage);

    emit(
      state.copyWith(
          status: InvoiceStatus.success,
          invoiceCollectionModel: result,
          invoiceQueryParameters: newQueryParameters,
          errorMessage: (result.invoices ?? []).isEmpty ? message : ''),
    );
  }

  Future<void> loadMoreInvoiceHistory() async {
    if (state.invoiceCollectionModel.pagination?.page == null ||
        state.invoiceCollectionModel.pagination!.page! + 1 >
            state.invoiceCollectionModel.pagination!.numberOfPages!) {
      return;
    }

    emit(state.copyWith(status: InvoiceStatus.moreLoading));

    final newQueryParameters = state.invoiceQueryParameters;
    newQueryParameters.page =
        state.invoiceCollectionModel.pagination!.page! + 1;

    final result = await _invoiceUseCase.loadInvoiceHistory(
      invoiceQueryParameters: newQueryParameters,
    );

    if (result == null) {
      emit(state.copyWith(status: InvoiceStatus.moreLoadingFailure));
      return;
    }

    final newInvoices = state.invoiceCollectionModel.invoices;
    newInvoices?.addAll(result.invoices ?? []);

    emit(
      state.copyWith(
        status: InvoiceStatus.success,
        invoiceCollectionModel: GetInvoiceResult(
          invoices: newInvoices,
          pagination: result.pagination,
        ),
        invoiceQueryParameters: newQueryParameters,
      ),
    );
  }

  Future<void> applyFilter({
    String? invoiceNumber,
    String? poNumber,
    String? orderNumber,
    bool? showOpenOnly,
    DateTime? fromDate,
    DateTime? toDate,
    ShipTo? shipTo,
    String? customerSequence,
  }) async {
    final newInvoiceQueryParameter = state.invoiceQueryParameters;
    newInvoiceQueryParameter.invoiceNumber = invoiceNumber;
    newInvoiceQueryParameter.poNumber = poNumber;
    newInvoiceQueryParameter.orderNumber = orderNumber;
    newInvoiceQueryParameter.showOpenOnly = showOpenOnly;
    newInvoiceQueryParameter.fromDate = fromDate;
    newInvoiceQueryParameter.toDate = toDate;
    newInvoiceQueryParameter.shipTo = shipTo;
    newInvoiceQueryParameter.customerSequence = customerSequence;

    emit(
      state.copyWith(
        invoiceQueryParameters: newInvoiceQueryParameter,
      ),
    );

    await loadInvoiceHistory();
  }

  bool get hasFilter =>
      !state.invoiceQueryParameters.invoiceNumber.isNullOrEmpty ||
      !state.invoiceQueryParameters.poNumber.isNullOrEmpty ||
      !state.invoiceQueryParameters.orderNumber.isNullOrEmpty ||
      state.invoiceQueryParameters.customerSequence != '-1' ||
      state.invoiceQueryParameters.showOpenOnly == true ||
      state.invoiceQueryParameters.fromDate != null ||
      state.invoiceQueryParameters.toDate != null;
}
