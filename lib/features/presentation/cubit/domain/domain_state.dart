part of 'domain_cubit.dart';

sealed class DomainState extends Equatable {}

final class DomainUnknown extends DomainState {
  @override
  List<Object?> get props => [];
}

final class DomainOperationInProgress extends DomainState {
  @override
  List<Object?> get props => [];
}

final class DomainLoaded extends DomainState {
  final String domain;

  DomainLoaded(this.domain);

  @override
  List<Object?> get props => [domain];
}

final class DomainOperationFailed extends DomainState {
  final String title;
  final String message;

  DomainOperationFailed(this.title, this.message);

  @override
  List<Object?> get props => [title, message];
}

final class DomainOperationFailedOffline extends DomainOperationFailed {
  DomainOperationFailedOffline(super.title, super.message);

  @override
  List<Object?> get props => [title, message];
}

final class DomainOperationFailedInvalid extends DomainOperationFailed {
  DomainOperationFailedInvalid(super.message, super.title);

  @override
  List<Object?> get props => [title, message];
}

final class DomainOperationFailedMobileAppDisabled
    extends DomainOperationFailed {
  DomainOperationFailedMobileAppDisabled(super.title, super.message);

  @override
  List<Object?> get props => [title, message];
}
