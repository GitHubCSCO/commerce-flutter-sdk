part of 'job_quote_details_cubit.dart';

enum JobQuoteDetailsStatus {
  initial,
  loading,
  loaded,
  failure,
}

class JobQuoteDetailsState extends Equatable {
  final JobQuoteDetailsStatus status;
  final List<JobQuoteLine> jobQuoteLines;
  final List<int> jobOrderQty;

  const JobQuoteDetailsState({
    required this.status,
    required this.jobQuoteLines,
    required this.jobOrderQty,
  });

  @override
  List<Object> get props => [
        status,
        jobQuoteLines,
      ];

  JobQuoteDetailsState copyWith({
    JobQuoteDetailsStatus? status,
    List<JobQuoteLine>? jobQuoteLines,
    List<int>? jobOrderQty,
  }) {
    return JobQuoteDetailsState(
      status: status ?? this.status,
      jobQuoteLines: jobQuoteLines ?? this.jobQuoteLines,
      jobOrderQty: jobOrderQty ?? this.jobOrderQty,
    );
  }
}
