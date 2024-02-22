part of 'domain_selection_cubit.dart';

sealed class DomainSelectionState extends Equatable {}

final class DomainSelectionInitial extends DomainSelectionState {
  @override
  List<Object?> get props => [];
}

final class DomainSelectionInProgress extends DomainSelectionState {
  @override
  List<Object?> get props => [];
}

final class DomainSelectionSuccess extends DomainSelectionState {
  @override
  List<Object?> get props => [];
}

final class DomainSelectionFailed extends DomainSelectionState {
  final String title;
  final String message;

  DomainSelectionFailed(this.title, this.message);

  @override
  List<Object?> get props => [title, message];
}

final class DomainSelectionFailedOffline extends DomainSelectionFailed {
  DomainSelectionFailedOffline(super.title, super.message);

  @override
  List<Object?> get props => [title, message];
}

final class DomainSelectionFailedInvalid extends DomainSelectionFailed {
  DomainSelectionFailedInvalid(super.message, super.title);

  @override
  List<Object?> get props => [title, message];
}

final class DomainSelectionFailedMobileAppDisabled
    extends DomainSelectionFailed {
  DomainSelectionFailedMobileAppDisabled(super.title, super.message);

  @override
  List<Object?> get props => [title, message];
}
