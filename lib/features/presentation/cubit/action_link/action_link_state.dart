part of 'action_link_cubit.dart';

@immutable
abstract class ActionLinkState {}

class ActionLinkInitialState extends ActionLinkState {}

class ActionLinkLoadingState extends ActionLinkState {}

class ActionLinkLoadedState extends ActionLinkState {
  final List<ActionLinkEntity> actions;

  ActionLinkLoadedState(this.actions);
}
