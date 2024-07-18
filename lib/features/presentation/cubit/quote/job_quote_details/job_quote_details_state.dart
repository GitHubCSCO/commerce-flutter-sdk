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

  const JobQuoteDetailsState({
    required this.status,
    required this.jobQuoteLines,
  });

  @override
  List<Object> get props => [
        status,
        jobQuoteLines,
      ];

  JobQuoteDetailsState copyWith({
    JobQuoteDetailsStatus? status,
    List<JobQuoteLine>? jobQuoteLines,
  }) {
    return JobQuoteDetailsState(
      status: status ?? this.status,
      jobQuoteLines: jobQuoteLines ?? this.jobQuoteLines,
    );
  }
}
