part of 'domain_change_cubit.dart';

sealed class DomainChangeState extends Equatable {
  const DomainChangeState();

  @override
  List<Object> get props => [];
}

final class DomainChangeInitial extends DomainChangeState {}

final class DomainChangeInProgress extends DomainChangeState {}

final class DomainChangeSuccess extends DomainChangeState {
  final String domain;

  const DomainChangeSuccess(this.domain);

  @override
  List<Object> get props => [domain];
}
