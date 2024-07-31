part of 'job_quote_details_cubit.dart';

class JobQuoteDetailsState extends Equatable {
  final JobQuoteDetailsStatus status;
  final List<JobQuoteLine> jobQuoteLines;
  final List<int> jobOrderQty;
  final bool isGenerateOrderEnabled;
  final Cart cart;

  const JobQuoteDetailsState({
    required this.status,
    required this.jobQuoteLines,
    required this.jobOrderQty,
    required this.isGenerateOrderEnabled,
    required this.cart,
  });

  @override
  List<Object> get props => [
        status,
        jobQuoteLines,
        jobOrderQty,
        isGenerateOrderEnabled,
        cart,
      ];

  JobQuoteDetailsState copyWith({
    JobQuoteDetailsStatus? status,
    List<JobQuoteLine>? jobQuoteLines,
    List<int>? jobOrderQty,
    bool? isGenerateOrderEnabled,
    Cart? cart,
  }) {
    return JobQuoteDetailsState(
      status: status ?? this.status,
      jobQuoteLines: jobQuoteLines ?? this.jobQuoteLines,
      jobOrderQty: jobOrderQty ?? this.jobOrderQty,
      isGenerateOrderEnabled:
          isGenerateOrderEnabled ?? this.isGenerateOrderEnabled,
      cart: cart ?? this.cart,
    );
  }
}
