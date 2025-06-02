import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quote_usecase/quote_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quote_filter_state.dart';

enum QuoteType {
  job,
  quote,
  ;

  @override
  String toString() {
    switch (this) {
      case QuoteType.job:
        return 'Job';
      case QuoteType.quote:
        return 'Quote';
    }
  }
}

class QuoteFilterCubit extends Cubit<QuoteFilterState> {
  final QuoteUsecase _quoteUsecase;
  QuoteFilterCubit({
    required QuoteUsecase quoteUseCase,
  })  : _quoteUsecase = quoteUseCase,
        super(QuoteFilterState());

  List<(String, String)> statuses = [];
  List<(String, String)> types = [
    (
      LocalizationConstants.selectQuoteType.localized(),
      LocalizationConstants.selectQuoteType.localized(),
    ),
    (
      LocalizationConstants.salesQuotes.localized(),
      QuoteType.quote.toString(),
    ),
    (
      LocalizationConstants.jobQuotes.localized(),
      QuoteType.job.toString(),
    ),
  ];

  Session? session;

  Future<void> initialize({
    required QuoteQueryParameters quoteQueryParameters,
  }) async {
    emit(state.copyWith(quoteFilterStatus: QuoteFilterStatus.loading));

    session = await _quoteUsecase.getSession();

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
    newState.types = quoteQueryParameters.types;
    newState.isSalesPerson = session?.isSalesPerson ?? false;

    statuses = [
      (
        LocalizationConstants.selectStatus.localized(),
        LocalizationConstants.selectStatus.localized()
      ),
      ...[
        (
          LocalizationConstants.requested.localized(),
          'QuoteRequested',
        ),
        (
          LocalizationConstants.proposed.localized(),
          'QuoteProposed',
        ),
      ],
    ];

    if (newState.isSalesPerson) {
      statuses.insert(
        1,
        (
          LocalizationConstants.created.localized(),
          'QuoteCreated',
        ),
      );
      statuses.add(
        (
          LocalizationConstants.rejected.localized(),
          'QuoteRejected',
        ),
      );
    }

    final statusItem = statuses.firstWhere(
      (element) => element.$2 == quoteQueryParameters.statuses?.first,
      orElse: () => statuses.first,
    );

    newState.statusIndex = statuses.indexOf(statusItem);
    newState.statuses =
        statusItem.$2 != statuses.first.$2 ? [statusItem.$2] : null;

    final typeItem = types.firstWhere(
      (element) => element.$2 == quoteQueryParameters.types?.first,
      orElse: () => types.first,
    );

    newState.typeIndex = types.indexOf(typeItem);
    newState.types = typeItem.$2 != types.first.$2 ? [typeItem.$2] : null;

    emit(newState.copyWith(quoteFilterStatus: QuoteFilterStatus.success));
  }

  Future<void> reset() async {
    await initialize(quoteQueryParameters: QuoteQueryParameters());
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

    final statusItem = statuses.firstWhere(
      (element) => element.$1 == status,
      orElse: () => statuses.first,
    );

    newState.statusIndex = statuses.indexOf(statusItem);
    newState.statuses =
        statusItem.$2 != statuses.first.$2 ? [statusItem.$2] : null;

    emit(newState);
  }

  void setTypes(String type) {
    var newState = state.copyWith();

    final typeItem = types.firstWhere(
      (element) => element.$1 == type,
      orElse: () => types.first,
    );

    newState.typeIndex = types.indexOf(typeItem);
    newState.types = typeItem.$2 != types.first.$2 ? [typeItem.$2] : null;

    emit(newState);
  }

  List<String> get statusList => statuses.map((e) => e.$1).toList();

  List<String> get typeList => types.map((e) => e.$1).toList();
}
