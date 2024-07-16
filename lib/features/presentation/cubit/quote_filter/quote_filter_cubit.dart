import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quote_filter_state.dart';

class QuoteFilterCubit extends Cubit<QuoteFilterState> {
  QuoteFilterCubit() : super(QuoteFilterState());

  void initialize({
    required QuoteQueryParameters quoteQueryParameters,
  }) async {
    var newState = state.copyWith();
    newState.billTo = quoteQueryParameters.billTo;
    newState.user = quoteQueryParameters.selectedUser;
    newState.salesRep = quoteQueryParameters.selectedSalesRep;
    newState.customerId = quoteQueryParameters.customerId;
    newState.quoteNumber = quoteQueryParameters.quoteNumber;
    newState.userId = quoteQueryParameters.userId;
    newState.salesRepNumber = quoteQueryParameters.salesRepNumber;
    newState.fromDate = quoteQueryParameters.fromDate;
    newState.toDate = quoteQueryParameters.toDate;
    newState.expireFromDate = quoteQueryParameters.expireFromDate;
    newState.expireToDate = quoteQueryParameters.expireToDate;
    newState.statuses = quoteQueryParameters.statuses;
    newState.types = quoteQueryParameters.types;

    emit(newState);
  }

  void reset() {
    emit(QuoteFilterState());
  }

  void setBillTo(BillTo? billTo) {
    var newState = state.copyWith();
    newState.billTo = billTo;
    newState.customerId = billTo?.id;
    emit(newState);
  }

  void setUser(CatalogTypeDto? user) {
    var newState = state.copyWith();
    newState.user = user;
    newState.userId = user?.id;
    emit(newState);
  }

  void setSalesRep(CatalogTypeDto? salesRep) {
    var newState = state.copyWith();
    newState.salesRep = salesRep;
    newState.salesRepNumber = salesRep?.id;
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

  void setExpireFromDate(DateTime? expireFromDate) {
    var newState = state.copyWith();
    newState.expireFromDate = expireFromDate;
    emit(newState);
  }

  void setExpireToDate(DateTime? expireToDate) {
    var newState = state.copyWith();
    newState.expireToDate = expireToDate;
    emit(newState);
  }

  void setQuoteNumber(String? quoteNumber) {
    var newState = state.copyWith();
    newState.quoteNumber = quoteNumber;
    emit(newState);
  }

  void setStatuses(String status) {
    var newState = state.copyWith();
    newState.statuses = [status];
    emit(newState);
  }

  void setTypes(String type) {
    var newState = state.copyWith();
    newState.types = [type];
    emit(newState);
  }
}
