// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quote_filter_cubit.dart';

class QuoteFilterState {
  BillTo? billTo;
  CatalogTypeDto? user;
  CatalogTypeDto? salesRep;
  String? customerId;
  String? quoteNumber;
  String? userId;
  String? salesRepNumber;
  DateTime? toDate;
  DateTime? fromDate;
  DateTime? expireFromDate;
  DateTime? expireToDate;
  List<String>? statuses;
  List<String>? types;

  QuoteFilterState({
    this.billTo,
    this.user,
    this.salesRep,
    this.customerId,
    this.quoteNumber,
    this.userId,
    this.salesRepNumber,
    this.toDate,
    this.fromDate,
    this.expireFromDate,
    this.expireToDate,
    this.statuses,
    this.types,
  });

  QuoteFilterState copyWith({
    BillTo? billTo,
    CatalogTypeDto? user,
    CatalogTypeDto? salesRep,
    String? customerId,
    String? quoteNumber,
    String? userId,
    String? salesRepNumber,
    DateTime? toDate,
    DateTime? fromDate,
    DateTime? expireFromDate,
    DateTime? expireToDate,
    List<String>? statuses,
    List<String>? types,
  }) {
    return QuoteFilterState(
      billTo: billTo ?? this.billTo,
      user: user ?? this.user,
      salesRep: salesRep ?? this.salesRep,
      customerId: customerId ?? this.customerId,
      quoteNumber: quoteNumber ?? this.quoteNumber,
      userId: userId ?? this.userId,
      salesRepNumber: salesRepNumber ?? this.salesRepNumber,
      toDate: toDate ?? this.toDate,
      fromDate: fromDate ?? this.fromDate,
      expireFromDate: expireFromDate ?? this.expireFromDate,
      expireToDate: expireToDate ?? this.expireToDate,
      statuses: statuses ?? this.statuses,
      types: types ?? this.types,
    );
  }
}
