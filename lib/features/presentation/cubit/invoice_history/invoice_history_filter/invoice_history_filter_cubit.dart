import 'package:commerce_flutter_app/features/domain/usecases/invoice_usecase/invoice_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'invoice_history_filter_state.dart';

class InvoiceHistoryFilterCubit extends Cubit<InvoiceHistoryFilterState> {
  final InvoiceUseCase _invoiceUseCase;

  InvoiceHistoryFilterCubit({required InvoiceUseCase invoiceUseCase})
      : _invoiceUseCase = invoiceUseCase,
        super(InvoiceHistoryFilterState());

  Future<void> initialize({
    required InvoiceQueryParameters invoiceQueryParameters,
  }) async {
    var newState = state.copyWith();
    newState.invoiceNumber = invoiceQueryParameters.invoiceNumber;
    newState.poNumber = invoiceQueryParameters.poNumber;
    newState.showOpenOnly = invoiceQueryParameters.showOpenOnly ?? false;
    newState.orderNumber = invoiceQueryParameters.orderNumber;
    newState.fromDate = invoiceQueryParameters.fromDate;
    newState.toDate = invoiceQueryParameters.toDate;
    newState.shipTo = invoiceQueryParameters.shipTo;
    newState.customerSequence = invoiceQueryParameters.customerSequence;
    newState.billTo = await _invoiceUseCase.getBillToAddress();

    emit(newState);
  }

  void reset() {
    emit(
      InvoiceHistoryFilterState(
        billTo: state.billTo,
      ),
    );
  }

  void setInvoiceNumber(String? invoiceNumber) {
    var newState = state.copyWith();
    newState.invoiceNumber = invoiceNumber;
    emit(newState);
  }

  void setPoNumber(String? poNumber) {
    var newState = state.copyWith();
    newState.poNumber = poNumber;
    emit(newState);
  }

  void toggleShowMyOrders() {
    emit(
      state.copyWith(
        showOpenOnly: !state.showOpenOnly,
      ),
    );
  }

  void setOrderNumber(String? orderNumber) {
    var newState = state.copyWith();
    newState.orderNumber = orderNumber;
    emit(newState);
  }

  void setFromDate(DateTime? fromDate) {
    var newState = state.copyWith();
    newState.fromDate = fromDate;
    emit(newState);
  }

  void setToDate(DateTime? toDate) {
    var newState = state.copyWith();
    newState.toDate = toDate;
    emit(newState);
  }

  void setShipTo(ShipTo? shipTo) {
    var newState = state.copyWith();
    newState.shipTo = shipTo;
    newState.customerSequence = shipTo?.customerSequence;
    emit(newState);
  }
}
